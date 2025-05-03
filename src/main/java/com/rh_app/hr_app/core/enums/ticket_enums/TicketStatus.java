package com.rh_app.hr_app.core.enums.ticket_enums;

public enum TicketStatus {
    OPEN,        // employee just created – in GRH inbox
    ASSIGNED,    // GRH picked a support / manager (visible in their queue)
    IN_PROGRESS, // assignee actively working
    RESOLVED,    // assignee thinks it’s fixed
    CLOSED       // GRH validated & archived=true
}
