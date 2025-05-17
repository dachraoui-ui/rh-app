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
    private String telephone;
    private String photoUrl;
    private String departmentId;
    private Double salary;
    private String currency;
    private Boolean isActive;
    private String password;
    private String role;


    private String Birth_Date;
    private String Gender;
    private String Material_Status;
    private String Street;
    private String City;
    private String ZIP;
    private String Country;
    private String Pay_Schedule;
    private String Pay_Type;
    private String Ethnicity;
    private String Work_Phone;
    private String Mobile_Phone;
    private String Work_Email;
    private String Hire_Date;
    private String Job_Title;
    private String Location;
    private String contract;
    private Boolean isArchived;
}
