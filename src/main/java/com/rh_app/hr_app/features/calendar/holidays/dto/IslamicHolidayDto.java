package com.rh_app.hr_app.features.calendar.holidays.dto;

import lombok.*;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class IslamicHolidayDto {
    private Long id;
    private String name;
    private LocalDate date;
    private String description;
    private Integer year;
    private Integer durationDays;
}