package com.rh_app.hr_app.features.department.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DepartmentDto {
    private Long id;
    private String nom;
    private String description;
}
