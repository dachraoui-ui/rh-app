/* src/main/java/com/rh_app/hr_app/features/ticket/dto/TicketDto.java */
package com.rh_app.hr_app.features.ticket.dto;

import com.rh_app.hr_app.core.enums.ticket_enums.*;
import lombok.Builder;
import lombok.Value;

import java.time.Instant;
import java.util.List;

@Value @Builder
public class TicketDto {

    Long           id;

    /* who / where */
    Long           departmentId;
    String         createdBy;       // Keycloak user-id of employee
    String         assignedTo;      // null = unassigned
    HrRequestCategory  requestType;     // e.g. SALARY_CERTIFICATE, ...

    /* workflow */
    TicketPriority priority;
    TicketStatus   status;
    Integer        escalationLevel; // 0,1,2  (null ⇒ 0)
    Integer        reopenedCount;   // starts at 0

    /* timestamps */
    Instant        createdAt;
    Instant        updatedAt;
    Instant        resolvedAt;      // null until GRH closes

    /* free-text description */
    String         description;

    /* attachments meta */
    List<TicketAttachmentDto> attachments;
}
