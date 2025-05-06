/* src/main/java/com/rh_app/hr_app/features/ticket/service/TicketService.java */
package com.rh_app.hr_app.features.ticket.service;

import com.rh_app.hr_app.core.enums.ticket_enums.*;
import com.rh_app.hr_app.features.department.model.Department;
import com.rh_app.hr_app.features.department.repository.DepartmentRepository;
import com.rh_app.hr_app.features.ticket.dto.*;
import com.rh_app.hr_app.features.ticket.mapper.TicketMapper;
import com.rh_app.hr_app.features.ticket.model.Ticket;
import com.rh_app.hr_app.features.ticket.model.TicketAttachment;
import com.rh_app.hr_app.features.ticket.repository.TicketRepository;

import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.time.*;
import java.util.List;
import java.util.NoSuchElementException;

@Slf4j
@Service
@RequiredArgsConstructor
public class TicketService {

    private final TicketRepository     ticketRepo;
    private final DepartmentRepository deptRepo;

    /* ────────────────────────────────────────────────────────────────
       1) EMPLOYEE — create ticket (≤ 5 / month)
       ──────────────────────────────────────────────────────────────── */
    @Transactional
    public TicketDto createTicket(String           employeeId,
                                  TicketCreateDto  dto,
                                  List<MultipartFile> files) {

        /* 1️⃣ enforce monthly quota (5) */
        YearMonth ym        = YearMonth.now(ZoneId.systemDefault());
        Instant   monthFrom = ym.atDay(1).atStartOfDay(ZoneId.systemDefault()).toInstant();
        Instant   monthTo   = ym.plusMonths(1).atDay(1).atStartOfDay(ZoneId.systemDefault()).toInstant();

        long existing = ticketRepo.countByCreatedByAndCreatedAtBetween(
                employeeId, monthFrom, monthTo);
        if (existing >= 5) {
            throw new IllegalStateException("Monthly ticket limit reached (5)");
        }

        /* 2️⃣ validate department */
        Department dept = deptRepo.findById(dto.departmentId())
                .orElseThrow(() -> new NoSuchElementException("Department not found"));

        /* 3️⃣ build entity */
        Ticket entity = TicketMapper.toEntityForCreate(dto, dept, employeeId);

        /* 4️⃣ optional attachments */
        if (files != null && !files.isEmpty()) {
            for (MultipartFile f : files) {
                try {
                    TicketAttachment a = new TicketAttachment();
                    a.setTicket(entity);
                    a.setOriginalName(f.getOriginalFilename());
                    a.setMimeType(f.getContentType());
                    a.setSize(f.getSize());
                    a.setUploadedBy(employeeId);
                    a.setData(f.getBytes());         // beware of very large uploads!
                    entity.getAttachments().add(a);
                } catch (IOException ioe) {
                    throw new UncheckedIOException("Cannot read attachment", ioe);
                }
            }
        }

        return TicketMapper.toDto(ticketRepo.save(entity));
    }

    /* ────────────────────────────────────────────────────────────────
       2) GRH / MANAGER / SUPPORT — update ticket
       ──────────────────────────────────────────────────────────────── */
    @Transactional
    public TicketDto updateTicket(Long            id,
                                  TicketUpdateDto upd,
                                  String          currentUserId,
                                  boolean         isGrh,
                                  boolean         isManager,
                                  boolean         isSupport) {

        Ticket t = ticketRepo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Ticket not found"));

        /* basic authorisation */
        if (!isGrh) {                               // GRH has full power
            boolean assignee = currentUserId.equals(t.getAssignedTo());
            if (!assignee) {
                throw new SecurityException("Not allowed to modify this ticket");
            }
            if (upd.getAssignedTo() != null) {
                throw new SecurityException("Only GRH may re-assign ");
            }
            if (upd.getStatus() == TicketStatus.CLOSED || upd.getStatus() == TicketStatus.ARCHIVED) {
                throw new SecurityException("Only GRH may close a ticket or archive it ");
            }
        }

        /* map DTO fields into the managed entity */
        TicketMapper.applyUpdate(upd, t);

        /* stamp resolution moment if just marked RESOLVED */
        if (upd.getStatus() == TicketStatus.RESOLVED) {
            t.setResolvedAt(Instant.now());
        }

        /* entity is managed → automatic flush */
        return TicketMapper.toDto(t);
    }

    public TicketDto findById(Long id) {
        Ticket ticket = ticketRepo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Ticket not found"));
        return TicketMapper.toDto(ticket);
    }
    /**
     * Get the count of tickets created by the employee in the current month
     * Used to show remaining quota in the UI
     * @param employeeId The employee ID (Keycloak user ID)
     * @return The count of tickets created in the current month
     */
    public long getUserMonthlyTicketCount(String employeeId) {
        YearMonth ym = YearMonth.now(ZoneId.systemDefault());
        Instant monthFrom = ym.atDay(1).atStartOfDay(ZoneId.systemDefault()).toInstant();
        Instant monthTo = ym.plusMonths(1).atDay(1).atStartOfDay(ZoneId.systemDefault()).toInstant();

        return ticketRepo.countByCreatedByAndCreatedAtBetween(
                employeeId, monthFrom, monthTo);
    }

    /* ────────────────────────────────────────────────────────────────
       3) EMPLOYEE — reopen own ticket
       ──────────────────────────────────────────────────────────────── */
    @Transactional
    public TicketDto reopen(Long id, String employeeId) {

        Ticket t = ticketRepo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Ticket not found"));

        if (!employeeId.equals(t.getCreatedBy())) {
            throw new SecurityException("Only the creator may reopen");
        }

        if (!t.getStatus().equals("CLOSED") && !t.getStatus().equals("RESOLVED")) {
            throw new IllegalStateException("Ticket is not closed/resolved");
        }

        t.setStatus("OPEN");
        t.setReopenCount((short) (t.getReopenCount() + 1));
        t.setResolvedAt(null);

        return TicketMapper.toDto(t);
    }

    /* ────────────────────────────────────────────────────────────────
       4) background escalation (every 30 minutes)
       ──────────────────────────────────────────────────────────────── */
    @Scheduled(cron = "0 */30 * * * *")   // :00 and :30 each hour
    @Transactional
    public void escalateAgingTickets() {

        Instant now          = Instant.now();
        Instant fortyEightHr = now.minus(Duration.ofHours(48));
        Instant seventyTwoHr = now.minus(Duration.ofHours(72));

        /* 48 h → Manager */
        ticketRepo.findEscalatable(0, fortyEightHr).forEach(t -> {
            t.setAssignedTo(t.getDepartment().getManagerUserId());
            t.setEscalationLevel(1);
            log.info("Escalated ticket #{} → Manager {}", t.getId(), t.getAssignedTo());
            // NotificationService.notifyManager(t) … (to be wired)
        });

        /* 72 h → DRH */
        ticketRepo.findEscalatable(1, seventyTwoHr).forEach(t -> {
            t.setAssignedTo("DRH");                      // or a user-id
            t.setEscalationLevel(2);
            log.warn("Escalated ticket #{} → DRH", t.getId());
            // NotificationService.notifyDrh(t) … (to be wired)
        });
    }
    /* ────────────────────────────────────────────────────────────────
       5)  LISTING HELPERS
       ──────────────────────────────────────────────────────────────── */

    /** EMPLOYEE – list my own tickets (any status). */
    @Transactional(readOnly = true)
    public Page<TicketDto> findMyTickets(String employeeId, Pageable page) {
        return ticketRepo.findByCreatedByOrderByCreatedAtDesc(employeeId, page)
                .map(TicketMapper::toDto);
    }

    /** SUPPORT / MANAGER / GRH / DRH – list tickets assigned to me. */
    @Transactional(readOnly = true)
    public Page<TicketDto> findAssignedToMe(String userId, Pageable page) {
        return ticketRepo.findByAssignedToOrderByCreatedAtAsc(userId, page)
                .map(TicketMapper::toDto);
    }

    /** GRH / DRH – list all tickets (optionally filter by status). */
    @Transactional(readOnly = true)
    public Page<TicketDto> findAllTickets(String status /* nullable */,
                                          Pageable page) {
        return ticketRepo.findAllWithOptionalStatus(status, page)
                .map(TicketMapper::toDto);
    }
    /**
     * Get attachment data for download
     * @param ticketId The ticket ID
     * @param attachmentId The attachment ID
     * @return TicketAttachment entity containing the attachment data
     * @throws NoSuchElementException if ticket or attachment not found
     * @throws SecurityException if user doesn't have permission
     */
    @Transactional
    public TicketAttachment getAttachmentForDownload(Long ticketId, Long attachmentId) {
        Ticket ticket = ticketRepo.findById(ticketId)
                .orElseThrow(() -> new NoSuchElementException("Ticket not found"));

        // Find the specific attachment in the ticket's attachments
        return ticket.getAttachments().stream()
                .filter(a -> a.getId().equals(attachmentId))
                .findFirst()
                .orElseThrow(() -> new NoSuchElementException("Attachment not found"));
    }


    /* ────────────────────────────────────────────────────────────────
       7 KPI queries
       ──────────────────────────────────────────────────────────────── */
    // Average hours to close for one department
    public double avgResolutionHours(Long deptId) {
        return ticketRepo.avgResolutionHoursForDepartment(deptId);
    }

    // Average hours to close for an individual resolver
    public double avgResolutionHoursForUser(String userId) {
        return ticketRepo.avgResolutionHoursForAgent(userId);
    }

    // How many tickets user X closed between two dates
    public long ticketsClosedByUser(String userId, Instant from, Instant to) {
        return ticketRepo.countByAssignedToAndStatusAndResolvedAtBetween(
                userId, "CLOSED", from, to);
    }

    // Re-opened tickets in a department
    public long reopenedInDepartment(Long deptId) {
        return ticketRepo.reopenedCountForDepartment(deptId);
    }
}
