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
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class KeycloakUserService {

    private final Keycloak keycloak;
    private final MailService mailService;

    @Value("${keycloak.admin.realm}")
    private String realm;

    // 1. Create User
    public String createUser(UserDto dto) {
        UserRepresentation user = UserMapper.toUserRepresentation(dto);

        // If isActive is false, we disable the user in Keycloak.
        user.setEnabled(Boolean.TRUE.equals(dto.getIsActive()));

        Response response = keycloak.realm(realm).users().create(user);
        if (response.getStatus() != 201) {
            return "Error creating user: " + response.getStatus();
        }

        String userId = response.getLocation().getPath().replaceAll(".*/([^/]+)$", "$1");

        // Set password, roles, etc. as before
        CredentialRepresentation password = new CredentialRepresentation();
        password.setType(CredentialRepresentation.PASSWORD);
        password.setTemporary(true);
        password.setValue(dto.getPassword());

        keycloak.realm(realm).users().get(userId).resetPassword(password);

        RoleRepresentation role = keycloak.realm(realm).roles().get(dto.getRole()).toRepresentation();
        keycloak.realm(realm).users().get(userId).roles().realmLevel().add(Collections.singletonList(role));

        mailService.sendAccountActivationEmail(dto.getEmail(), dto.getPassword());

        return "User created successfully with ID: " + userId;
    }


    // 2. Update User Profile
    public String updateUserProfile(String userId, UserDto dto) {
        UserRepresentation user = keycloak.realm(realm).users().get(userId).toRepresentation();

        user.setFirstName(dto.getFirstName());
        user.setLastName(dto.getLastName());
        user.setEmail(dto.getEmail());
        user.setUsername(dto.getUsername());

        // Map custom attributes
        user.singleAttribute("cin", dto.getCin());
        user.singleAttribute("tel", dto.getTel());
        user.singleAttribute("photoUrl", dto.getPhotoUrl());
        user.singleAttribute("salary", String.valueOf(dto.getSalary()));
        user.singleAttribute("departmentId", dto.getDepartmentId());
        user.singleAttribute("isActive", String.valueOf(dto.getIsActive()));

        // Enable/disable user according to isActive
        user.setEnabled(Boolean.TRUE.equals(dto.getIsActive()));

        keycloak.realm(realm).users().get(userId).update(user);
        return "User updated successfully";
    }


    // 3. Delete User
    public String deleteUser(String userId) {
        keycloak.realm(realm).users().get(userId).remove();
        return "User deleted successfully";
    }

    // 4. Get All Users
    public List<UserDto> getAllUsers() {
        return keycloak.realm(realm).users().list()
                .stream()
                .map(UserMapper::fromUserRepresentation)
                .collect(Collectors.toList());
    }

    // 5. Get User by Username
    public Optional<UserDto> getUserByUsername(String username) {
        List<UserRepresentation> users = keycloak.realm(realm).users().search(username);
        return users.stream().findFirst().map(UserMapper::fromUserRepresentation);
    }

    // 6. Get Users by Department
    public List<UserDto> getUsersByDepartment(String departmentId) {
        return keycloak.realm(realm).users().list()
                .stream()
                .filter(u -> departmentId.equals(u.getAttributes() != null
                        ? u.getAttributes().getOrDefault("departmentId", List.of("")).get(0)
                        : null))
                .map(UserMapper::fromUserRepresentation)
                .collect(Collectors.toList());
    }

    // 7. Check if User Exists by Email
    public boolean userExistsByEmail(String email) {
        // Keycloak Admin Client's "search" can take up to 6 parameters:
        //   (String username, String firstName, String lastName, String email, Integer firstResult, Integer maxResults)
        // Here we pass null for fields we don't want to filter and use email to match.
        // It's partial/fuzzy, but if it returns anything, that means at least one user
        // has an email containing the given text.
        List<UserRepresentation> users = keycloak
                .realm(realm)
                .users()
                .search(null, null, null, email, 0, 10);

        return users != null && !users.isEmpty();
    }
}
