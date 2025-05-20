package com.rh_app.hr_app.features.task.model;


import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "date_affectation")
public class DateAffectation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idDateAffectation;



    @ManyToOne
    @JoinColumn(name = "tache_id", nullable = false)
    private Task tache;

    private LocalDate DateDebut;
    private LocalDate DateFin;
}
