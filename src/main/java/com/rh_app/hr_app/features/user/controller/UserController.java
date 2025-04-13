package com.rh_app.hr_app.features.user.controller;

import com.rh_app.hr_app.features.user.dto.UserDto;
import com.rh_app.hr_app.features.user.service.KeycloakUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.core.Authentication;
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

    @PreAuthorize("hasAnyRole('DRH','GRH')")
    @GetMapping("/{userId}")
    public ResponseEntity<UserDto> getUserById(@PathVariable String userId) {
        return userService.getUserById(userId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // ✅ Get users by department - DRH or GRH
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    @GetMapping("/department/{departmentId}")
    public ResponseEntity<List<UserDto>> getUsersByDepartment(@PathVariable String departmentId) {
        return ResponseEntity.ok(userService.getUsersByDepartment(departmentId));
    }

    // ✅ TEST endpoint: see your roles (DEBUG ONLY)
    @GetMapping("/me/roles")
    public ResponseEntity<?> myRoles(Authentication authentication) {
        return ResponseEntity.ok(authentication.getAuthorities());
    }
}
