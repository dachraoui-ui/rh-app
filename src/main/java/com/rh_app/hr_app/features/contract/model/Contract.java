package com.rh_app.hr_app.features.contract.model;

import com.rh_app.hr_app.core.enums.ContractType;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.util.Date;

@Getter
@Setter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "contrat")
public class Contract {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ContractType type;

    @Column(name = "start_date", nullable = false)
    private Date start_date;

    @Column(name = "end_date", nullable =true)
    private Date end_date;

    @Column(nullable = false)
    private Double salary;

    @Column(nullable = true)
    private String Currency;

    @Column(nullable = false)
    private boolean isActive = true; // Indicates if the contract is currently active

    @Column(name = "employee_id", nullable = false)
    private String employeeId; // ID from Keycloak
}