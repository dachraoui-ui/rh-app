package com.rh_app.hr_app.features.user.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserDto {
    private String id;
    private String username;
    private String email;
    private String firstName;
    private String lastName;
    private String cin;
    private String tel;
    private String photoUrl;
    private String departmentId;
    private Double salary;
    private Boolean isActive;
    private String password;

    // Single role field
    private String role;
}
