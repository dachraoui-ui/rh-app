package com.rh_app.hr_app.features.contract.model;


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
    private Long idContrat;

    @Column(nullable = false)
    private String contratType;

    @Column(nullable = false)
    private Date DateDebut;

    @Column(nullable = false)
    private Date DateFin;

    @Column(nullable = false)
    private  Double salaire;

    // !to do : employee id


}
