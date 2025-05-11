package com.rh_app.hr_app.features.calendar.event.model;


import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "event_notifications")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EventNotification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "event_id")
    @JsonBackReference // Add this annotation
    private Event event;

    @Column(nullable = false)
    private String type; // 'email' or 'notification'

    @Column(nullable = false)
    private Integer minutesBefore;

    @Column(nullable = false)
    private LocalDateTime scheduledTime;

    @Column(nullable = false)
    private boolean sent = false;

    private LocalDateTime sentAt;
}