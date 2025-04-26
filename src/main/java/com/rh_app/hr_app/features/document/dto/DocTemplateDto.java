package com.rh_app.hr_app.features.document.dto;

import com.rh_app.hr_app.core.enums.document_enums.DocTemplateType;
import lombok.Builder;
import lombok.Value;

import java.time.Instant;

/** Read model returned to both employees (listing) and HR. */
@Value
@Builder
public class DocTemplateDto {
    Long            id;
    Long            folderId;
    DocTemplateType type;
    String          name;          // UI label
    String          originalName;  // for download header
    String          mimeType;
    long            size;          // bytes
    String          version;
    boolean         active;
    String          uploadedBy;
    Instant         createdAt;
}