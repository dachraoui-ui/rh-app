package com.rh_app.hr_app.features.department.model;


import com.rh_app.hr_app.features.employee.model.Employee;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import java.util.Set;

@Entity
@Table(name = "department")
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class Department {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;
    private String description;

//    @OneToOne
//    @JoinColumn(name = "id_manager")
//    private Employee manager;

    @OneToMany(mappedBy = "department")
    private Set<Employee> employees;
}
