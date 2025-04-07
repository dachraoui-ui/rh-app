package com.rh_app.hr_app.features.user.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {

    private String id;           // Keycloak User ID
    private String username;
    private String email;
    private String password;
    private String firstName;
    private String lastName;

    private String cin;          // Custom attribute
    private String tel;          // Custom attribute
    private String photoUrl;     // Path to photo stored locally
    private Boolean isActive;    // Whether employee is active
    private String departmentId; // Department reference
    private Double salary;       // Employee salary

    private String role;         // ✅ NEW: Role to assign (e.g. "DRH", "GRH", "Employee")
}
