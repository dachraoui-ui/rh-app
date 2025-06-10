/* --- Payload: employee creates a request ----------------------------- */
package com.rh_app.hr_app.features.document.dto;

/** Any employee other then the drh or grh can send the request . */
public record DocRequestCreateDto(
        Long templateId
) { }