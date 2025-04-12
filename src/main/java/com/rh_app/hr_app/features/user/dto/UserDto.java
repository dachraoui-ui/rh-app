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
    private String role;


    private String birthDate;
    private String gender;
    private String maritalStatus;
    private String street;
    private String city;
    private String zip;
    private String country;
    private String paySchedule;
    private String payType;
    private String ethnicity;
    private String workPhone;
    private String mobilePhone;
    private String workEmail;
    private String hireDate;
    private String jobTitle;
    private String location;
}
