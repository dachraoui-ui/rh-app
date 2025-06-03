package com.rh_app.hr_app.features.calendar.event.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EventKpiDto {

    // KPI 1: Total Events This Month
    private long totalEventsThisMonth;

    // KPI 2: Events by Calendar Type Distribution
    private Map<String, Long> eventsByCalendarType;

    // KPI 3: Events by Importance Level
    private Map<String, Long> eventsByImportance;

    // KPI 4: Upcoming vs Past Events
    private long upcomingEvents;
    private long pastEvents;
}