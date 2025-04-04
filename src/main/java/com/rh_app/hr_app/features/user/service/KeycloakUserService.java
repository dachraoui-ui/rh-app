package com.rh_app.hr_app.features.user.service;

import jakarta.ws.rs.core.Response;
import lombok.RequiredArgsConstructor;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Collections;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;





@Service
@RequiredArgsConstructor
public class KeycloakUserService {
    // Add this at the top of your class (outside methods)
    private static final Logger log = LoggerFactory.getLogger(KeycloakUserService.class); // or your current class name

    private final Keycloak keycloak;

    @Value("${keycloak.admin.realm}")
    private String realm;

    public String createUser(String username, String email, String password, String roleName) {
        // 1. Create user object
        UserRepresentation user = new UserRepresentation();
        user.setUsername(username);
        user.setEmail(email);
        user.setEnabled(true);

        // 2. Create user
        Response response = keycloak.realm(realm).users().create(user);
        if (response.getStatus() != 201) return " Error creating user: " + response.getStatus();

        // 3. Get userId
        String userId = response.getLocation().getPath().replaceAll(".*/([^/]+)$", "$1");

        // 4. Set password
        CredentialRepresentation passwordCred = new CredentialRepresentation();
        passwordCred.setTemporary(false);
        passwordCred.setType(CredentialRepresentation.PASSWORD);
        passwordCred.setValue(password);

        keycloak.realm(realm).users().get(userId).resetPassword(passwordCred);

        RoleRepresentation role = keycloak.realm(realm).roles().get(roleName).toRepresentation();




        keycloak.realm(realm)
                .users()
                .get(userId)
                .roles()
                .realmLevel()
                .add(Collections.singletonList(role));

        return " User created with role: " + roleName;

    }


}
