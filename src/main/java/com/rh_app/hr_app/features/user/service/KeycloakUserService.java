package com.rh_app.hr_app.features.user.service;

import com.rh_app.hr_app.core.email.MailService;
import com.rh_app.hr_app.features.user.dto.SessionDto;
import com.rh_app.hr_app.features.user.dto.UserDto;
import com.rh_app.hr_app.features.user.mapper.UserMapper;
import jakarta.ws.rs.core.Response;
import lombok.RequiredArgsConstructor;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;



import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class KeycloakUserService {

    private final Keycloak keycloak;
    private final MailService mailService;

    @Value("${keycloak.admin.realm}")
    private String realm;

    private static final Logger log = LoggerFactory.getLogger(KeycloakUserService.class);


    //  Create User
    public String createUser(UserDto dto) {
        // Use the mapper to include all custom attributes
        UserRepresentation user = UserMapper.toUserRepresentation(dto);

        // Enable user if isActive is true (or null)
        boolean enabled = (dto.getIsActive() == null) || dto.getIsActive();
        user.setEnabled(enabled);

        log.debug("Sending user creation request to Keycloak");
        Response response = keycloak.realm(realm).users().create(user);
        log.debug("Keycloak response status: {}", response.getStatus());

        if (response.getStatus() != 201) {
            log.error("Failed to create user in Keycloak. Status: {}", response.getStatus());
            return "Error creating user: " + response.getStatus();
        }


        String userId = response.getLocation().getPath().replaceAll(".*/([^/]+)$", "$1");
        log.info("User created in Keycloak with ID: {}", userId);


        log.debug("Setting temporary password for user: {}", userId);
        try {
            // Set temporary password
            CredentialRepresentation credential = new CredentialRepresentation();
            credential.setTemporary(true);
            credential.setType(CredentialRepresentation.PASSWORD);
            credential.setValue(dto.getPassword());

            keycloak.realm(realm).users().get(userId).resetPassword(credential);
            log.debug("Temporary password set successfully");
        } catch (Exception e) {
            log.error("Error setting temporary password: {}", e.getMessage(), e);
            return "User created, but failed to set password: " + e.getMessage();
        }


        // Assign the single role if provided
        log.debug("Checking for role assignment: {}", dto.getRole());
        if (dto.getRole() != null && !dto.getRole().isEmpty()) {
            try {
                // First, list all existing roles for debugging
                List<RoleRepresentation> allRoles = keycloak.realm(realm).roles().list();
                log.debug("Existing roles in Keycloak: {}",
                        allRoles.stream().map(RoleRepresentation::getName).collect(Collectors.joining(", ")));

                // Try to find the role using case-insensitive match
                String requestedRole = dto.getRole().toUpperCase(); // Normalize to uppercase
                RoleRepresentation roleToAdd = null;

                // Look for an existing role with case-insensitive matching
                for (RoleRepresentation role : allRoles) {
                    if (role.getName().equalsIgnoreCase(requestedRole)) {
                        roleToAdd = role;
                        log.debug("Found matching role: {} (requested: {})", role.getName(), requestedRole);
                        break;
                    }
                }

                // If no matching role was found, create it with the EXACT case needed
                if (roleToAdd == null) {
                    log.debug("No matching role found, creating role: {}", requestedRole);
                    try {
                        RoleRepresentation newRole = new RoleRepresentation();
                        newRole.setName(requestedRole); // Use uppercase consistently
                        keycloak.realm(realm).roles().create(newRole);

                        // Small delay to ensure role creation is processed
                        try { Thread.sleep(200); } catch (InterruptedException ignored) {}

                        // Now get the newly created role
                        roleToAdd = keycloak.realm(realm).roles().get(requestedRole).toRepresentation();
                        log.debug("Created new role: {}", requestedRole);
                    } catch (Exception e) {
                        if (e.getMessage().contains("409")) {
                            log.warn("Role '{}' already exists but couldn't be found earlier", requestedRole);
                            roleToAdd = keycloak.realm(realm).roles().get(requestedRole).toRepresentation();
                        } else {
                            throw e;
                        }
                    }
                }

                // Now assign the role
                if (roleToAdd != null) {
                    List<RoleRepresentation> rolesToAdd = Collections.singletonList(roleToAdd);
                    keycloak.realm(realm).users().get(userId).roles().realmLevel().add(rolesToAdd);
                    log.debug("Role '{}' assigned successfully", roleToAdd.getName());
                } else {
                    log.error("Failed to find or create role: {}", requestedRole);
                }
            } catch (Exception e) {
                log.error("Error during role assignment: {}", e.getMessage(), e);
                // Continue with user creation
                return "User created successfully, but role assignment failed: " + e.getMessage();
            }
        }


        // Send email
        try {
            log.debug("Attempting to send activation email to: {}", dto.getEmail());
            mailService.sendAccountActivationEmail(dto.getEmail(), dto.getPassword());
            log.debug("Activation email sent successfully");
        } catch (Exception e) {
            log.error("Failed to send activation email: {}", e.getMessage(), e);
            return "User created successfully, but failed to send activation email: " + e.getMessage();
        }

        return "User created successfully with ID: " + userId;


    }

    //  Update User Profile
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
        if (dto.getContract() != null) {
            user.singleAttribute("contract", dto.getContract());
        }
        if (dto.getIsArchived() != null) {
            user.singleAttribute("isArchived", String.valueOf(dto.getIsArchived()));
        }

        // Set enable/disable status
        user.setEnabled(Boolean.TRUE.equals(dto.getIsActive()));

        keycloak.realm(realm).users().get(userId).update(user);
        // Check if a role update is requested
        if (dto.getRole() != null && !dto.getRole().isEmpty()) {
            try {
                // First, get all current roles for the user and remove them
                List<RoleRepresentation> currentRoles = keycloak.realm(realm).users().get(userId)
                        .roles().realmLevel().listAll()
                        .stream()
                        .filter(role -> !role.getName().startsWith("default-roles-"))
                        .collect(Collectors.toList());

                if (!currentRoles.isEmpty()) {
                    log.debug("Removing current roles: {}",
                            currentRoles.stream().map(RoleRepresentation::getName).collect(Collectors.joining(", ")));
                    keycloak.realm(realm).users().get(userId).roles().realmLevel().remove(currentRoles);
                }

                // Normalize to uppercase for consistency
                String requestedRole = dto.getRole().toUpperCase();
                RoleRepresentation roleToAdd = null;

                // Look for an existing role with case-insensitive matching
                List<RoleRepresentation> allRoles = keycloak.realm(realm).roles().list();
                for (RoleRepresentation role : allRoles) {
                    if (role.getName().equalsIgnoreCase(requestedRole)) {
                        roleToAdd = role;
                        log.debug("Found matching role: {} (requested: {})", role.getName(), requestedRole);
                        break;
                    }
                }

                // If no matching role was found, create it
                if (roleToAdd == null) {
                    log.debug("No matching role found, creating role: {}", requestedRole);
                    try {
                        RoleRepresentation newRoleObj = new RoleRepresentation();
                        newRoleObj.setName(requestedRole);
                        keycloak.realm(realm).roles().create(newRoleObj);

                        // Small delay to ensure role creation is processed
                        try { Thread.sleep(200); } catch (InterruptedException ignored) {}

                        // Now get the newly created role
                        roleToAdd = keycloak.realm(realm).roles().get(requestedRole).toRepresentation();
                        log.debug("Created new role: {}", requestedRole);
                    } catch (Exception e) {
                        if (e.getMessage().contains("409")) {
                            log.warn("Role '{}' already exists but couldn't be found earlier", requestedRole);
                            roleToAdd = keycloak.realm(realm).roles().get(requestedRole).toRepresentation();
                        } else {
                            throw e;
                        }
                    }
                }

                // Assign the new role
                if (roleToAdd != null) {
                    List<RoleRepresentation> rolesToAdd = Collections.singletonList(roleToAdd);
                    keycloak.realm(realm).users().get(userId).roles().realmLevel().add(rolesToAdd);
                    log.debug("Role '{}' assigned successfully", roleToAdd.getName());
                } else {
                    log.error("Failed to find or create role: {}", requestedRole);
                    return "User updated successfully, but failed to update role: Could not find or create role";
                }
            } catch (Exception e) {
                log.error("Error updating user role: {}", e.getMessage(), e);
                return "User updated successfully, but failed to update role: " + e.getMessage();
            }
        }

        return "User updated successfully";

    }
    //  Delete User

    public String deleteUser(String userId) {
        keycloak.realm(realm).users().get(userId).remove();
        return "User deleted successfully";
    }

    //  Get User by ID
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

    //  Get All Users
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

    //  Get User by Username
    public Optional<UserDto> getUserByUsername(String username) {
        List<UserRepresentation> users = keycloak.realm(realm).users().search(username);
        return users.stream().findFirst().map(user -> {
            UserDto userDto = UserMapper.fromUserRepresentation(user);
            List<String> roles = getUserRoles(user.getId());
            userDto.setRole(roles != null && !roles.isEmpty() ? roles.get(0) : null);
            return userDto;
        });
    }
    public UserDto getCurrentUser(String username) {
        return getUserByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(
                        "User not found in Keycloak: " + username));
    }

    //  Get Users by Department
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

    //  Check if User Exists by Email
    public boolean userExistsByEmail(String email) {
        List<UserRepresentation> users = keycloak.realm(realm)
                .users()
                .search(null, null, null, email, 0, 10);

        return users != null && !users.isEmpty();
    }
    //  Get Active Users
    public List<UserDto> getActiveUsers() {
        return getAllUsers().stream()
                .filter(user -> !Boolean.TRUE.equals(user.getIsActive()))
                .collect(Collectors.toList());
    }
    // archive the user
    public void archiveUser(String userId) {
        try {
            UserRepresentation user = keycloak.realm(realm).users().get(userId).toRepresentation();
            Map<String, List<String>> attributes = user.getAttributes() != null ?
                    user.getAttributes() : new HashMap<>();

            attributes.put("isArchived", List.of("true"));
            user.setEnabled(false); // disable the user
            user.setAttributes(attributes);

            keycloak.realm(realm).users().get(userId).update(user);
        } catch (Exception e) {
            throw new RuntimeException("Impossible d'archiver l'utilisateur", e);
        }
    }

    // get the archived users
    public List<UserDto> getArchivedUsers() {
        return keycloak.realm(realm).users().list().stream()
                .map(UserMapper::fromUserRepresentation)
                .filter(user -> Boolean.TRUE.equals(user.getIsArchived()))
                .collect(Collectors.toList());
    }
    // restore the userx
    public void restoreUser(String userId) {
        try {
            UserRepresentation user = keycloak.realm(realm).users().get(userId).toRepresentation();
            Map<String, List<String>> attributes = user.getAttributes() != null ?
                    user.getAttributes() : new HashMap<>();

            attributes.put("isArchived", List.of("false"));
            user.setAttributes(attributes);

            keycloak.realm(realm).users().get(userId).update(user);
        } catch (Exception e) {
            throw new RuntimeException("Impossible de restaurer l'utilisateur", e);
        }
    }



    /** Return *all* active sessions for the realm. */
    public List<SessionDto> getAllUserSessions() {

        // 1. Grab every user in the realm
        return keycloak.realm(realm).users().list().stream()

                // 2. For each user, fetch their sessions and flatten the streams
                .flatMap(user -> keycloak.realm(realm)
                        .users()
                        .get(user.getId())
                        .getUserSessions()
                        .stream()
                        .map(s -> new SessionDto(
                                s.getId(),
                                s.getIpAddress(),
                                s.getStart(),
                                s.getLastAccess(),
                                s.getUsername())))
                // 3. Collect into an *unmodifiable* list (JDK 16+) – use Collectors.toList() on JDK 8–15
                .toList();
    }

    /* kick from session method */
    public void kickFromSession(String sessionId) {
        try {
            // false  ⇒ terminate an online (regular) session
            keycloak.realm(realm).deleteSession(sessionId, false);
            log.info("Successfully terminated session with ID: {}", sessionId);
        } catch (Exception e) {
            log.error("Unable to terminate session with ID {}: {}", sessionId, e.getMessage(), e);
            throw new RuntimeException("Unable to terminate session " + sessionId, e);
        }
    }






    /**
     * Helper method to get a user ID by username
     */
    private String getUserIdByUsername(String username) {
        List<UserRepresentation> users = keycloak.realm(realm).users().search(username);
        if (users.isEmpty()) {
            log.warn("User with username {} not found", username);
            throw new UsernameNotFoundException("User not found: " + username);
        }
        return users.get(0).getId();
    }

//    // test all available roles
//    public List<String> listAllAvailableRoles() {
//        return keycloak.realm(realm).roles().list().stream()
//                .map(role -> role.getName())
//                .collect(Collectors.toList());
//    }



}
