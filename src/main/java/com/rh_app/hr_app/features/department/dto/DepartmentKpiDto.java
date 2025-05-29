package com.rh_app.hr_app.features.department.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DepartmentKpiDto {
    private long totalDepartments;
    private long departmentsCreatedLastMonth;
    private long departmentsCreatedLastYear;
    private double averageSupportUsersPerDepartment;
    private Map<Integer, Long> supportUserDistribution; // Key: support user count, Value: number of departments
    private long departmentsWithFullSupportTeam; // Departments with 3 support users
}