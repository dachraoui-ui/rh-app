package com.rh_app.hr_app.features.department.mapper;

import com.rh_app.hr_app.features.department.dto.DepartmentDto;
import com.rh_app.hr_app.features.department.model.Department;

public class DepartmentMapper {


    public static DepartmentDto toDto(Department department) {
        return DepartmentDto.builder()
                .id(department.getId())
                .nom(department.getNom())
                .description(department.getDescription())
                .build();
    }

    public static Department toEntity(DepartmentDto dto) {
        return Department.builder()
                .id(dto.getId())
                .nom(dto.getNom())
                .description(dto.getDescription())
                .build();
    }
}
