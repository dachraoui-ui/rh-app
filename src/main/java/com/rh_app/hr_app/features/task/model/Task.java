package com.rh_app.hr_app.features.task.model;


import com.rh_app.hr_app.core.enums.StatutTask;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "tache")
public class Task {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idTache;

    @Column(nullable = false)
    private String nomTache;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false)
    private StatutTask statut;


}
