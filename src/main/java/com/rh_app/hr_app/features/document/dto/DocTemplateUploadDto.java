package com.rh_app.hr_app.features.document.dto;

import com.rh_app.hr_app.core.enums.document_enums.DocTemplateType;

/**
 * Sent as multipart/form-data together with the binary file.
 * Controller binds:
 *   └── MultipartFile file
 */
public record DocTemplateUploadDto(
        Long            folderId,
        DocTemplateType type,
        String          name,        // optional override; else original filename
        String          version      // optional
) { }