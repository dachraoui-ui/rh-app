package com.rh_app.hr_app.features.holidays.controller;

import com.rh_app.hr_app.features.holidays.dto.IslamicHolidayDto;
import com.rh_app.hr_app.features.holidays.service.IslamicHolidayService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/holidays")
@RequiredArgsConstructor
public class IslamicHolidayController {
    private final IslamicHolidayService islamicHolidayService;

    @GetMapping("/islamic")
    public ResponseEntity<List<IslamicHolidayDto>> getAllIslamicHolidays() {
        return ResponseEntity.ok(islamicHolidayService.getAllHolidays());
    }

    @GetMapping("/islamic/year/{year}")
    public ResponseEntity<List<IslamicHolidayDto>> getByYear(@PathVariable Integer year) {
        return ResponseEntity.ok(islamicHolidayService.getHolidaysByYear(year));
    }

    @GetMapping("/public")
    public ResponseEntity<List<IslamicHolidayDto>> getPublicHolidays(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate start,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate end) {

        LocalDate startDate = start != null ? start : LocalDate.now().withDayOfYear(1);
        LocalDate endDate = end != null ? end : LocalDate.now().withDayOfMonth(31).withMonth(12);

        return ResponseEntity.ok(islamicHolidayService.getHolidaysInRange(startDate, endDate));
    }

    @PreAuthorize("hasRole('DRH')")
    @PostMapping("/islamic")
    public ResponseEntity<IslamicHolidayDto> createHoliday(@RequestBody IslamicHolidayDto dto) {
        return ResponseEntity.ok(islamicHolidayService.createHoliday(dto));
    }
}