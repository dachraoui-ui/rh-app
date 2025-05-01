package com.rh_app.hr_app.features.department.dto;

import lombok.*;

import java.util.Set;

/**
 * Read-model / write-model used by controllers and services.
 *
 * • managerUserId —— Keycloak user-ID of the unique manager
 * • supportUserIds –– Set of up-to-3 Keycloak user-IDs acting as HR support staff
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DepartmentDto {

    private Long   id;               // DB primary key
    private String name;             // Department name (unique)
    private String description;      // Optional description

    private String        managerUserId;   // exactly one manager
    private Set<String>   supportUserIds;  // 1–3 support people
}
