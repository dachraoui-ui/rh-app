package com.rh_app.hr_app.features.user.controller;

import com.rh_app.hr_app.features.user.dto.UserDto;
import com.rh_app.hr_app.features.user.service.KeycloakUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final KeycloakUserService userService;

    //  Create user
    @PostMapping("/create")
    public ResponseEntity<String> createUser(@RequestBody UserDto userDto) {
        return ResponseEntity.ok(userService.createUser(userDto));
    }

    //  Update user
    @PutMapping("/update/{userId}")
    public ResponseEntity<String> updateUser(
            @PathVariable String userId,
            @RequestBody UserDto userDto
    ) {
        return ResponseEntity.ok(userService.updateUserProfile(userId, userDto));
    }

    //  Delete user
    @DeleteMapping("/delete/{userId}")
    public ResponseEntity<String> deleteUser(@PathVariable String userId) {
        return ResponseEntity.ok(userService.deleteUser(userId));
    }

    //  Get all users
    @GetMapping
    public ResponseEntity<List<UserDto>> getAllUsers() {
        return ResponseEntity.ok(userService.getAllUsers());
    }

    // Get user by username
    @GetMapping("/username/{username}")
    public ResponseEntity<UserDto> getUserByUsername(@PathVariable String username) {
        return userService.getUserByUsername(username)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Get users by departmentId
    @GetMapping("/department/{departmentId}")
    public ResponseEntity<List<UserDto>> getUsersByDepartment(@PathVariable String departmentId) {
        return ResponseEntity.ok(userService.getUsersByDepartment(departmentId));
    }
}
