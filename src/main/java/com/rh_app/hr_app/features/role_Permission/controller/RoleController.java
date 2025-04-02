package com.rh_app.hr_app.features.role_Permission.controller;

import com.rh_app.hr_app.features.role_Permission.service.KeycloakRoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/roles")
@RequiredArgsConstructor
public class RoleController {

    private final KeycloakRoleService roleService;

    @PostMapping("/create")
    public String createRole(@RequestParam String roleName) {
        return roleService.createRole(roleName);
    }

    @GetMapping
    public List<String> getAllRoles() {
        return roleService.getAllRoles();
    }

    @DeleteMapping("/delete")
    public String deleteRole(@RequestParam String roleName) {
        return roleService.deleteRole(roleName);
    }
}
