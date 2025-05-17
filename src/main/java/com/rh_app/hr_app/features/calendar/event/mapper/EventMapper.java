package com.rh_app.hr_app.features.calendar.event.mapper;

import com.rh_app.hr_app.features.calendar.event.dto.EventDto;
import com.rh_app.hr_app.features.calendar.event.dto.NotificationDto;
import com.rh_app.hr_app.features.calendar.event.model.Event;
import com.rh_app.hr_app.features.calendar.event.model.EventNotification;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class EventMapper {

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ISO_DATE;
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");

    public Event toEntity(EventDto dto) {
        Event event = Event.builder()
                .title(dto.getTitle())
                .date(LocalDate.parse(dto.getDate(), DATE_FORMATTER))
                .calendarType(dto.getCalendarType())
                .allDay(dto.isAllDay())
                .description(dto.getDescription())
                .location(dto.getLocation())
                .guests(dto.getGuests())
                .importance(dto.getImportance())
                .notifications(new ArrayList<>()) // Initialize list to avoid null
                .build();

        if (!dto.isAllDay() && dto.getStartTime() != null) {
            event.setStartTime(LocalTime.parse(dto.getStartTime(), TIME_FORMATTER));
        }

        if (!dto.isAllDay() && dto.getEndTime() != null) {
            event.setEndTime(LocalTime.parse(dto.getEndTime(), TIME_FORMATTER));
        }

        return event;
    }

    public EventDto toDto(Event event) {
        EventDto dto = EventDto.builder()
                .id(event.getId())
                .title(event.getTitle())
                .date(event.getDate().format(DATE_FORMATTER))
                .calendarType(event.getCalendarType())
                .allDay(event.isAllDay())
                .description(event.getDescription())
                .location(event.getLocation())
                .guests(event.getGuests())
                .importance(event.getImportance())
                .build();

        if (event.getStartTime() != null) {
            dto.setStartTime(event.getStartTime().format(TIME_FORMATTER));
        }

        if (event.getEndTime() != null) {
            dto.setEndTime(event.getEndTime().format(TIME_FORMATTER));
        }

        // Add null check before streaming
        List<NotificationDto> notificationDtos = new ArrayList<>();
        if (event.getNotifications() != null) {
            notificationDtos = event.getNotifications().stream()
                    .map(n -> new NotificationDto(n.getType(), n.getMinutesBefore()))
                    .collect(Collectors.toList());
        }
        dto.setNotifications(notificationDtos);

        return dto;
    }
}