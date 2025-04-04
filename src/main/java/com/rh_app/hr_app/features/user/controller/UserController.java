package com.rh_app.hr_app.features.user.controller;

import com.rh_app.hr_app.features.user.dto.UserDto;
import com.rh_app.hr_app.features.user.service.KeycloakUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final KeycloakUserService keycloakUserService;

    @PostMapping("/create")
    public ResponseEntity<String> createUser(@RequestBody UserDto userDto) {
        String result = keycloakUserService.createUser(userDto);
        return ResponseEntity.ok(result);
    }
}
