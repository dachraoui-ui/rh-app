package com.rh_app.hr_app.features.ticket.service;

import com.rh_app.hr_app.core.enums.ticket_enums.TicketPriority;
import com.rh_app.hr_app.core.enums.ticket_enums.TicketStatus;
import com.rh_app.hr_app.features.ticket.dto.TicketDto;
import com.rh_app.hr_app.features.ticket.mapper.TicketMapper;
import com.rh_app.hr_app.features.ticket.model.Ticket;
import com.rh_app.hr_app.features.ticket.repository.TicketRepo;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.Instant;

@Slf4j
@Service
@RequiredArgsConstructor
public class TicketService {

    private final TicketRepo repo;

    /* ─────────────────────────────
       #1  CREATE (Employee)
       ───────────────────────────── */
    public TicketDto create(TicketDto payload, String creatorUsername) {
        Ticket entity = TicketMapper.toEntityForCreate(payload, creatorUsername, Instant.now());
        /* server rule: default OPEN */
        if (entity.getStatus() == null) {
            entity.setStatus(TicketStatus.OPEN);
        }
        Ticket saved = repo.save(entity);
        return TicketMapper.toDto(saved);
    }

    /* ─────────────────────────────
       #2  READ
       ───────────────────────────── */
    public TicketDto findById(Long id) {
        return TicketMapper.toDto(repo.findById(id).orElseThrow());
    }

    /* ─ Employee: my own tickets (paged) */
    public Page<TicketDto> listMine(String username, Pageable page) {
        return repo.findByCreatedByOrderByCreatedAtDesc(username, page)
                .map(TicketMapper::toDto);
    }

    /* ─ GRH: tickets assigned to me */
    public Page<TicketDto> listAssigned(String grhUser, Pageable page) {
        return repo.findByAssignedToOrderByPriorityDescCreatedAtAsc(grhUser, page)
                .map(TicketMapper::toDto);
    }

    /* ─────────────────────────────
       #3  WORKFLOW / PATCH (GRH, DRH)
       ───────────────────────────── */
    @Transactional
    public TicketDto applyWorkflowPatch(Long id, TicketDto patch, String editorUsername) {
        Ticket entity = repo.findById(id).orElseThrow();
        TicketMapper.applyPatch(patch, entity, editorUsername);
        /* flush & return */
        return TicketMapper.toDto(entity);
    }

    /* ─────────────────────────────
       #4  SIMPLE KPI HELPERS
       ───────────────────────────── */
    public long countByStatus(TicketStatus status) {
        return repo.countByStatus(status);
    }

    public long countHighUrgencyOpen() {
        return   repo.countByStatusAndPriority(TicketStatus.OPEN,  TicketPriority.HIGH)
                + repo.countByStatusAndPriority(TicketStatus.OPEN,  TicketPriority.CRITICAL);
    }

    /* ─────────────────────────────
       #5  ESCALATION SCHEDULER
       ─────────────────────────────
       Runs hourly (cron) and escalates any OPEN
       tickets older than "slaOverdueHours".
       ───────────────────────────── */
    @Value("${tickets.sla.overdue-hours}")  // injected from application.yml
    private long slaOverdueHours;

    @Scheduled(cron = "0 0 * * * *")   // top of every hour
    @Transactional
    public void escalateOverdueTickets() {
        Instant threshold = Instant.now().minus(Duration.ofHours(slaOverdueHours));
        var overdue = repo.findByStatusAndCreatedAtBefore(TicketStatus.OPEN, threshold);

        overdue.forEach(t -> {
            t.setStatus(TicketStatus.ESCALATED);
            log.info("Ticket [{}] escalated (opened {})", t.getId(), t.getCreatedAt());
        });
        // flush happens automatically at Tx commit
    }

    /* ─────────────────────────────
       #6  DELETE (optional, admin only)
       ───────────────────────────── */
    public void delete(Long id) {
        repo.deleteById(id);
    }
}
