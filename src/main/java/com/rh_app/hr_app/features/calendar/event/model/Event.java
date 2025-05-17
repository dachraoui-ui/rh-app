package com.rh_app.hr_app.features.calendar.event.model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "events")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private LocalDate date;

    private LocalTime startTime;
    private LocalTime endTime;

    @Column(nullable = false)
    private String calendarType; // 'leave', 'internal', 'hr'

    private boolean allDay;
    private String description;
    private String location;

    @Column(nullable = false)
    private String guests; // Comma-separated list of emails

    @Column(nullable = false)
    private String importance; // 'low', 'medium', 'high'

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "event")
    @JsonManagedReference // Add this annotation
    private List<EventNotification> notifications = new ArrayList<>();

    @Column(nullable = false)
    private boolean isDeleted = false;
}
