
package com.rh_app.hr_app.features.document.model;

import com.rh_app.hr_app.core.enums.document_enums.DocRequestStatus;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.type.SqlTypes;

import java.time.Instant;

/**
 * One employee’s request for a document. Final PDF is stored in the DB;
 * employees never download it—HR prints and hands it over face-to-face.
 */
@Entity
@Table(name = "doc_request")
@Data
public class DocumentRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /* ---------- Chosen template ---------- */

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "template_id")
    private DocumentTemplate template;

    /* ---------- Workflow ---------- */

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 12)
    private DocRequestStatus status = DocRequestStatus.REQUESTED;

    @Lob
    @JdbcTypeCode(SqlTypes.BINARY) // <-- Add this annotation
    @Column(name = "output_data")
    private byte[] outputData;


    @Column(length = 255)
    private String outputName;

    @Column(length = 100)
    private String outputMime;

    private Long outputSize;             // bytes

    @Column(columnDefinition = "TEXT")
    private String rejectReason;

    /* ---------- Users ---------- */

    @Column(nullable = false, length = 50)
    private String requestedBy;          // employee / intern

    @Column(length = 50)
    private String assignedTo;           // GRH, who took ownership

    @Column(length = 50)
    private String resolvedBy;           // HR who finished / rejected / delivered

    /* ---------- Audit timestamps ---------- */

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private Instant createdAt;

    private Instant resolvedAt;          // READY or REJECTED
    private Instant deliveredAt;         // after physical hand-over

    @UpdateTimestamp
    @Column(nullable = false)
    private Instant updatedAt;
}
