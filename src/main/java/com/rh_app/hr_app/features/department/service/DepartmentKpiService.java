package com.rh_app.hr_app.features.department.service;

import com.rh_app.hr_app.features.department.dto.DepartmentKpiDto;
import com.rh_app.hr_app.features.department.repository.DepartmentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class DepartmentKpiService {

    private final DepartmentRepository departmentRepository;

    @Transactional(readOnly = true)
    public DepartmentKpiDto getDepartmentKpis() {
        Instant now = Instant.now();
        Instant oneMonthAgo = now.minus(30, ChronoUnit.DAYS);
        Instant oneYearAgo = now.minus(365, ChronoUnit.DAYS);

        // Get distribution of support users per department
        Map<Integer, Long> supportDistribution = new HashMap<>();
        List<Object[]> distributionData = departmentRepository.getSupportUserDistribution();
        for (Object[] data : distributionData) {
            Integer supportCount = ((Number) data[0]).intValue();
            Long departmentCount = ((Number) data[1]).longValue();
            supportDistribution.put(supportCount, departmentCount);
        }

        return DepartmentKpiDto.builder()
                .totalDepartments(departmentRepository.count())
                .departmentsCreatedLastMonth(departmentRepository.countByCreatedAtAfter(oneMonthAgo))
                .departmentsCreatedLastYear(departmentRepository.countByCreatedAtAfter(oneYearAgo))
                .averageSupportUsersPerDepartment(departmentRepository.getAverageSupportUsersPerDepartment())
                .supportUserDistribution(supportDistribution)
                .departmentsWithFullSupportTeam(departmentRepository.countDepartmentsWithFullSupportTeam())
                .build();
    }
}