package com.rh_app.hr_app.features.department.controller;

import com.rh_app.hr_app.features.department.dto.DepartmentKpiDto;
import com.rh_app.hr_app.features.department.service.DepartmentKpiService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/departments/kpis")
@RequiredArgsConstructor
public class DepartmentKpiController {

    private final DepartmentKpiService departmentKpiService;
    private static final Logger log = LoggerFactory.getLogger(DepartmentKpiController.class);

    @GetMapping
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<DepartmentKpiDto> getDepartmentKpis() {
        log.info("Fetching department KPIs for dashboard");
        DepartmentKpiDto kpis = departmentKpiService.getDepartmentKpis();
        return ResponseEntity.ok(kpis);
    }
}