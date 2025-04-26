package com.rh_app.hr_app.features.document.dto;
public record DocFolderUpdateDto(
        String name,        // optional new name
        Long   parentId     // optional new parent
) {}