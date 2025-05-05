package com.rh_app.hr_app.features.holidays.repository;

import com.rh_app.hr_app.features.holidays.model.IslamicHoliday;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface IslamicHolidayRepository extends JpaRepository<IslamicHoliday, Long> {
    List<IslamicHoliday> findByYear(Integer year);
    List<IslamicHoliday> findByDateBetween(LocalDate startDate, LocalDate endDate);
}