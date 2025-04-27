package com.rh_app.hr_app.features.document.mapper;

import com.rh_app.hr_app.features.document.dto.*;
import com.rh_app.hr_app.features.document.model.DocumentFolder;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class DocFolderMapper {

    /* -------- Entity ➜ DTO (read) -------- */
    public static DocFolderDto toDto(DocumentFolder f) {
        if (f == null) return null;
        return DocFolderDto.builder()
                .id(f.getId())
                .name(f.getName())
                .createdAt(f.getCreatedAt())
                .build();
    }

    /* -------- Create -------- */
    public static DocumentFolder toEntityForCreate(DocFolderCreateDto dto) {
        DocumentFolder f = new DocumentFolder();
        f.setName(dto.name());
        return f;
    }

    /* -------- PATCH (rename) -------- */
    public static void applyUpdate(DocumentFolder entity,
                                   DocFolderUpdateDto patch) {
        if (patch.name() != null)
            entity.setName(patch.name());
    }
}