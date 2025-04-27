package com.rh_app.hr_app.features.document.model;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;

import java.time.Instant;

/**
 * Simple folder to organize templates without hierarchical structure.
 */
@Entity
@Table(name = "doc_folder",
        uniqueConstraints = @UniqueConstraint(columnNames = {"name"}))
@Data
public class DocumentFolder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Folder name. */
    @Column(nullable = false, length = 60, unique = true)
    private String name;

    /* ----- audit ----- */
    @CreationTimestamp
    private Instant createdAt;
}