/* src/main/java/com/rh_app/hr_app/features/ticket/dto/TicketAttachmentDto.java */
package com.rh_app.hr_app.features.ticket.dto;

import lombok.Builder;
import lombok.Value;

import java.time.Instant;

@Value @Builder
public class TicketAttachmentDto {

    Long    id;
    String  originalName;
    String  mimeType;
    long    size;          // bytes
    String  uploadedBy;    // Keycloak id
    Instant uploadedAt;
}
