package com.rh_app.hr_app.features.user.controller;

import com.rh_app.hr_app.features.user.dto.SessionDto;
import com.rh_app.hr_app.features.user.dto.UserDto;
import com.rh_app.hr_app.features.user.service.KeycloakUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
@EnableMethodSecurity(securedEnabled = true)
public class UserController {

    private final KeycloakUserService userService;

    // ✅ Create user - only DRH can create
    @PreAuthorize("hasRole('DRH')")
    @PostMapping("/create")
    public ResponseEntity<String> createUser(@RequestBody UserDto userDto) {
        // 1) Check if user already exists by email
        if (userService.userExistsByEmail(userDto.getEmail())) {
            return ResponseEntity
                    .status(HttpStatus.CONFLICT)
                    .body("User with email " + userDto.getEmail() + " already exists.");
        }

        // 2) Otherwise create the user
        String result = userService.createUser(userDto);
        return ResponseEntity.ok(result);
    }

    // ✅ Update user - only DRH
    @PreAuthorize("hasRole('DRH')")
    @PutMapping("/update/{userId}")
    public ResponseEntity<String> updateUser(
            @PathVariable String userId,
            @RequestBody UserDto userDto
    ) {
        return ResponseEntity.ok(userService.updateUserProfile(userId, userDto));
    }

    // ✅ Delete user - only DRH
    @PreAuthorize("hasRole('DRH')")
    @DeleteMapping("/delete/{userId}")
    public ResponseEntity<String> deleteUser(@PathVariable String userId) {
        return ResponseEntity.ok(userService.deleteUser(userId));
    }

    // ✅ Get all users - DRH or GRH
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    @GetMapping
    public ResponseEntity<List<UserDto>> getAllUsers() {
        return ResponseEntity.ok(userService.getAllUsers());
    }

    // ✅ Get user by username - DRH or GRH
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    @GetMapping("/username/{username}")
    public ResponseEntity<UserDto> getUserByUsername(@PathVariable String username) {
        return userService.getUserByUsername(username)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAnyRole('DRH','GRH','EMPLOYEE','INTERN','SUPPORT','MANAGER')")
    @GetMapping("/{userId}")
    public ResponseEntity<UserDto> getUserById(@PathVariable String userId) {
        return userService.getUserById(userId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/me")
    public ResponseEntity<UserDto> getCurrentUser(@AuthenticationPrincipal Jwt jwt) {
        // Keycloak puts the username in the "preferred_username" claim
        String username = jwt.getClaimAsString("preferred_username");
        UserDto me = userService.getCurrentUser(username);
        return ResponseEntity.ok(me);
    }

    // ✅ Get users by department - DRH or GRH
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    @GetMapping("/department/{departmentId}")
    public ResponseEntity<List<UserDto>> getUsersByDepartment(@PathVariable String departmentId) {
        return ResponseEntity.ok(userService.getUsersByDepartment(departmentId));
    }

    @PreAuthorize("hasAnyRole('DRH')")
    @GetMapping("/active")
    public ResponseEntity<List<UserDto>> getActiveUsers() {
        return ResponseEntity.ok(userService.getActiveUsers());
    }
    // Endpoint pour archiver un utilisateur
    @PreAuthorize("hasRole('DRH')")
    @PutMapping("/{userId}/archive")
    public ResponseEntity<Void> archiveUser(@PathVariable String userId) {
        userService.archiveUser(userId);
        return ResponseEntity.ok().build();
    }

    // Endpoint to get archived users
    @PreAuthorize("hasRole('DRH')")
    @GetMapping("/archived")
    public ResponseEntity<List<UserDto>> getArchivedUsers() {
        List<UserDto> archivedUsers = userService.getArchivedUsers();
        return ResponseEntity.ok(archivedUsers);
    }

    // Endpoint to restore an archived user
    @PreAuthorize("hasRole('DRH')")
    @PutMapping("/{userId}/restore")
    public ResponseEntity<Void> restoreUser(@PathVariable String userId) {
        userService.restoreUser(userId);
        return ResponseEntity.ok().build();
    }

    //  retrieve active sessions for all users
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    @GetMapping("/sessions")
    public ResponseEntity<List<SessionDto>> getAllSessions() {
        return ResponseEntity.ok(userService.getAllUserSessions());
    }

     // Kick (logout) a single online session.

    @DeleteMapping("/sessions/{sessionId}")
    @PreAuthorize("hasRole('DRH')")          // Only DRH can kick sessions
    public ResponseEntity<Void> kickSession(@PathVariable String sessionId) {
        userService.kickFromSession(sessionId);
        return ResponseEntity.noContent().build(); // 204 No Content
    }
    // Endpoint to get non-archived users
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    @GetMapping("/non-archived")
    public ResponseEntity<List<UserDto>> getNonArchivedUsers() {
        List<UserDto> nonArchivedUsers = userService.getNonArchivedUsers();
        return ResponseEntity.ok(nonArchivedUsers);
    }


//    // ✅ TEST endpoint: see your roles (DEBUG ONLY)
//    @GetMapping("/me/roles")
//    public ResponseEntity<?> myRoles(Authentication authentication) {
//        return ResponseEntity.ok(authentication.getAuthorities());
//    }
//    // ✅ TEST endpoint: see your roles (DEBUG ONLY)
//    @GetMapping("/list-all")
//    public ResponseEntity<List<String>> listAllRoles() {
//        List<String> allRoles = userService.listAllAvailableRoles();
//        return ResponseEntity.ok(allRoles);
//    }


}
