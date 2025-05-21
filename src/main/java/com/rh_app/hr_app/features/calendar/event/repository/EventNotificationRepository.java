package com.rh_app.hr_app.features.calendar.event.repository;

import com.rh_app.hr_app.features.calendar.event.model.EventNotification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface EventNotificationRepository extends JpaRepository<EventNotification, Long> {
    // Original query kept for backward compatibility
    List<EventNotification> findByScheduledTimeBeforeAndSentFalse(LocalDateTime time);
    
    // New more precise query with a margin to prevent premature sending
    @Query("SELECT n FROM EventNotification n WHERE n.scheduledTime <= :currentTime AND n.scheduledTime >= :safetyMargin AND n.sent = false")
    List<EventNotification> findDueNotifications(@Param("currentTime") LocalDateTime currentTime, @Param("safetyMargin") LocalDateTime safetyMargin);
}
