package com.rh_app.hr_app.features.document.mapper;

import com.rh_app.hr_app.core.enums.document_enums.DocRequestStatus;
import com.rh_app.hr_app.features.document.dto.*;
import com.rh_app.hr_app.features.document.model.DocumentRequest;
import com.rh_app.hr_app.features.document.model.DocumentTemplate;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.time.Instant;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class DocRequestMapper {

    /* -------- Entity ➜ DTO : read  -------- */
    public static DocRequestDto toDto(DocumentRequest r) {
        if (r == null) return null;
        return DocRequestDto.builder()
                .id(r.getId())
                .templateId(r.getTemplate().getId())
                .templateName(r.getTemplate().getName())
                .status(r.getStatus())
                .requestedBy(r.getRequestedBy())
                .rejectReason(r.getRejectReason())
                .createdAt(r.getCreatedAt())
                .resolvedAt(r.getResolvedAt())
                .deliveredAt(r.getDeliveredAt())
                .build();
    }

    /* -------- Employee create -------- */
    public static DocumentRequest toEntityForCreate(DocRequestCreateDto dto,
                                                    DocumentTemplate template,
                                                    String requester,
                                                    Instant now) {

        DocumentRequest r = new DocumentRequest();
        r.setTemplate(template);
        r.setRequestedBy(requester);
        r.setStatus(DocRequestStatus.REQUESTED);
        r.setCreatedAt(now);
        return r;
    }

    /* -------- HR workflow PATCH -------- */
    public static void applyWorkflow(DocumentRequest entity,
                                     DocRequestWorkflowDto patch,
                                     String hrUser,
                                     Instant now) {

        if (patch.status() != null) {
            entity.setStatus(patch.status());

            switch (patch.status()) {
                case READY, REJECTED -> entity.setResolvedAt(now);
                case DELIVERED       -> entity.setDeliveredAt(now);
                default -> { /* no extra timestamp */ }
            }
        }

        if (patch.rejectReason() != null) {
            entity.setRejectReason(patch.rejectReason());
        }

    }
}
