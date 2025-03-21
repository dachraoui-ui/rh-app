package com.rh_app.hr_app.features.meeting.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "reunion")
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class Meeting {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idReunion;

    private LocalDate dateDebut; // Newly added attribute
    private String sujet;
    private String pvReunion;

    @OneToMany(mappedBy = "reunion", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<EmployeeReunion> employeeReunions; // Relationship with EmployeeReunion

}
