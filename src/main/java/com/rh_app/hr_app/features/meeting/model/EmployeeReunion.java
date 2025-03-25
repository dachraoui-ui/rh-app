package com.rh_app.hr_app.features.meeting.model;

import com.rh_app.hr_app.features.employee.model.Employee;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "employee_reunion")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmployeeReunion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idEmpReunion;

    @ManyToOne
    @JoinColumn(name = "employee_id", nullable = false)
    private Employee employee;

    @ManyToOne
    @JoinColumn(name = "reunion_id", nullable = false)
    private Reunion reunion;

    private String role; // Example: "Organizer", "Attendee", "Speaker"

    private boolean attended; // Did the employee attend the meeting?
}
