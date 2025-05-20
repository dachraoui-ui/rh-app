package com.rh_app.hr_app.features.project.model;


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
@Table(name = "employee_projet_role")
public class EmployeeProjetRole {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idEmpProjetRole;


    @ManyToOne
    @JoinColumn(name = "projet_id", nullable = false)
    private Project projet;

    @ManyToOne
    @JoinColumn(name = "projet_role_id", nullable = false)
    private ProjectRole role;

}
