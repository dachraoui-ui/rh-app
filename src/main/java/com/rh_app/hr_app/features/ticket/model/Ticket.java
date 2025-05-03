package com.rh_app.hr_app.features.ticket.model;

import com.rh_app.hr_app.core.enums.ticket_enums.HrRequestCategory;
import com.rh_app.hr_app.features.department.model.Department;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "ticket",
        indexes = {
                @Index(name = "idx_ticket_department", columnList = "department_id"),
                @Index(name = "idx_ticket_created_by", columnList = "created_by, created_at")
        })
@Data
public class Ticket {

    /**
     * An HR-support ticket.
     *
     *  • created by an EMPLOYEE (max 5 / months enforced in service layer)
     *  • first routed to GRH (who picks an assignee → Support OR Manager)
     *  • 48 h unresolved → Manager escalation (escalationLevel = 1)
     *  • 72 h unresolved → DRH escalation (escalationLevel = 2)
     *  • Support / Manager mark RESOLVED
     *  • only GRH can finally CLOSE (archive=true)
     *
     * No hard-delete: tickets live forever; “archived” just hides them from the
     * active lists.
     */

    /* ---- identity ---- */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /* ---- classification ---- */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 40)
    private HrRequestCategory category;   // replaces title

    /* ---- content ---- */
    @Column(nullable = false, length = 4_000)
    private String description;

    /* ---- relationships ---- */
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id")
    private Department department;

    @OneToMany(mappedBy = "ticket",
            cascade = CascadeType.ALL,
            orphanRemoval = true,
            fetch = FetchType.LAZY)
    private List<TicketAttachment> attachments = new ArrayList<>();

    /* ---- workflow ---- */
    @Column(nullable = false, length = 50)
    private String createdBy;          // Keycloak id of employee

    @Column(length = 50)
    private String assignedTo;         // support / manager / DRH (nullable)

    @Column(length = 20, nullable = false)
    private String status;             // OPEN, IN_PROGRESS, RESOLVED, CLOSED, ARCHIVED

    @Column(nullable = false)
    private int escalationLevel = 0;   // 0 = none, 1 = →manager, 2 = →DRH

    @Column(nullable = false)
    private short priority = 3;        // 1-critical, 2-high, 3-normal, 4-low

    @Column(nullable = false)
    private short reopenCount = 0;

    /* ---- timestamps ---- */
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private Instant createdAt;

    @UpdateTimestamp
    private Instant updatedAt;

    private Instant resolvedAt;
}
