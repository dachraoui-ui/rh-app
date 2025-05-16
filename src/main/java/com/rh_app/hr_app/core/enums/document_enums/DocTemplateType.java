package com.rh_app.hr_app.core.enums.document_enums;


public enum DocTemplateType {
    PERSONAL_FILE,    // Highly sensitive - DRH/GRH only
    SALARY_DOCUMENT,  // Highly sensitive - DRH/GRH only
    ASSESSMENT,       // Sensitive - Limited access
    CERTIFICATE,      // Standard HR document
    COMPANY_CONFIDENTIAL, // Company-level confidential documents - DRH/GRH only
    OTHER             // General document
}
