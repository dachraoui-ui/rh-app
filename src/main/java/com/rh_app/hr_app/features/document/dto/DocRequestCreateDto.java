/* --- Payload: employee creates a request ----------------------------- */
package com.rh_app.hr_app.features.document.dto;

/** Employee / intern sends only the template ID. */
public record DocRequestCreateDto(
        Long templateId
) { }