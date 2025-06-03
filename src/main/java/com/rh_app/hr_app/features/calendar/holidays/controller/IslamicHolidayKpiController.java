package com.rh_app.hr_app.features.calendar.holidays.controller;

import com.rh_app.hr_app.features.calendar.holidays.dto.IslamicHolidayKpiDto;
import com.rh_app.hr_app.features.calendar.holidays.service.IslamicHolidayKpiService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/holidays/islamic/kpis")
@RequiredArgsConstructor
public class IslamicHolidayKpiController {

    private final IslamicHolidayKpiService islamicHolidayKpiService;
    private static final Logger log = LoggerFactory.getLogger(IslamicHolidayKpiController.class);

    @GetMapping
    public ResponseEntity<IslamicHolidayKpiDto> getIslamicHolidayKpis() {
        log.info("Fetching Islamic holiday KPIs for dashboard");
        IslamicHolidayKpiDto kpis = islamicHolidayKpiService.getIslamicHolidayKpis();
        return ResponseEntity.ok(kpis);
    }
}