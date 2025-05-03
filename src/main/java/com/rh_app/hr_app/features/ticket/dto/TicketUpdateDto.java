/* TicketUpdateDto: used by GRH / Support / Manager to change workflow fields */
package com.rh_app.hr_app.features.ticket.dto;

import com.rh_app.hr_app.core.enums.ticket_enums.TicketPriority;
import com.rh_app.hr_app.core.enums.ticket_enums.TicketStatus;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class TicketUpdateDto {

    TicketStatus   status;
    TicketPriority priority;
    String         assignedTo;

    Boolean        archived;   // let GRH archive via the same DTO (optional)
}