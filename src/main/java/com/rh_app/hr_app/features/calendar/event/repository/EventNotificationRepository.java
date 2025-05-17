package com.rh_app.hr_app.features.calendar.event.repository;

import com.rh_app.hr_app.features.calendar.event.model.EventNotification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface EventNotificationRepository extends JpaRepository<EventNotification, Long> {
    List<EventNotification> findByScheduledTimeBeforeAndSentFalse(LocalDateTime time);
}