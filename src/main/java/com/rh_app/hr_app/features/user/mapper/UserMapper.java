package com.rh_app.hr_app.features.user.mapper;

import com.rh_app.hr_app.features.user.dto.UserDto;
import org.keycloak.representations.idm.UserRepresentation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserMapper {

    public static UserRepresentation toUserRepresentation(UserDto dto) {
        UserRepresentation user = new UserRepresentation();

        user.setUsername(dto.getEmail()); // use email as username
        user.setEmail(dto.getEmail());
        user.setFirstName(dto.getFirstName());
        user.setLastName(dto.getLastName());
        user.setEnabled(Boolean.TRUE.equals(dto.getIsActive())); // default false if null

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

        user.setAttributes(attributes);
        user.setRequiredActions(List.of("UPDATE_PASSWORD"));


        return user;
    }
}
