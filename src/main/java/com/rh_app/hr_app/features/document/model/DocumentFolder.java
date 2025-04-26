
package com.rh_app.hr_app.features.document.model;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;

import java.time.Instant;

/**
 * Logical folder to organise templates. Nested folders are allowed
 * through the self-referencing parent property.
 */
@Entity
@Table(name = "doc_folder",
        uniqueConstraints = @UniqueConstraint(columnNames = {"parent_id", "name"}))
@Data
public class DocumentFolder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Folder name without path separators. */
    @Column(nullable = false, length = 60)
    private String name;

    /** Parent folder; null means “root”. */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private DocumentFolder parent;

    /* ----- audit ----- */
    @CreationTimestamp
    private Instant createdAt;
}
