package com.rh_app.hr_app.features.task.model;


import com.rh_app.hr_app.core.enums.StatutTask;
import com.rh_app.hr_app.features.project.model.Project;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import java.util.Set;

@Entity
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "tache")
public class Task {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idTache;

    private String description;

    @Enumerated(EnumType.STRING)
    private StatutTask statut;

    @ManyToOne
    @JoinColumn(name = "projet_id")
    private Project projet;

}
