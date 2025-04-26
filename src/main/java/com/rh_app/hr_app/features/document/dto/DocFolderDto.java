package com.rh_app.hr_app.features.document.dto;

import lombok.Builder;
import lombok.Value;

import java.time.Instant;

/** Read-only representation of a folder node. */
@Value
@Builder
public class DocFolderDto {
    Long   id;
    String name;          // “Finance”, “Letters”, etc.
    Long   parentId;      // null = root
    Instant createdAt;
}