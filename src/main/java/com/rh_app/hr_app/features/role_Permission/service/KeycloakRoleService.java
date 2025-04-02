package com.rh_app.hr_app.features.role_Permission.service;

import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.RoleRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.ws.rs.core.Response;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class KeycloakRoleService {

    @Autowired
    private Keycloak keycloak;

    private final String realm = "RH-Realm";

    public String createRole(String roleName) {
        RoleRepresentation role = new RoleRepresentation();
        role.setName(roleName);

        Response response = keycloak.realm(realm).roles().create(role);
        if (response.getStatus() == 201) return "Role created!";
        if (response.getStatus() == 409) return "Role already exists!";
        return "Error: " + response.getStatus();
    }

    public List<String> getAllRoles() {
        return keycloak.realm(realm).roles()
                .list()
                .stream()
                .map(RoleRepresentation::getName)
                .collect(Collectors.toList());
    }

    public String deleteRole(String roleName) {
        try {
            keycloak.realm(realm).roles().get(roleName).remove();
            return "Role deleted.";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
}
