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
                .parentId(f.getParent() != null ? f.getParent().getId() : null)
                .createdAt(f.getCreatedAt())
                .build();
    }

    /* -------- Create -------- */
    public static DocumentFolder toEntityForCreate(DocFolderCreateDto dto,
                                                   DocumentFolder parent) {
        DocumentFolder f = new DocumentFolder();
        f.setName(dto.name());
        f.setParent(parent);               // may be null for root
        return f;
    }

    /* -------- PATCH (rename / move) -------- */
    public static void applyUpdate(DocumentFolder entity,
                                   DocFolderUpdateDto patch,
                                   DocumentFolder newParent) {
        if (patch.name() != null)
            entity.setName(patch.name());
        if (patch.parentId() != null)
            entity.setParent(newParent);           // may be null to move to root
    }
}
