/* --- Payload: HR workflow patch ------------------------------------- */
package com.rh_app.hr_app.features.document.dto;

import com.rh_app.hr_app.core.enums.document_enums.DocRequestStatus;

/**
 * GRH / DRH updates a request.
 * Multipart upload of the final PDF (when marking READY) is handled
 * alongside this DTO at controller level.
 */
public record DocRequestWorkflowDto(
        DocRequestStatus status,   // ACCEPTED, PREPARING, READY, DELIVERED, REJECTED
        String           rejectReason,
        String           assignedTo // optional re-assign
) { }