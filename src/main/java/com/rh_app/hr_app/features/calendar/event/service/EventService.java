package com.rh_app.hr_app.features.calendar.event.service;

import com.rh_app.hr_app.core.email.MailService;
import com.rh_app.hr_app.features.calendar.event.dto.EventDto;
import com.rh_app.hr_app.features.calendar.event.dto.NotificationDto;
import com.rh_app.hr_app.features.calendar.event.mapper.EventMapper;
import com.rh_app.hr_app.features.calendar.event.model.Event;
import com.rh_app.hr_app.features.calendar.event.model.EventNotification;
import com.rh_app.hr_app.features.calendar.event.repository.EventNotificationRepository;
import com.rh_app.hr_app.features.calendar.event.repository.EventRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class EventService {

    private final EventRepository eventRepository;
    private final EventNotificationRepository notificationRepository;
    private final EventMapper eventMapper;
    private final MailService mailService;
    private final PlatformTransactionManager transactionManager;
    private static final Logger log = LoggerFactory.getLogger(EventService.class);

    @Transactional
    public EventDto createEvent(EventDto eventDto) {
        Event event = eventMapper.toEntity(eventDto);
        log.info("Creating event: {}", event.getTitle());

        // Save the event first to get an ID
        event = eventRepository.save(event);
        log.info("Saved event with ID: {}", event.getId());

        // Process notifications
        if (eventDto.getNotifications() != null) {
            log.info("Processing {} notifications", eventDto.getNotifications().size());
            for (NotificationDto notifDto : eventDto.getNotifications()) {
                if ("email".equals(notifDto.getType())) {
                    createNotification(event, notifDto);
                }
            }
        }

        // Save again to ensure all notifications are persisted
        event = eventRepository.save(event);
        log.info("Event saved with {} notifications", event.getNotifications().size());

        return eventMapper.toDto(event);
    }

    @Transactional
    public EventDto updateEvent(Long eventId, EventDto eventDto) {
        return updateEvent(eventId, eventDto, false, false);
    }

    @Transactional
    public EventDto updateEvent(Long eventId, EventDto eventDto, boolean replaceNotifications) {
        return updateEvent(eventId, eventDto, replaceNotifications, false);
    }

    @Transactional
    public EventDto updateEvent(Long eventId, EventDto eventDto, boolean replaceNotifications, boolean skipNotificationSending) {
        log.info("Updating event with ID: {}, replace notifications: {}, skip notification sending: {}", 
                eventId, replaceNotifications, skipNotificationSending);

        Event existingEvent = eventRepository.findById(eventId)
                .orElseThrow(() -> new RuntimeException("Event not found with ID: " + eventId));

        // Update basic properties
        existingEvent.setTitle(eventDto.getTitle());
        existingEvent.setDescription(eventDto.getDescription());
        existingEvent.setDate(eventMapper.toEntity(eventDto).getDate());
        existingEvent.setStartTime(eventMapper.toEntity(eventDto).getStartTime());
        existingEvent.setEndTime(eventMapper.toEntity(eventDto).getEndTime());
        existingEvent.setAllDay(eventDto.isAllDay());
        existingEvent.setLocation(eventDto.getLocation());
        existingEvent.setGuests(eventDto.getGuests());
        existingEvent.setImportance(eventDto.getImportance());
        existingEvent.setCalendarType(eventDto.getCalendarType());

        // Create a set of existing notification time/type pairs to avoid duplicates
        // Only if skipNotificationSending is true
        Set<String> existingNotificationKeys = new HashSet<>();
        if (skipNotificationSending) {
            existingEvent.getNotifications().forEach(notification -> {
                String key = notification.getType() + ":" + notification.getMinutesBefore();
                existingNotificationKeys.add(key);
                log.debug("Found existing notification: {}", key);
            });
        }

        // Handle notifications based on the flag
        if (replaceNotifications) {
            log.info("Replacing all notifications for event ID: {}", eventId);
            
            // First save notification IDs for later deletion
            List<Long> notificationIdsToDelete = existingEvent.getNotifications().stream()
                    .map(EventNotification::getId)
                    .collect(java.util.stream.Collectors.toList());
            
            // Clear the collection
            existingEvent.getNotifications().clear();
            
            // Delete the notifications from the repository
            for (Long notificationId : notificationIdsToDelete) {
                notificationRepository.deleteById(notificationId);
            }
            
            // Add new notifications from the DTO
            if (eventDto.getNotifications() != null) {
                log.info("Adding {} new notifications", eventDto.getNotifications().size());
                for (NotificationDto notifDto : eventDto.getNotifications()) {
                    if ("email".equals(notifDto.getType())) {
                        String key = notifDto.getType() + ":" + notifDto.getTime();
                        boolean shouldSkip = skipNotificationSending && existingNotificationKeys.contains(key);
                        
                        if (shouldSkip) {
                            log.info("Skipping notification send for existing notification: {}", key);
                            createNotificationWithoutSending(existingEvent, notifDto);
                        } else {
                            createNotification(existingEvent, notifDto);
                        }
                    }
                }
            }
        } else {
            // Original logic: only remove unsent notifications
            log.info("Using original notification update logic (keeping sent notifications)");
            List<EventNotification> notificationsToRemove = existingEvent.getNotifications().stream()
                    .filter(notification -> !notification.isSent())
                    .toList();

            for (EventNotification notification : notificationsToRemove) {
                existingEvent.getNotifications().remove(notification);
                notificationRepository.delete(notification);
            }

            // Add new notifications from the DTO
            if (eventDto.getNotifications() != null) {
                for (NotificationDto notifDto : eventDto.getNotifications()) {
                    if ("email".equals(notifDto.getType())) {
                        String key = notifDto.getType() + ":" + notifDto.getTime();
                        boolean shouldSkip = skipNotificationSending && existingNotificationKeys.contains(key);
                        
                        if (shouldSkip) {
                            log.info("Skipping notification send for existing notification: {}", key);
                            createNotificationWithoutSending(existingEvent, notifDto);
                        } else {
                            createNotification(existingEvent, notifDto);
                        }
                    }
                }
            }
        }

        // Save updated event
        existingEvent = eventRepository.save(existingEvent);
        log.info("Event updated successfully: {}", existingEvent.getTitle());

        return eventMapper.toDto(existingEvent);
    }

    @Transactional
    public void deleteEvent(Long eventId) {
        log.info("Deleting event with ID: {}", eventId);

        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new RuntimeException("Event not found with ID: " + eventId));

        // Soft delete
        event.setDeleted(true);
        eventRepository.save(event);

        log.info("Event soft-deleted: {}", event.getTitle());
    }

    @Transactional
    public void deleteNotification(Long notificationId) {
        log.info("Deleting notification with ID: {}", notificationId);

        EventNotification notification = notificationRepository.findById(notificationId)
                .orElseThrow(() -> new RuntimeException("Notification not found with ID: " + notificationId));

        // Remove from parent event's collection to maintain relationship integrity
        Event parentEvent = notification.getEvent();
        parentEvent.getNotifications().remove(notification);

        // Delete the notification
        notificationRepository.delete(notification);

        // Save the parent event to update its notifications collection
        eventRepository.save(parentEvent);

        log.info("Notification with ID: {} deleted successfully", notificationId);
    }

    @Transactional(readOnly = true)
    public EventDto getEventById(Long eventId) {
        log.info("Fetching event with ID: {}", eventId);

        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new RuntimeException("Event not found with ID: " + eventId));

        return eventMapper.toDto(event);
    }

    private void createNotification(Event event, NotificationDto notifDto) {
        // Calculate when the event will happen
        LocalDateTime eventDateTime = event.getDate().atTime(
                event.isAllDay() ? LocalTime.NOON : event.getStartTime());

        // Calculate when the notification should be sent
        LocalDateTime notificationTime = eventDateTime.minusMinutes(notifDto.getTime());

        LocalDateTime now = LocalDateTime.now();
        boolean isInPast = notificationTime.isBefore(now);

        log.info("Creating notification for event '{}': event at {}, notification at {}, isPast={}",
                event.getTitle(), eventDateTime, notificationTime, isInPast);

        // Create notification entity
        EventNotification notification = EventNotification.builder()
                .event(event)
                .type(notifDto.getType())
                .minutesBefore(notifDto.getTime())
                .scheduledTime(notificationTime)  // This is when to SEND the notification
                .sent(isInPast)
                .sentAt(isInPast ? now : null)
                .build();

        // Add to event's collection
        event.getNotifications().add(notification);

        // If notification time is in past, send immediately
        if (isInPast) {
            log.info("Notification time is in past, sending immediately");
            sendNotificationEmails(event);
        } else {
            log.info("Notification will be sent at: {}", notificationTime);
        }
    }

    // Helper method to create a notification without sending immediate emails
    private void createNotificationWithoutSending(Event event, NotificationDto notifDto) {
        // Calculate when the event will happen
        LocalDateTime eventDateTime = event.getDate().atTime(
                event.isAllDay() ? LocalTime.NOON : event.getStartTime());

        // Calculate when the notification should be sent
        LocalDateTime notificationTime = eventDateTime.minusMinutes(notifDto.getTime());

        LocalDateTime now = LocalDateTime.now();
        boolean isInPast = notificationTime.isBefore(now);

        log.info("Creating notification (without sending) for event '{}': event at {}, notification at {}, isPast={}",
                event.getTitle(), eventDateTime, notificationTime, isInPast);

        // Create notification entity
        EventNotification notification = EventNotification.builder()
                .event(event)
                .type(notifDto.getType())
                .minutesBefore(notifDto.getTime())
                .scheduledTime(notificationTime)
                .sent(isInPast)
                .sentAt(isInPast ? now : null)
                .build();

        // Add to event's collection
        event.getNotifications().add(notification);
    }

    @Transactional(readOnly = true)
    public List<EventDto> getAllEvents() {
        return eventRepository.findAllActive().stream()
                .map(eventMapper::toDto)
                .toList();
    }

    @Transactional(readOnly = true)
    public List<EventDto> getAllEvents(String guestEmail) {
        List<Event> events;
        
        if (guestEmail != null && !guestEmail.trim().isEmpty()) {
            log.info("Filtering events by guest email: {}", guestEmail);
            events = eventRepository.findByGuestEmailContainingAndNotDeleted(guestEmail.trim());
        } else {
            events = eventRepository.findAllActive();
        }
        
        return events.stream()
                .map(eventMapper::toDto)
                .toList();
    }

    // Updated scheduler with explicit transaction management
    @Scheduled(fixedRate = 60000, initialDelay = 10000)
    public void processScheduledNotifications() {
        LocalDateTime now = LocalDateTime.now();
        log.info("SCHEDULER: Running notification check at {}", now);

        TransactionTemplate transactionTemplate = new TransactionTemplate(transactionManager);
        transactionTemplate.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
        transactionTemplate.setTimeout(30); // 30 second timeout

        try {
            transactionTemplate.execute(status -> {
                processNotificationsBatchInternal();
                return null;
            });
            log.info("SCHEDULER: Completed notification processing successfully");
        } catch (Exception e) {
            log.error("SCHEDULER CRITICAL ERROR: Failed to process notifications: {}", e.getMessage(), e);
        }
    }

    private void processNotificationsBatchInternal() {
        LocalDateTime now = LocalDateTime.now();
        log.info("Looking for notifications scheduled before {}", now);

        List<EventNotification> dueNotifications = notificationRepository
                .findByScheduledTimeBeforeAndSentFalse(now);

        log.info("Found {} notifications due for processing", dueNotifications.size());

        for (EventNotification notification : dueNotifications) {
            try {
                // Explicitly load the full event to avoid lazy loading issues
                Long eventId = notification.getEvent().getId();
                Event event = eventRepository.findById(eventId)
                        .orElseThrow(() -> new RuntimeException("Event not found: " + eventId));

                log.info("Processing notification ID={} for event '{}' (scheduled at {})",
                        notification.getId(), event.getTitle(), notification.getScheduledTime());

                if ("email".equals(notification.getType())) {
                    sendNotificationEmails(event);
                }

                // Mark as sent
                notification.setSent(true);
                notification.setSentAt(now);
                notificationRepository.save(notification);

                log.info("Successfully processed notification ID={}", notification.getId());
            } catch (Exception e) {
                log.error("Error processing notification ID={}: {}",
                        notification.getId(), e.getMessage(), e);
            }
        }
    }

    // This method is used for both manual and scheduled processing
    @Transactional
    public void processNotificationsBatch() {
        TransactionTemplate transactionTemplate = new TransactionTemplate(transactionManager);
        transactionTemplate.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);

        try {
            transactionTemplate.execute(status -> {
                processNotificationsBatchInternal();
                return null;
            });
        } catch (Exception e) {
            log.error("Error processing notifications batch: {}", e.getMessage(), e);
            throw e; // Rethrow for manual calls to see the error
        }
    }

    private void sendNotificationEmails(Event event) {
        if (event.getGuests() != null && !event.getGuests().isEmpty()) {
            String[] emails = event.getGuests().split(",");
            for (String email : emails) {
                try {
                    String trimmedEmail = email.trim();
                    log.info("Sending email to {} for event '{}'", trimmedEmail, event.getTitle());
                    mailService.sendEventNotification(event, trimmedEmail);
                } catch (Exception e) {
                    log.error("Failed to send email to {}: {}", email, e.getMessage(), e);
                }
            }
        } else {
            log.warn("No guests to notify for event '{}'", event.getTitle());
        }
    }

    // Debug methods
    @Transactional(readOnly = true)
    public List<EventNotification> getPendingNotifications() {
        LocalDateTime now = LocalDateTime.now();
        log.info("Getting pending notifications (scheduled before {})", now);
        return notificationRepository.findByScheduledTimeBeforeAndSentFalse(now);
    }

    @Transactional(readOnly = true)
    public List<EventNotification> getAllNotifications() {
        return notificationRepository.findAll();
    }
}
