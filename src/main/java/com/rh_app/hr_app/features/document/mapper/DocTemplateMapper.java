package com.rh_app.hr_app.features.document.mapper;


import com.rh_app.hr_app.features.document.dto.DocTemplateDto;
import com.rh_app.hr_app.features.document.dto.DocTemplateUploadDto;
import com.rh_app.hr_app.features.document.model.DocumentFolder;
import com.rh_app.hr_app.features.document.model.DocumentTemplate;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class DocTemplateMapper {

    /* -------- Entity ➜ DTO -------- */
    public static DocTemplateDto toDto(DocumentTemplate t) {
        if (t == null) return null;
        return DocTemplateDto.builder()
                .id(t.getId())
                .folderId(t.getFolder().getId())
                .type(t.getType())
                .name(t.getName())
                .originalName(t.getOriginalName())
                .mimeType(t.getMimeType())
                .size(t.getSize())
                .version(t.getVersion())
                .active(t.isActive())
                .uploadedBy(t.getUploadedBy())
                .createdAt(t.getCreatedAt())
                .build();
    }

    /* -------- Upload (DRH) --------
       The controller already extracted:
       – MultipartFile file → bytes + meta
       – DocTemplateUploadDto dto
    */
    public static DocumentTemplate toEntityForUpload(DocTemplateUploadDto dto,
                                                     DocumentFolder folder,
                                                     byte[] data,
                                                     long size,
                                                     String mimeType,
                                                     String originalName,
                                                     String uploader) {

        log.debug("Creating DocumentTemplate entity with data length: {}",
                data != null ? data.length : 0);

        DocumentTemplate t = new DocumentTemplate();
        t.setFolder(folder);
        t.setType(dto.type());
        t.setName(dto.name() != null ? dto.name() : originalName);
        t.setOriginalName(originalName);
        t.setMimeType(mimeType);
        t.setSize(size);

        // Explicitly set data as byte array - this is the critical part
        if (data != null) {
            t.setData(data.clone()); // Make a defensive copy
        } else {
            t.setData(new byte[0]); // Never set null for BYTEA columns
        }

        t.setVersion(dto.version());
        t.setActive(true);
        t.setUploadedBy(uploader);
        return t;
    }
}