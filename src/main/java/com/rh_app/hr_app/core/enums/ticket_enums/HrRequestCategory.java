package com.rh_app.hr_app.core.enums.ticket_enums;

public enum HrRequestCategory {

    // ── Admin & onboarding ──────────────────────────────
    ID_CARD_RENEWAL,
    NEW_BADGE,
    EQUIPMENT_LOSS,

    // ── Payroll & benefits ──────────────────────────────
    PAYSLIP_QUESTION,
    SALARY_CERTIFICATE,
    INSURANCE_UPDATE,

    // ── Personal data & contracts ───────────────────────
    ADDRESS_CHANGE,
    MARITAL_STATUS,
    CONTRACT_COPY,

    // ── Fallback bucket ─────────────────────────────────
    OTHER
}
