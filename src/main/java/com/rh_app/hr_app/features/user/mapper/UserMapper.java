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
        if (dto.getTel() != null) {
            attributes.put("telephone", List.of(dto.getTel()));
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
        if (dto.getBirthDate() != null) {
            attributes.put("birthDate", List.of(dto.getBirthDate()));
        }
        if (dto.getGender() != null) {
            attributes.put("gender", List.of(dto.getGender()));
        }
        if (dto.getMaritalStatus() != null) {
            attributes.put("maritalStatus", List.of(dto.getMaritalStatus()));
        }
        if (dto.getStreet() != null) {
            attributes.put("street", List.of(dto.getStreet()));
        }
        if (dto.getCity() != null) {
            attributes.put("city", List.of(dto.getCity()));
        }
        if (dto.getZip() != null) {
            attributes.put("zip", List.of(dto.getZip()));
        }
        if (dto.getCountry() != null) {
            attributes.put("country", List.of(dto.getCountry()));
        }
        if (dto.getPaySchedule() != null) {
            attributes.put("paySchedule", List.of(dto.getPaySchedule()));
        }
        if (dto.getPayType() != null) {
            attributes.put("payType", List.of(dto.getPayType()));
        }
        if (dto.getEthnicity() != null) {
            attributes.put("ethnicity", List.of(dto.getEthnicity()));
        }
        if (dto.getWorkPhone() != null) {
            attributes.put("workPhone", List.of(dto.getWorkPhone()));
        }
        if (dto.getMobilePhone() != null) {
            attributes.put("mobilePhone", List.of(dto.getMobilePhone()));
        }
        if (dto.getWorkEmail() != null) {
            attributes.put("workEmail", List.of(dto.getWorkEmail()));
        }
        if (dto.getHireDate() != null) {
            attributes.put("hireDate", List.of(dto.getHireDate()));
        }
        if (dto.getJobTitle() != null) {
            attributes.put("jobTitle", List.of(dto.getJobTitle()));
        }
        if (dto.getLocation() != null) {
            attributes.put("location", List.of(dto.getLocation()));
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
                .tel(getAttribute(attributes, "telephone"))
                .photoUrl(getAttribute(attributes, "photoUrl"))
                .departmentId(getAttribute(attributes, "departmentId"))
                .salary(parseDouble(getAttribute(attributes, "salary")))
                // Mapping the role field from the Keycloak attribute
                .role(getAttribute(attributes, "role"))
                .isActive(user.isEnabled())
                // New attributes
                .birthDate(getAttribute(attributes, "birthDate"))
                .gender(getAttribute(attributes, "gender"))
                .maritalStatus(getAttribute(attributes, "maritalStatus"))
                .street(getAttribute(attributes, "street"))
                .city(getAttribute(attributes, "city"))
                .zip(getAttribute(attributes, "zip"))
                .country(getAttribute(attributes, "country"))
                .paySchedule(getAttribute(attributes, "paySchedule"))
                .payType(getAttribute(attributes, "payType"))
                .ethnicity(getAttribute(attributes, "ethnicity"))
                .workPhone(getAttribute(attributes, "workPhone"))
                .mobilePhone(getAttribute(attributes, "mobilePhone"))
                .workEmail(getAttribute(attributes, "workEmail"))
                .hireDate(getAttribute(attributes, "hireDate"))
                .jobTitle(getAttribute(attributes, "jobTitle"))
                .location(getAttribute(attributes, "location"))
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
