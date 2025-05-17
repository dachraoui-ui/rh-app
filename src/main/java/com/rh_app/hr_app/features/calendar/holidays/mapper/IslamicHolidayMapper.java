package com.rh_app.hr_app.features.calendar.holidays.mapper;

import com.rh_app.hr_app.features.calendar.holidays.dto.IslamicHolidayDto;
import com.rh_app.hr_app.features.calendar.holidays.model.IslamicHoliday;

public class IslamicHolidayMapper {
    public static IslamicHolidayDto toDto(IslamicHoliday holiday) {
        return IslamicHolidayDto.builder()
                .id(holiday.getId())
                .name(holiday.getName())
                .date(holiday.getDate())
                .description(holiday.getDescription())
                .year(holiday.getYear())
                .durationDays(holiday.getDurationDays())
                .build();
    }

    public static IslamicHoliday toEntity(IslamicHolidayDto dto) {
        return IslamicHoliday.builder()
                .id(dto.getId())
                .name(dto.getName())
                .date(dto.getDate())
                .description(dto.getDescription())
                .year(dto.getYear())
                .durationDays(dto.getDurationDays())
                .build();
    }
}