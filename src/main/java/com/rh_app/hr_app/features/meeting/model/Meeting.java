package com.rh_app.hr_app.features.meeting.model;


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
@Table(name = "reunion")
public class Meeting {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idReunion;

    @Column(nullable = false)
    private String sujet;

    @Column(nullable = false)
    private Date dateDebut;

    @Column(nullable = false)
    private String pvReunion;

}
