
package com.rh_app.hr_app.features.document.model;

import com.rh_app.hr_app.core.enums.document_enums.DocTemplateType;
import jakarta.persistence.*;
import jakarta.websocket.Decoder;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.Type;
import org.hibernate.type.SqlTypes;

import java.time.Instant;

/**
 * A static template file uploaded by DRH.  File bytes are stored directly
 * in the table (PostgreSQL bytea).
 */
@Entity
@Table(name = "doc_template")
@Data
public class DocumentTemplate {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /* ---------- Folder & classification ---------- */

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "folder_id")
    private DocumentFolder folder;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private DocTemplateType type;

    /* ---------- File metadata ---------- */

    @Column(nullable = false, length = 120)
    private String name;                 // UI label

    @Column(nullable = false, length = 255)
    private String originalName;         // uploader filename

    @Column(nullable = false, length = 100)
    private String mimeType;

    @Column(nullable = false)
    private long size;

    @Lob                                          // large field
    @JdbcTypeCode(SqlTypes.BINARY)// <-- tell Hibernate “use BYTEA”
    @Column(name = "file_data", nullable = false)
    private byte[] data;

    /* ---------- Lifecycle ---------- */

    @Column(length = 30)
    private String version;              // free-text (“v2” …)

    @Column(nullable = false)
    private boolean active = true;       // soft delete

    /* ---------- Audit ---------- */

    @Column(nullable = false, length = 50)
    private String uploadedBy;           // DRH username

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private Instant createdAt;
}
