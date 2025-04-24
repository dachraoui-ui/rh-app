package com.rh_app.hr_app.features.ticket.dto;

import com.rh_app.hr_app.core.enums.ticket_enums.TicketCategory;
import com.rh_app.hr_app.core.enums.ticket_enums.TicketPriority;
import com.rh_app.hr_app.core.enums.ticket_enums.TicketStatus;
import lombok.Builder;
import lombok.Value;

import java.time.Instant;

/**
 * Data Transfer Object for Ticket.
 * – Use `id == null` when sending data from the client to create a new ticket.
 * – All fields populated when returning a ticket to the client.
 */
@Value
@Builder
public class TicketDto {

    Long id;

    /* -------- Business data -------- */
    TicketCategory category;
    String         title;
    String         description;
    TicketStatus   status;
    TicketPriority priority;

    /* -------- Keycloak users -------- */
    String createdBy;
    String assignedTo;
    String prioritySetBy;

    /* -------- Audit timestamps -------- */
    Instant createdAt;
    Instant resolvedAt;
    Instant updatedAt;
}
