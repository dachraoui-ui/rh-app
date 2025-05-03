/* TicketCreateDto: what the employee sends in JSON  */
package com.rh_app.hr_app.features.ticket.dto;

import com.rh_app.hr_app.core.enums.ticket_enums.HrRequestCategory;
import com.rh_app.hr_app.core.enums.ticket_enums.TicketPriority;
import jakarta.validation.constraints.*;

import lombok.Value;

@Value
public class TicketCreateDto {

    @NotNull Long             departmentId;

    @NotNull HrRequestCategory category;       // formerly requestType

    @NotBlank @Size(max = 4000)
    String description;

    TicketPriority priority;   // null ⇒ NORMAL   (handled in service)
}