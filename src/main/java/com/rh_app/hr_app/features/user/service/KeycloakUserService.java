package com.rh_app.hr_app.features.user.service;

import com.rh_app.hr_app.core.email.MailService;
import com.rh_app.hr_app.features.user.dto.UserDto;
import com.rh_app.hr_app.features.user.mapper.UserMapper;
import jakarta.ws.rs.core.Response;
import lombok.RequiredArgsConstructor;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
@RequiredArgsConstructor
public class KeycloakUserService {

    private final Keycloak keycloak;
    private final MailService mailService;

    @Value("${keycloak.admin.realm}")
    private String realm;

    public String createUser(UserDto dto) {
        UserRepresentation user = UserMapper.toUserRepresentation(dto);

        // 1. Create user
        Response response = keycloak.realm(realm).users().create(user);
        if (response.getStatus() != 201) return " Error creating user: " + response.getStatus();

        // 2. Extract user ID
        String userId = response.getLocation().getPath().replaceAll(".*/([^/]+)$", "$1");

        // 3. Set password
        CredentialRepresentation password = new CredentialRepresentation();
        password.setType(CredentialRepresentation.PASSWORD);
        password.setTemporary(true);
        password.setValue(dto.getPassword());

        keycloak.realm(realm).users().get(userId).resetPassword(password);

        // 4. Assign role
        RoleRepresentation role = keycloak.realm(realm).roles().get(dto.getRole()).toRepresentation();
        keycloak.realm(realm).users().get(userId).roles().realmLevel().add(Collections.singletonList(role));

        mailService.sendAccountActivationEmail(dto.getEmail(), dto.getPassword());

        return " User created successfully with ID: " + userId;
    }
}
