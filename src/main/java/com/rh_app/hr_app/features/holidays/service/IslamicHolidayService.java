package com.rh_app.hr_app.features.holidays.service;

import com.rh_app.hr_app.features.holidays.dto.IslamicHolidayDto;
import com.rh_app.hr_app.features.holidays.mapper.IslamicHolidayMapper;
import com.rh_app.hr_app.features.holidays.model.IslamicHoliday;
import com.rh_app.hr_app.features.holidays.repository.IslamicHolidayRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class IslamicHolidayService {
    private final IslamicHolidayRepository islamicHolidayRepository;

    public List<IslamicHolidayDto> getAllHolidays() {
        return islamicHolidayRepository.findAll().stream()
                .map(IslamicHolidayMapper::toDto)
                .collect(Collectors.toList());
    }

    public List<IslamicHolidayDto> getHolidaysByYear(Integer year) {
        return islamicHolidayRepository.findByYear(year).stream()
                .map(IslamicHolidayMapper::toDto)
                .collect(Collectors.toList());
    }

    public List<IslamicHolidayDto> getHolidaysInRange(LocalDate start, LocalDate end) {
        return islamicHolidayRepository.findByDateBetween(start, end).stream()
                .map(IslamicHolidayMapper::toDto)
                .collect(Collectors.toList());
    }

    public IslamicHolidayDto createHoliday(IslamicHolidayDto dto) {
        IslamicHoliday holiday = IslamicHolidayMapper.toEntity(dto);
        IslamicHoliday savedHoliday = islamicHolidayRepository.save(holiday);
        return IslamicHolidayMapper.toDto(savedHoliday);
    }
}