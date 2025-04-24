
package com.rh_app.hr_app.features.ticket.repository;
import com.rh_app.hr_app.core.enums.ticket_enums.TicketPriority;
import com.rh_app.hr_app.core.enums.ticket_enums.TicketStatus;
import com.rh_app.hr_app.features.ticket.model.Ticket;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.List;

@Repository
public interface TicketRepo extends JpaRepository<Ticket, Long> {

    /* Employee: list my own tickets (paged) */
    Page<Ticket> findByCreatedByOrderByCreatedAtDesc(String createdBy, Pageable page);

    /* GRH: tickets assigned to me (paged) */
    Page<Ticket> findByAssignedToOrderByPriorityDescCreatedAtAsc(
            String assignedTo, Pageable page);

    /* Dashboard cards */
    long countByStatus(TicketStatus status);
    long countByStatusAndPriority(TicketStatus status, TicketPriority priority);

    /* Escalation job: overdue open tickets */
    List<Ticket> findByStatusAndCreatedAtBefore(
            TicketStatus status, Instant threshold);
}

