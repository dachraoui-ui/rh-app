package com.rh_app.hr_app.features.role_Permission.service;

import jakarta.ws.rs.WebApplicationException;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.RoleRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.stream.Collectors;


@Service
public class KeycloakRoleService {


    private final Keycloak keycloak;
    @Value("${keycloak.admin.realm}")
    private String realm;

    @Autowired
    public KeycloakRoleService(@Qualifier("keycloakAdmin") Keycloak keycloak) {
        this.keycloak = keycloak;
    }

    public String createRole(String roleName) {
        RoleRepresentation role = new RoleRepresentation();
        role.setName(roleName);

        try {
            keycloak.realm(realm).roles().create(role);
            return "✅ Role '" + roleName + "' created successfully!";
        } catch (WebApplicationException e) {
            if (e.getResponse().getStatus() == 409) {
                return "⚠️ Role '" + roleName + "' already exists.";
            }
            return "❌ Failed to create role: " + e.getResponse().getStatusInfo().getReasonPhrase();
        } catch (Exception e) {
            return "❌ Unexpected error: " + e.getMessage();
        }
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
