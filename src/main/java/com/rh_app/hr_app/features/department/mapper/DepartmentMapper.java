package com.rh_app.hr_app.features.department.mapper;

import com.rh_app.hr_app.features.department.dto.DepartmentDto;
import com.rh_app.hr_app.features.department.model.Department;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)   // utility-class ⇒ no public ctor
public final class DepartmentMapper {

    /* ---------- Entity  ➜  DTO ---------- */
    public static DepartmentDto toDto(Department d) {
        if (d == null) return null;

        return DepartmentDto.builder()
                .id(d.getId())
                .name(d.getName())                     // ← keep field names consistent
                .description(d.getDescription())
                .managerUserId(d.getManagerUserId())   // Keycloak UUID
                .supportUserIds(d.getSupportUserIds()) // Set<String>
                .build();
    }

    /* ---------- DTO  ➜  Entity ---------- */
    public static Department toEntity(DepartmentDto dto) {
        if (dto == null) return null;

        return Department.builder()
                .id(dto.getId())                      // null for new entities
                .name(dto.getName())
                .description(dto.getDescription())
                .managerUserId(dto.getManagerUserId())
                .supportUserIds(dto.getSupportUserIds()) // will be validated in entity
                .build();
    }
}
