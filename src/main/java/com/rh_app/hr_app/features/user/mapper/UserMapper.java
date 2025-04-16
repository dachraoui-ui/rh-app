package com.rh_app.hr_app.features.user.mapper;

import com.rh_app.hr_app.features.user.dto.UserDto;
import org.keycloak.representations.idm.UserRepresentation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserMapper {

    // Convert UserDto → UserRepresentation (for creating/updating users)
    public static UserRepresentation toUserRepresentation(UserDto dto) {
        UserRepresentation user = new UserRepresentation();

        // Basic user properties
        user.setUsername(dto.getEmail()); // using email as username
        user.setEmail(dto.getEmail());
        user.setFirstName(dto.getFirstName());
        user.setLastName(dto.getLastName());
        user.setEnabled(Boolean.TRUE.equals(dto.getIsActive()));

        // Custom Keycloak attributes
        Map<String, List<String>> attributes = new HashMap<>();

        // Existing attributes
        if (dto.getCin() != null) {
            attributes.put("cin", List.of(dto.getCin()));
        }
        if (dto.getTelephone() != null) {
            attributes.put("telephone", List.of(dto.getTelephone()));
        }
        if (dto.getPhotoUrl() != null) {
            attributes.put("photoUrl", List.of(dto.getPhotoUrl()));
        }
        if (dto.getDepartmentId() != null) {
            attributes.put("departmentId", List.of(dto.getDepartmentId()));
        }
        if (dto.getSalary() != null) {
            attributes.put("salary", List.of(dto.getSalary().toString()));
        }
        if (dto.getRole() != null) {
            attributes.put("role", List.of(dto.getRole()));
        }

        // New attributes
        if (dto.getBirth_Date() != null) {
            attributes.put("Birth_Date", List.of(dto.getBirth_Date()));
        }
        if (dto.getGender() != null) {
            attributes.put("Gender", List.of(dto.getGender()));
        }
        if (dto.getMaterial_Status() != null) {
            attributes.put("Material_Status", List.of(dto.getMaterial_Status()));
        }
        if (dto.getStreet() != null) {
            attributes.put("Street", List.of(dto.getStreet()));
        }
        if (dto.getCity() != null) {
            attributes.put("City", List.of(dto.getCity()));
        }
        if (dto.getZIP() != null) {
            attributes.put("ZIP", List.of(dto.getZIP()));
        }
        if (dto.getCountry() != null) {
            attributes.put("Country", List.of(dto.getCountry()));
        }
        if (dto.getPay_Schedule() != null) {
            attributes.put("Pay_Schedule", List.of(dto.getPay_Schedule()));
        }
        if (dto.getPay_Type() != null) {
            attributes.put("Pay_Type", List.of(dto.getPay_Type()));
        }
        if (dto.getEthnicity() != null) {
            attributes.put("Ethnicity", List.of(dto.getEthnicity()));
        }
        if (dto.getWork_Phone() != null) {
            attributes.put("Work_Phone", List.of(dto.getWork_Phone()));
        }
        if (dto.getMobile_Phone() != null) {
            attributes.put("Mobile_Phone", List.of(dto.getMobile_Phone()));
        }
        if (dto.getWork_Email() != null) {
            attributes.put("Work_Email", List.of(dto.getWork_Email()));
        }
        if (dto.getHire_Date() != null) {
            attributes.put("Hire_Date", List.of(dto.getHire_Date()));
        }
        if (dto.getJob_Title() != null) {
            attributes.put("Job_Title", List.of(dto.getJob_Title()));
        }
        if (dto.getLocation() != null) {
            attributes.put("Location", List.of(dto.getLocation()));
        }

        user.setAttributes(attributes);
        user.setRequiredActions(List.of("UPDATE_PASSWORD"));

        return user;
    }

    // Convert UserRepresentation → UserDto (for fetching users)
    public static UserDto fromUserRepresentation(UserRepresentation user) {
        Map<String, List<String>> attributes = user.getAttributes();

        return UserDto.builder()
                .id(user.getId())
                .username(user.getUsername())
                .email(user.getEmail())
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .cin(getAttribute(attributes, "cin"))
                .telephone(getAttribute(attributes, "telephone"))
                .photoUrl(getAttribute(attributes, "photoUrl"))
                .departmentId(getAttribute(attributes, "departmentId"))
                .salary(parseDouble(getAttribute(attributes, "salary")))
                // Mapping the role field from the Keycloak attribute
                .role(getAttribute(attributes, "role"))
                .isActive(user.isEnabled())
                // New attributes
                .Birth_Date(getAttribute(attributes, "Birth_Date"))
                .Gender(getAttribute(attributes, "Gender"))
                .Material_Status(getAttribute(attributes, "Material_Status"))
                .Street(getAttribute(attributes, "Street"))
                .City(getAttribute(attributes, "City"))
                .ZIP(getAttribute(attributes, "ZIP"))
                .Country(getAttribute(attributes, "Country"))
                .Pay_Schedule(getAttribute(attributes, "Pay_Schedule"))
                .Pay_Type(getAttribute(attributes, "Pay_Type"))
                .Ethnicity(getAttribute(attributes, "Ethnicity"))
                .Work_Phone(getAttribute(attributes, "Work_Phone"))
                .Mobile_Phone(getAttribute(attributes, "Mobile_Phone"))
                .Work_Email(getAttribute(attributes, "Work_Email"))
                .Hire_Date(getAttribute(attributes, "Hire_Date"))
                .Job_Title(getAttribute(attributes, "Job_Title"))
                .Location(getAttribute(attributes, "Location"))
                .build();
    }

    private static String getAttribute(Map<String, List<String>> attributes, String key) {
        if (attributes != null && attributes.containsKey(key)) {
            return attributes.get(key).get(0);
        }
        return null;
    }

    private static Double parseDouble(String value) {
        try {
            return value != null ? Double.parseDouble(value) : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
