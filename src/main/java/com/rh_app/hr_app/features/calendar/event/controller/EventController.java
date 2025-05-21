package com.rh_app.hr_app.features.calendar.event.controller;

import com.rh_app.hr_app.core.email.MailService;
import com.rh_app.hr_app.features.calendar.event.dto.EventDto;
import com.rh_app.hr_app.features.calendar.event.model.Event;
import com.rh_app.hr_app.features.calendar.event.model.EventNotification;
import com.rh_app.hr_app.features.calendar.event.repository.EventNotificationRepository;
import com.rh_app.hr_app.features.calendar.event.repository.EventRepository;
import com.rh_app.hr_app.features.calendar.event.service.EventService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
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
    private final EventRepository eventRepository;
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

    @GetMapping("/{id}")
    public ResponseEntity<EventDto> getEventById(@PathVariable Long id) {
        return ResponseEntity.ok(eventService.getEventById(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<EventDto> updateEvent(
            @PathVariable Long id, 
            @RequestBody EventDto eventDto,
            @RequestHeader(value = "X-Replace-Notifications", required = false) String replaceNotifications,
            @RequestHeader(value = "X-Skip-Notification-Sending", required = false) String skipNotificationSending) {
        
        boolean shouldReplaceNotifications = "true".equalsIgnoreCase(replaceNotifications);
        boolean shouldSkipNotificationSending = "true".equalsIgnoreCase(skipNotificationSending);
        
        log.info("Updating event with ID: {}, replace notifications: {}, skip notification sending: {}", 
                id, shouldReplaceNotifications, shouldSkipNotificationSending);
        
        return ResponseEntity.ok(eventService.updateEvent(id, eventDto, shouldReplaceNotifications, shouldSkipNotificationSending));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEvent(@PathVariable Long id) {
        eventService.deleteEvent(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/notify")
    public ResponseEntity<Void> sendImmediateNotification(@PathVariable Long id) {
        log.info("Sending immediate notification for event ID: {}", id);

        try {
            Event event = eventRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Event not found with ID: " + id));

            if (event.getGuests() != null && !event.getGuests().isEmpty()) {
                String[] emails = event.getGuests().split(",");
                for (String email : emails) {
                    mailService.sendEventNotification(event, email.trim());
                    log.info("Immediate notification sent to {} for event '{}'", email.trim(), event.getTitle());
                }
                return ResponseEntity.ok().build();
            } else {
                log.warn("No guests to notify for event '{}'", event.getTitle());
                return ResponseEntity.ok().build();
            }
        } catch (Exception e) {
            log.error("Failed to send notification for event ID {}: {}", id, e.getMessage(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    @DeleteMapping("/notifications/{notificationId}")
    public ResponseEntity<Void> deleteNotification(@PathVariable Long notificationId) {
        try {
            eventService.deleteNotification(notificationId);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            log.error("Failed to delete notification with ID {}: {}", notificationId, e.getMessage(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }


}

