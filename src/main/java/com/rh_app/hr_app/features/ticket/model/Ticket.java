
package com.rh_app.hr_app.features.ticket.model;

import com.rh_app.hr_app.core.enums.ticket_enums.TicketCategory;
import com.rh_app.hr_app.core.enums.ticket_enums.TicketPriority;
import com.rh_app.hr_app.core.enums.ticket_enums.TicketStatus;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.Instant;

@Entity
@Table(name = "ticket")
@Data
public class Ticket {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /* ---------------------- Business Data ---------------------- */

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 40)
    private TicketCategory category;

    @Column(nullable = false, length = 255)
    private String title;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private TicketStatus status = TicketStatus.OPEN;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private TicketPriority priority = TicketPriority.MEDIUM;

    /* --------------------  Keycloak users ----------------- */

    /** Username or UUID of the author in Keycloak */
    @Column(nullable = false, length = 50)
    private String createdBy;

    /** Username or UUID of the person assigned (GRH/DRH) */
    @Column(length = 50)
    private String assignedTo;

    /** Qui a fixé la priorité actuelle ? */
    @Column(length = 50)
    private String prioritySetBy;

    /* --------------------- Traces & audit ----------------------- */

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private Instant createdAt;

    @Column
    private Instant resolvedAt;   // null until status becomes RESOLVED


    @UpdateTimestamp
    @Column(nullable = false)
    private Instant updatedAt;
}