package com.rh_app.hr_app.features.calendar.event.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EventDto {
    private Long id;
    private String title;
    private String date;
    private String startTime;
    private String endTime;
    private String calendarType;
    private boolean allDay;
    private String description;
    private String location;
    private String guests;
    private String importance;
    private List<NotificationDto> notifications;
}