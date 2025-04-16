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
        // Use the mapper to include all custom attributes
        UserRepresentation user = UserMapper.toUserRepresentation(dto);

        // Enable user if isActive is true (or null)
        boolean enabled = (dto.getIsActive() == null) || dto.getIsActive();
        user.setEnabled(enabled);

        Response response = keycloak.realm(realm).users().create(user);
        if (response.getStatus() != 201) {
            return "Error creating user: " + response.getStatus();
        }

        String userId = response.getLocation().getPath().replaceAll(".*/([^/]+)$", "$1");

        // Set temporary password
        CredentialRepresentation password = new CredentialRepresentation();
        password.setType(CredentialRepresentation.PASSWORD);
        password.setTemporary(true);
        password.setValue(dto.getPassword());
        keycloak.realm(realm).users().get(userId).resetPassword(password);

        // Assign a role if provided
        if (dto.getRole() != null && !dto.getRole().isEmpty()) {
            RoleRepresentation role = keycloak.realm(realm).roles().get(dto.getRole()).toRepresentation();
            keycloak.realm(realm).users().get(userId).roles().realmLevel().add(Collections.singletonList(role));
        }

        mailService.sendAccountActivationEmail(dto.getEmail(), dto.getPassword());

        return "User created successfully with ID: " + userId;
    }

    // 2. Update User Profile
    public String updateUserProfile(String userId, UserDto dto) {
        UserRepresentation user = keycloak.realm(realm).users().get(userId).toRepresentation();

        // Update basic information
        user.setFirstName(dto.getFirstName());
        user.setLastName(dto.getLastName());
        user.setEmail(dto.getEmail());
        user.setUsername(dto.getUsername());

        // Update basic custom attributes
        user.singleAttribute("cin", dto.getCin());
        user.singleAttribute("telephone", dto.getTelephone());
        user.singleAttribute("photoUrl", dto.getPhotoUrl());
        user.singleAttribute("salary", String.valueOf(dto.getSalary()));
        user.singleAttribute("departmentId", dto.getDepartmentId());
        user.singleAttribute("isActive", String.valueOf(dto.getIsActive()));

        // Update new custom attributes if they are not null.
        if (dto.getBirth_Date() != null) {
            user.singleAttribute("Birth_Date", dto.getBirth_Date());
        }
        if (dto.getGender() != null) {
            user.singleAttribute("Gender", dto.getGender());
        }
        if (dto.getMaterial_Status() != null) {
            user.singleAttribute("Material_Status", dto.getMaterial_Status());
        }
        if (dto.getStreet() != null) {
            user.singleAttribute("Street", dto.getStreet());
        }
        if (dto.getCity() != null) {
            user.singleAttribute("City", dto.getCity());
        }
        if (dto.getZIP() != null) {
            user.singleAttribute("ZIP", dto.getZIP());
        }
        if (dto.getCountry() != null) {
            user.singleAttribute("Country", dto.getCountry());
        }
        if (dto.getPay_Schedule() != null) {
            user.singleAttribute("Pay_Schedule", dto.getPay_Schedule());
        }
        if (dto.getPay_Type() != null) {
            user.singleAttribute("Pay_Type", dto.getPay_Type());
        }
        if (dto.getEthnicity() != null) {
            user.singleAttribute("Ethnicity", dto.getEthnicity());
        }
        if (dto.getWork_Phone() != null) {
            user.singleAttribute("Work_Phone", dto.getWork_Phone());
        }
        if (dto.getMobile_Phone() != null) {
            user.singleAttribute("Mobile_Phone", dto.getMobile_Phone());
        }
        if (dto.getWork_Email() != null) {
            user.singleAttribute("Work_Email", dto.getWork_Email());
        }
        if (dto.getHire_Date() != null) {
            user.singleAttribute("Hire_Date", dto.getHire_Date());
        }
        if (dto.getJob_Title() != null) {
            user.singleAttribute("Job_Title", dto.getJob_Title());
        }
        if (dto.getLocation() != null) {
            user.singleAttribute("Location", dto.getLocation());
        }

        // Set enable/disable status
        user.setEnabled(Boolean.TRUE.equals(dto.getIsActive()));

        keycloak.realm(realm).users().get(userId).update(user);
        return "User updated successfully";
    }

    // 3. Delete User
    public String deleteUser(String userId) {
        keycloak.realm(realm).users().get(userId).remove();
        return "User deleted successfully";
    }

    // 6. Get User by Id
    public Optional<UserDto> getUserById(String userId) {
        try {
            UserRepresentation user = keycloak.realm(realm).users().get(userId).toRepresentation();
            return Optional.of(UserMapper.fromUserRepresentation(user));
        } catch (Exception e) {
            e.printStackTrace();
            return Optional.empty();
        }
    }

    // Helper method to get a user's roles (excluding default roles)
    private List<String> getUserRoles(String userId) {
        List<RoleRepresentation> roles = keycloak.realm(realm).users().get(userId)
                .roles().realmLevel().listAll();
        return roles.stream()
                .map(RoleRepresentation::getName)
                .filter(roleName -> !roleName.startsWith("default-roles-"))
                .collect(Collectors.toList());
    }

    // 4. Get All Users
    public List<UserDto> getAllUsers() {
        return keycloak.realm(realm).users().list()
                .stream()
                .map(user -> {
                    UserDto userDto = UserMapper.fromUserRepresentation(user);
                    List<String> roles = getUserRoles(user.getId());
                    userDto.setRole(roles != null && !roles.isEmpty() ? roles.get(0) : null);
                    return userDto;
                })
                .collect(Collectors.toList());
    }

    // 5. Get User by Username
    public Optional<UserDto> getUserByUsername(String username) {
        List<UserRepresentation> users = keycloak.realm(realm).users().search(username);
        return users.stream().findFirst().map(user -> {
            UserDto userDto = UserMapper.fromUserRepresentation(user);
            List<String> roles = getUserRoles(user.getId());
            userDto.setRole(roles != null && !roles.isEmpty() ? roles.get(0) : null);
            return userDto;
        });
    }

    // 6. Get Users by Department
    public List<UserDto> getUsersByDepartment(String departmentId) {
        return keycloak.realm(realm).users().list()
                .stream()
                .filter(u -> departmentId.equals(u.getAttributes() != null
                        ? u.getAttributes().getOrDefault("departmentId", List.of("")).get(0)
                        : null))
                .map(user -> {
                    UserDto userDto = UserMapper.fromUserRepresentation(user);
                    List<String> roles = getUserRoles(user.getId());
                    userDto.setRole(roles != null && !roles.isEmpty() ? roles.get(0) : null);
                    return userDto;
                })
                .collect(Collectors.toList());
    }

    // 7. Check if User Exists by Email
    public boolean userExistsByEmail(String email) {
        List<UserRepresentation> users = keycloak.realm(realm)
                .users()
                .search(null, null, null, email, 0, 10);

        return users != null && !users.isEmpty();
    }
    public List<UserDto> getArchivedUsers() {
        return getAllUsers().stream()
                .filter(user -> !Boolean.TRUE.equals(user.getIsActive()))
                .collect(Collectors.toList());
    }

}
