/* src/main/java/com/rh_app/hr_app/features/ticket/repository/TicketRepository.java */
package com.rh_app.hr_app.features.ticket.repository;

import com.rh_app.hr_app.features.ticket.model.Ticket;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.List;

/**
 * Data-access layer for <ticket>.
 *
 * ────────────────────────────────────────────────
 *  • Spring-Data derives the simple find/count
 *    queries from method names.
 *  • One JPQL query covers automatic escalation.
 * ────────────────────────────────────────────────
 */
@Repository
public interface TicketRepository extends JpaRepository<Ticket, Long> {

    /* ╔══════════════╗
       ║ 1. DASHBOARD ║
       ╚══════════════╝ */

    /** All *active* tickets (anything not ARCHIVED) for a department. */
    List<Ticket> findByDepartmentIdAndStatusNotOrderByCreatedAtAsc(
            Long departmentId, String statusArchived /* pass "ARCHIVED" */);

    /** Tickets created by one employee – “My requests” page. */
    List<Ticket> findByCreatedByOrderByCreatedAtDesc(String employeeId);

    /* ╔════════════════╗
       ║ 2. ESCALATION  ║
       ╚════════════════╝ */

    /**
     * Generic finder used by the scheduled task:
     * <pre>
     *  level=0, threshold = now-48h  → escalate to Manager
     *  level=1, threshold = now-72h  → escalate to DRH
     * </pre>
     */
    @Query("""
           select t
             from Ticket t
            where t.status          = 'OPEN'
              and t.escalationLevel = :level
              and t.createdAt      <= :threshold
           """)
    List<Ticket> findEscalatable(@Param("level") int level,
                                 @Param("threshold") Instant threshold);

    /* ╔══════════════════════════════════╗
       ║ 3. “MAX 5 TICKETS / MONTH” RULE  ║
       ╚══════════════════════════════════╝ */

   /* ╔══════════════════════════════════╗
   ║ 5. GET MONTHLY TICKET COUNT      ║
   ╚══════════════════════════════════╝ */

    /**
     * Count tickets created by a user within a specific time range
     * Used to enforce the monthly limit (max 5)
     */
    long countByCreatedByAndCreatedAtBetween(String createdBy,
                                             Instant startInclusive,
                                             Instant endExclusive);

    /* ╔════════════════════╗
       ║  LISTING QUERIES   ║
       ╚════════════════════╝ */

    /** (1) All tickets created by one employee – newest first. */
    Page<Ticket> findByCreatedByOrderByCreatedAtDesc(String createdBy, Pageable page);

    /** (2) All tickets currently assigned to a given user – oldest first. */
    Page<Ticket> findByAssignedToOrderByCreatedAtAsc(String userId, Pageable page);

    /** (3) All tickets, optional status filter (GRH / DRH dashboard).      */
    @Query("""
           select t
             from Ticket t
            where (:status is null or t.status = :status)
           order by t.createdAt desc
           """)
    Page<Ticket> findAllWithOptionalStatus(@Param("status") String status,
                                           Pageable page);

    /* ╔══════════════╗
      ║ 4. KPI QUERIES║
       ╚══════════════╝ */

    /* —— 4-a  Average resolution time (hours) per DEPARTMENT —— */
    @Query(value = """
        SELECT COALESCE(AVG(EXTRACT(EPOCH FROM (resolved_at - created_at)) / 3600), 0)
          FROM ticket
         WHERE department_id = :deptId
           AND status        = 'CLOSED'
        """, nativeQuery = true)
    double avgResolutionHoursForDepartment(@Param("deptId") Long departmentId);

    /* —— 4-b  Average resolution time (hours) per AGENT —— */
    @Query(value = """
        SELECT COALESCE(AVG(EXTRACT(EPOCH FROM (resolved_at - created_at)) / 3600), 0)
          FROM ticket
         WHERE assigned_to = :agentId
           AND status      = 'CLOSED'
        """, nativeQuery = true)
    double avgResolutionHoursForAgent(@Param("agentId") String agentUserId);

    /* —— 4-c  How many tickets an agent CLOSED in a period —— */
    long countByAssignedToAndStatusAndResolvedAtBetween(String assignedTo,
                                                        String statusClosed,
                                                        Instant from,
                                                        Instant to);

    /* —— 4-d  Re-opened ticket count for a department —— */
    @Query("""
       select count(t)
         from Ticket t
        where t.department.id = :deptId
          and t.reopenCount   > 0
       """)
    long reopenedCountForDepartment(@Param("deptId") Long departmentId);
}
