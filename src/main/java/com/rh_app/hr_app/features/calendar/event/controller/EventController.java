package com.rh_app.hr_app.features.calendar.event.controller;

import com.rh_app.hr_app.core.email.MailService;
import com.rh_app.hr_app.features.calendar.event.dto.EventDto;
import com.rh_app.hr_app.features.calendar.event.model.Event;
import com.rh_app.hr_app.features.calendar.event.model.EventNotification;
import com.rh_app.hr_app.features.calendar.event.repository.EventNotificationRepository;
import com.rh_app.hr_app.features.calendar.event.service.EventService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/events")
@RequiredArgsConstructor
public class EventController {

    private final EventService eventService;
    private final EventNotificationRepository notificationRepository;
    private final MailService mailService;
    private static final Logger log = LoggerFactory.getLogger(EventController.class);

    @PostMapping
    public ResponseEntity<EventDto> createEvent(@RequestBody EventDto eventDto) {
        return ResponseEntity.ok(eventService.createEvent(eventDto));
    }

    @GetMapping
    public ResponseEntity<List<EventDto>> getAllEvents() {
        return ResponseEntity.ok(eventService.getAllEvents());
    }

    @GetMapping("/debug/pending-notifications")
    public ResponseEntity<List<EventNotification>> debugPendingNotifications() {
        return ResponseEntity.ok(eventService.getPendingNotifications());
    }

    @GetMapping("/debug/all-notifications")
    public ResponseEntity<List<EventNotification>> debugAllNotifications() {
        return ResponseEntity.ok(eventService.getAllNotifications());
    }

    @GetMapping("/debug/time-info")
    public ResponseEntity<Map<String, Object>> getTimeInfo() {
        Map<String, Object> timeInfo = new HashMap<>();
        LocalDateTime now = LocalDateTime.now();

        timeInfo.put("currentTime", now.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        timeInfo.put("systemZone", ZoneId.systemDefault().toString());

        // Get notification with ID 49
        EventNotification notification = notificationRepository.findById(49L).orElse(null);
        if (notification != null) {
            Map<String, Object> notifInfo = new HashMap<>();
            notifInfo.put("id", notification.getId());
            notifInfo.put("scheduledTime", notification.getScheduledTime().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            notifInfo.put("isBeforeNow", notification.getScheduledTime().isBefore(now));
            notifInfo.put("sent", notification.isSent());

            // Calculate time difference
            long minutesDiff = java.time.Duration.between(notification.getScheduledTime(), now).toMinutes();
            notifInfo.put("minutesPast", minutesDiff);

            timeInfo.put("notification", notifInfo);
        }

        return ResponseEntity.ok(timeInfo);
    }

    @PostMapping("/debug/process/{id}")
    public ResponseEntity<String> processNotification(@PathVariable Long id) {
        try {
            EventNotification notification = notificationRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Notification not found"));

            Event event = notification.getEvent();

            // Explicitly log the time comparison
            LocalDateTime now = LocalDateTime.now();
            log.info("MANUAL PROCESSING: Notification time: {}, Current time: {}, Is before: {}",
                    notification.getScheduledTime(), now,
                    notification.getScheduledTime().isBefore(now));

            // Send emails
            if (event.getGuests() != null && !event.getGuests().isEmpty()) {
                String[] emails = event.getGuests().split(",");
                for (String email : emails) {
                    mailService.sendEventNotification(event, email.trim());
                    log.info("Email sent to {}", email.trim());
                }
            }

            // Mark as sent
            notification.setSent(true);
            notification.setSentAt(LocalDateTime.now());
            notificationRepository.save(notification);

            return ResponseEntity.ok("Notification processed successfully");
        } catch (Exception e) {
            log.error("Error processing notification: {}", e.getMessage(), e);
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @PostMapping("/debug/update-time/{id}")
    public ResponseEntity<String> updateNotificationTime(@PathVariable Long id) {
        try {
            EventNotification notification = notificationRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Notification not found"));

            LocalDateTime tenMinutesAgo = LocalDateTime.now().minusMinutes(10);
            notification.setScheduledTime(tenMinutesAgo);
            notification = notificationRepository.save(notification);

            return ResponseEntity.ok("Notification time updated to: " + tenMinutesAgo);
        } catch (Exception e) {
            log.error("Error updating notification: {}", e.getMessage(), e);
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @PostMapping("/debug/run-scheduler")
    public ResponseEntity<String> runScheduler() {
        try {
            eventService.processNotificationsBatch();
            return ResponseEntity.ok("Scheduler execution triggered manually");
        } catch (Exception e) {
            log.error("Error running scheduler: {}", e.getMessage(), e);
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }
    @GetMapping("/{id}")
    public ResponseEntity<EventDto> getEventById(@PathVariable Long id) {
        return ResponseEntity.ok(eventService.getEventById(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<EventDto> updateEvent(@PathVariable Long id, @RequestBody EventDto eventDto) {
        return ResponseEntity.ok(eventService.updateEvent(id, eventDto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEvent(@PathVariable Long id) {
        eventService.deleteEvent(id);
        return ResponseEntity.noContent().build();
    }
}