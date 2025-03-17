package com.rh_app.hr_app.features.recruitment.model;


import com.rh_app.hr_app.core.enums.StatutCondidat;
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
@Table(name = "condidat")
public class Condidat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idCondidat;

    @Column(nullable = false)
    private String nom;

    @Column(nullable = false)
    private String prenom;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String CV;

    @Column(nullable = false)
    private StatutCondidat statut;

}
