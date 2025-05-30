package com.rh_app.hr_app.features.calendar.event.repository;

import com.rh_app.hr_app.features.calendar.event.model.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface EventRepository extends JpaRepository<Event, Long> {
    List<Event> findByDateAndIsDeletedFalse(LocalDate date);

    @Query("SELECT e FROM Event e WHERE e.isDeleted = false")
    List<Event> findAllActive();
    
    @Query("SELECT e FROM Event e WHERE e.isDeleted = false AND LOWER(e.guests) LIKE LOWER(CONCAT('%', :guestEmail, '%'))")
    List<Event> findByGuestEmailContainingAndNotDeleted(@Param("guestEmail") String guestEmail);

    // query methods for KPIs
    // KPI 1: Total events this month
    @Query("SELECT COUNT(e) FROM Event e WHERE e.isDeleted = false AND e.date >= :startOfMonth AND e.date <= :endOfMonth")
    long countEventsThisMonth(@Param("startOfMonth") LocalDate startOfMonth, @Param("endOfMonth") LocalDate endOfMonth);

    // KPI 2: Events by calendar type (Leave, Internal, HR)
    @Query("SELECT e.calendarType, COUNT(e) FROM Event e WHERE e.isDeleted = false GROUP BY e.calendarType")
    List<Object[]> countEventsByCalendarType();

    // KPI 3: Events by importance level
    @Query("SELECT e.importance, COUNT(e) FROM Event e WHERE e.isDeleted = false GROUP BY e.importance")
    List<Object[]> countEventsByImportance();

    // KPI 4: Upcoming events count
    @Query("SELECT COUNT(e) FROM Event e WHERE e.isDeleted = false AND e.date >= :currentDate")
    long countUpcomingEvents(@Param("currentDate") LocalDate currentDate);

    // KPI 4: Past events count
    @Query("SELECT COUNT(e) FROM Event e WHERE e.isDeleted = false AND e.date < :currentDate")
    long countPastEvents(@Param("currentDate") LocalDate currentDate);


}
