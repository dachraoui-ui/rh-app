package com.rh_app.hr_app.features.ticket.mapper;

import com.rh_app.hr_app.features.ticket.dto.TicketAttachmentDto;
import com.rh_app.hr_app.features.ticket.model.TicketAttachment;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class TicketAttachmentMapper {

    /** Entity ➜ DTO (read-only) */
    public static TicketAttachmentDto toDto(TicketAttachment a) {
        if (a == null) return null;

        return TicketAttachmentDto.builder()
                .id(a.getId())
                .originalName(a.getOriginalName())
                .mimeType(a.getMimeType())   // 🔸 matches DTO field
                .size(a.getSize())           // 🔸 matches DTO field
                .uploadedBy(a.getUploadedBy())
                .uploadedAt(a.getUploadedAt())
                .build();
    }
}
