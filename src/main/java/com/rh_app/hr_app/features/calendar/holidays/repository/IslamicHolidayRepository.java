package com.rh_app.hr_app.features.calendar.holidays.repository;

import com.rh_app.hr_app.features.calendar.holidays.model.IslamicHoliday;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


import java.time.LocalDate;
import java.util.List;

@Repository
public interface IslamicHolidayRepository extends JpaRepository<IslamicHoliday, Long> {
    List<IslamicHoliday> findByYear(Integer year);
    List<IslamicHoliday> findByDateBetween(LocalDate startDate, LocalDate endDate);


    // KPI query methods
    @Query("SELECT COUNT(h) FROM IslamicHoliday h WHERE h.year = :year")
    long countHolidaysByYear(@Param("year") Integer year);

    @Query("SELECT COUNT(h) FROM IslamicHoliday h WHERE h.date >= :startOfMonth AND h.date <= :endOfMonth")
    long countHolidaysInMonth(@Param("startOfMonth") LocalDate startOfMonth, @Param("endOfMonth") LocalDate endOfMonth);

}