package com.rh_app.hr_app.features.calendar.event.service;

import com.rh_app.hr_app.features.calendar.event.dto.EventKpiDto;
import com.rh_app.hr_app.features.calendar.event.repository.EventRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class EventKpiService {

    private final EventRepository eventRepository;

    @Transactional(readOnly = true)
    public EventKpiDto getEventKpis() {
        LocalDate today = LocalDate.now();
        LocalDate startOfMonth = today.withDayOfMonth(1);
        LocalDate endOfMonth = today.withDayOfMonth(today.lengthOfMonth());

        return EventKpiDto.builder()
                .totalEventsThisMonth(getTotalEventsThisMonth(startOfMonth, endOfMonth))
                .eventsByCalendarType(getEventsByCalendarType())
                .eventsByImportance(getEventsByImportance())
                .upcomingEvents(getUpcomingEvents(today))
                .pastEvents(getPastEvents(today))
                .build();
    }

    private long getTotalEventsThisMonth(LocalDate startOfMonth, LocalDate endOfMonth) {
        return eventRepository.countEventsThisMonth(startOfMonth, endOfMonth);
    }

    private Map<String, Long> getEventsByCalendarType() {
        List<Object[]> results = eventRepository.countEventsByCalendarType();
        Map<String, Long> eventsByType = new HashMap<>();

        for (Object[] result : results) {
            String calendarType = (String) result[0];
            Long count = (Long) result[1];
            eventsByType.put(calendarType, count);
        }

        return eventsByType;
    }

    private Map<String, Long> getEventsByImportance() {
        List<Object[]> results = eventRepository.countEventsByImportance();
        Map<String, Long> eventsByImportance = new HashMap<>();

        for (Object[] result : results) {
            String importance = (String) result[0];
            Long count = (Long) result[1];
            eventsByImportance.put(importance, count);
        }

        return eventsByImportance;
    }

    private long getUpcomingEvents(LocalDate today) {
        return eventRepository.countUpcomingEvents(today);
    }

    private long getPastEvents(LocalDate today) {
        return eventRepository.countPastEvents(today);
    }
}