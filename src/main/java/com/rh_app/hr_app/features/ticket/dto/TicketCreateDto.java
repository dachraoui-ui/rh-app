/* TicketCreateDto: what the employee sends in JSON  */
package com.rh_app.hr_app.features.ticket.dto;

import com.rh_app.hr_app.core.enums.ticket_enums.HrRequestCategory;
import com.rh_app.hr_app.core.enums.ticket_enums.TicketPriority;
import jakarta.validation.constraints.*;



/**
 * @param category formerly requestType
 * @param priority null ⇒ NORMAL   (handled in service)
 */

public record TicketCreateDto(@NotNull Long departmentId, @NotNull HrRequestCategory category,
                              @NotBlank @Size(max = 4000) String description, TicketPriority priority) {

}