package com.rh_app.hr_app.features.document.dto;

import com.rh_app.hr_app.core.enums.document_enums.DocRequestStatus;
import lombok.Builder;
import lombok.Value;

import java.time.Instant;

/** Read model shown in employee “My requests” and HR inbox. */
@Value
@Builder
public class DocRequestDto {
    Long              id;
    Long              templateId;
    String            templateName;
    DocRequestStatus  status;
    String            requestedBy;
    String            rejectReason;
    Instant           createdAt;
    Instant           resolvedAt;
    Instant           deliveredAt;
}