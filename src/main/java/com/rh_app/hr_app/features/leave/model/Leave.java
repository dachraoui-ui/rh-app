package com.rh_app.hr_app.features.leave.model;


import com.rh_app.hr_app.core.enums.StatutLeave;
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
@Table(name = "Conge")

public class Leave {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idLeave;

    @Column(nullable = false)
    private String type;

    @Column(nullable = false)
    private Date startDate;

    @Column(nullable = false)
    private Date endDate;

    private String description;

    @Column(nullable = false)
    private StatutLeave statut;

    // !to do : employee id
}
