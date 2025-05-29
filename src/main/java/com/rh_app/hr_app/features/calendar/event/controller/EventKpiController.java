package com.rh_app.hr_app.features.calendar.event.controller;

import com.rh_app.hr_app.features.calendar.event.dto.EventKpiDto;
import com.rh_app.hr_app.features.calendar.event.service.EventKpiService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/events/kpis")
@RequiredArgsConstructor
public class EventKpiController {

    private final EventKpiService eventKpiService;
    private static final Logger log = LoggerFactory.getLogger(EventKpiController.class);

    @GetMapping
    public ResponseEntity<EventKpiDto> getEventKpis() {
        log.info("Fetching event KPIs for dashboard");
        EventKpiDto kpis = eventKpiService.getEventKpis();
        return ResponseEntity.ok(kpis);
    }
}