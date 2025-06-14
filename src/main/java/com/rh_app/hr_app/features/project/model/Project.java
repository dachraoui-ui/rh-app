package com.rh_app.hr_app.features.project.model;


import com.rh_app.hr_app.features.task.model.Task;
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
@Table(name = "projet")
public class Project {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;
    private String description;

    @OneToMany(mappedBy = "projet", cascade = CascadeType.ALL)
    private Set<Task> taches;


}
