package com.rh_app.hr_app.features.employee.model;

import com.rh_app.hr_app.features.department.model.Department;


import com.rh_app.hr_app.features.task.model.DateAffectation;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Set;

@Entity
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "employee")
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idEmployee;

    private String nom;
    private String prenom;

    @Column(unique = true, nullable = false)
    private String email;

    private String NumTel;
    private String addresse;
    private LocalDate dateOfBirth;
    private LocalDate hireDate;
    private BigDecimal salary;

    private boolean actif;


    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;



    // New Relationship: Employee is assigned to tasks with start & end dates
    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL)
    private Set<DateAffectation> assignedTasks;
}
