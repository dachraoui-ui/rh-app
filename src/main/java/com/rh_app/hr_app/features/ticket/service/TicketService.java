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

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
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
import java.sql.Timestamp;
import java.time.*;
import java.util.HashSet;
import java.util.List;
import java.util.NoSuchElementException;

@Slf4j
@Service
@RequiredArgsConstructor
public class TicketService {

    private final TicketRepository     ticketRepo;
    private final DepartmentRepository deptRepo;
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @PersistenceContext
    private EntityManager em;


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

        });

        /* 72 h → DRH */
        ticketRepo.findEscalatable(1, seventyTwoHr).forEach(t -> {
            t.setAssignedTo("DRH");                      // or a user-id
            t.setEscalationLevel(2);
            log.warn("Escalated ticket #{} → DRH", t.getId());
        });
    }
    /* ────────────────────────────────────────────────────────────────
   TICKET STATUS MANAGEMENT
   ──────────────────────────────────────────────────────────────── */
    @Transactional
    public TicketDto changeTicketStatus(Long id,
                                        TicketStatus newStatus,
                                        String currentUserId,
                                        boolean isGrh,
                                        boolean isManager,
                                        boolean isSupport) {

        Ticket ticket = ticketRepo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Ticket not found"));

        // Check if user has permission to change to this status
        if (!isGrh) {
            // Only GRH/DRH can close or archive tickets
            if (newStatus == TicketStatus.CLOSED || newStatus == TicketStatus.ARCHIVED) {
                throw new SecurityException("Only GRH or DRH may close or archive tickets");
            }

            // For other statuses, user must be the assignee
            boolean isAssignee = currentUserId.equals(ticket.getAssignedTo());
            if (!isAssignee) {
                throw new SecurityException("Not allowed to modify this ticket");
            }
        }

        // Update the ticket status
        ticket.setStatus(mapStatusToString(newStatus));

        // Additional logic specific to each status
        switch (newStatus) {
            case RESOLVED:
                ticket.setResolvedAt(Instant.now());
                break;
            case CLOSED:
                // If it wasn't already resolved, set resolved timestamp
                if (ticket.getResolvedAt() == null) {
                    ticket.setResolvedAt(Instant.now());
                }
                break;
            case ARCHIVED:
                // Ensure the ticket is closed before archiving
                if (!ticket.getStatus().equals(mapStatusToString(TicketStatus.CLOSED))) {
                    throw new IllegalStateException("Ticket must be closed before archiving");
                }
                break;
        }

        return TicketMapper.toDto(ticket);
    }

    // Helper method for mapping TicketStatus enum to string
    private static String mapStatusToString(TicketStatus status) {
        return status.name();
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

    /**
     * Get the escalation level of a ticket.
     *
     * @param id The ticket ID
     * @return int representing the escalation level (0 = not escalated, 1 = Manager, 2 = DRH)
     * @throws NoSuchElementException if ticket not found
     */
    @Transactional(readOnly = true)
    public int getTicketEscalationLevel(Long id) {
        Ticket ticket = ticketRepo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Ticket not found"));

        return ticket.getEscalationLevel();
    }

    /**
     * Creates a quick test for ticket escalation
     * @return A message indicating the result of the test
     */
    @Transactional
    public String quickEscalationTest() {
        // 1. Find or create a department
        Department dept;
        try {
            dept = deptRepo.findAll().stream().findFirst().orElseThrow();
        } catch (Exception e) {
            // Create a department if none exists
            dept = new Department();
            dept.setName("Test Department " + System.currentTimeMillis());
            dept.setDescription("Test Department for Escalation Test");
            dept.setManagerUserId("test-manager-id");
            dept.setSupportUserIds(new HashSet<>());
            dept.addSupportUser("test-support-id");
            dept = deptRepo.save(dept);
        }

        // 2. Create a test ticket
        Ticket testTicket = new Ticket();
        testTicket.setStatus("OPEN");
        testTicket.setEscalationLevel(0);
        testTicket.setCreatedBy("test-user");
        testTicket.setDescription("Quick Escalation Test");
        testTicket.setCategory(HrRequestCategory.PAYSLIP_QUESTION);
        testTicket.setDepartment(dept);

        // 3. Save ticket
        Ticket saved = ticketRepo.save(testTicket);
        Long ticketId = saved.getId();

        // 4. Use JdbcTemplate to update the timestamp directly
        jdbcTemplate.update(
                "UPDATE app.ticket SET created_at = ? WHERE id = ?",
                Timestamp.from(Instant.now().minus(Duration.ofHours(49))),
                ticketId
        );

        // 5. Clear JPA's first-level cache
        em.clear();

        // 6. Manually escalate
        Ticket refreshed = ticketRepo.findById(ticketId).orElseThrow();
        refreshed.setAssignedTo(dept.getManagerUserId());
        refreshed.setEscalationLevel(1);
        ticketRepo.save(refreshed);

        return String.format(
                "Escalation test successful! Ticket #%d escalated to Manager %s",
                ticketId, dept.getManagerUserId()
        );
    }

    @Transactional
    public String quickDrhEscalationTest() {
        // 1. Find or create a department
        Department dept;
        try {
            dept = deptRepo.findAll().stream().findFirst().orElseThrow();
        } catch (Exception e) {
            // Create a department if none exists
            dept = new Department();
            dept.setName("Test Department " + System.currentTimeMillis());
            dept.setDescription("Test Department for Escalation Test");
            dept.setManagerUserId("test-manager-id");
            dept.setSupportUserIds(new HashSet<>());
            dept.addSupportUser("test-support-id");
            dept = deptRepo.save(dept);
        }

        // 2. Create a test ticket
        Ticket testTicket = new Ticket();
        testTicket.setStatus("OPEN");
        testTicket.setEscalationLevel(1); // Already at level 1 (manager escalation)
        testTicket.setCreatedBy("test-user");
        testTicket.setDescription("DRH Escalation Test");
        testTicket.setCategory(HrRequestCategory.PAYSLIP_QUESTION);
        testTicket.setDepartment(dept);
        testTicket.setAssignedTo(dept.getManagerUserId()); // Already assigned to manager

        // 3. Save ticket
        Ticket saved = ticketRepo.save(testTicket);
        Long ticketId = saved.getId();

        // 4. Use JdbcTemplate to update the timestamp directly (72+ hours ago)
        jdbcTemplate.update(
                "UPDATE app.ticket SET created_at = ? WHERE id = ?",
                Timestamp.from(Instant.now().minus(Duration.ofHours(73))),
                ticketId
        );

        // 5. Clear JPA's first-level cache
        em.clear();

        // 6. Verify if it would be picked up by the escalation query
        List<Ticket> candidates = ticketRepo.findEscalatable(1, Instant.now().minus(Duration.ofHours(72)));
        boolean foundForEscalation = candidates.stream()
                .anyMatch(t -> t.getId().equals(ticketId));

        // 7. Manually escalate to DRH
        Ticket refreshed = ticketRepo.findById(ticketId).orElseThrow();
        String drhUserId = "drh-user-id"; // You might want to use a real DRH user ID if available
        refreshed.setAssignedTo(drhUserId);
        refreshed.setEscalationLevel(2);
        ticketRepo.save(refreshed);

        return String.format(
                "DRH Escalation test successful!\n" +
                        "- Created ticket #%d (initially at level 1)\n" +
                        "- Backdated to %s (73 hours ago)\n" +
                        "- Found by escalation query: %s\n" +
                        "- Manually escalated to level 2 (DRH: %s)",
                ticketId,
                Instant.now().minus(Duration.ofHours(73)),
                foundForEscalation ? "YES" : "NO",
                drhUserId
        );
    }

}
