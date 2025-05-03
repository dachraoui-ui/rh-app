package com.rh_app.hr_app.features.ticket.model;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;

import java.time.Instant;

@Entity
@Table(name = "ticket_attachment")
@Data
public class TicketAttachment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /* ---- owning side ---- */
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "ticket_id")
    private Ticket ticket;

    /* ---- file meta ---- */
    @Column(nullable = false, length = 160)
    private String originalName;

    @Column(nullable = false, length = 100)
    private String mimeType;

    @Column(nullable = false)
    private long size;                 // bytes

    @Lob
    @Column(nullable = false, name = "data")
    private byte[] data;               // stored as PostgreSQL BYTEA

    /* ---- audit ---- */
    @Column(nullable = false, length = 50)
    private String uploadedBy;         // Keycloak user-id of sender

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private Instant uploadedAt;
}
