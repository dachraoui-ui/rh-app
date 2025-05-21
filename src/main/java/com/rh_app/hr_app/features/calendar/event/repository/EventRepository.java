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
}
