package com.rh_app.hr_app.features.calendar.holidays.service;

import com.rh_app.hr_app.features.calendar.holidays.dto.IslamicHolidayKpiDto;
import com.rh_app.hr_app.features.calendar.holidays.repository.IslamicHolidayRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

@Service
@RequiredArgsConstructor
public class IslamicHolidayKpiService {

    private final IslamicHolidayRepository islamicHolidayRepository;

    @Transactional(readOnly = true)
    public IslamicHolidayKpiDto getIslamicHolidayKpis() {
        LocalDate today = LocalDate.now();
        int currentYear = today.getYear();

        LocalDate startOfThisMonth = today.withDayOfMonth(1);
        LocalDate endOfThisMonth = today.withDayOfMonth(today.lengthOfMonth());

        LocalDate startOfNextMonth = today.plusMonths(1).withDayOfMonth(1);
        LocalDate endOfNextMonth = startOfNextMonth.withDayOfMonth(startOfNextMonth.lengthOfMonth());

        return IslamicHolidayKpiDto.builder()
                .totalHolidaysThisYear(getTotalHolidaysThisYear(currentYear))
                .holidaysThisMonth(getHolidaysInMonth(startOfThisMonth, endOfThisMonth))
                .holidaysNextMonth(getHolidaysInMonth(startOfNextMonth, endOfNextMonth))
                .build();
    }

    private long getTotalHolidaysThisYear(Integer year) {
        return islamicHolidayRepository.countHolidaysByYear(year);
    }

    private long getHolidaysInMonth(LocalDate startOfMonth, LocalDate endOfMonth) {
        return islamicHolidayRepository.countHolidaysInMonth(startOfMonth, endOfMonth);
    }
}