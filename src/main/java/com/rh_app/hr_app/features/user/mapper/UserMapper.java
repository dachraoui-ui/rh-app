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

        user.setUsername(dto.getEmail()); // using email as username
        user.setEmail(dto.getEmail());
        user.setFirstName(dto.getFirstName());
        user.setLastName(dto.getLastName());
        user.setEnabled(Boolean.TRUE.equals(dto.getIsActive()));

        // Custom Keycloak attributes
        Map<String, List<String>> attributes = new HashMap<>();

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
        // Adding the role field
        if (dto.getRole() != null) {
            attributes.put("role", List.of(dto.getRole()));
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
