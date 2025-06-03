package com.rh_app.hr_app.features.calendar.holidays.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class IslamicHolidayKpiDto {

    // KPI 1: Total Islamic holidays this year
    private long totalHolidaysThisYear;

    // KPI 2: Islamic holidays this month
    private long holidaysThisMonth;

    // KPI 3: Islamic holidays next month
    private long holidaysNextMonth;
}