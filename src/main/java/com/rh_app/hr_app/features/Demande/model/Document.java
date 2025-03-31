package com.rh_app.hr_app.features.Demande.model;


import com.rh_app.hr_app.core.enums.StatutDocument;
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
@Table(name = "document")
public class Document {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idDemandeDoc;

    @Column(nullable = false)
    private StatutDocument statut;

    @Column(nullable = false)
    private String typeDoc;


    // relation et 
    // ! relation avec l'employe


}
