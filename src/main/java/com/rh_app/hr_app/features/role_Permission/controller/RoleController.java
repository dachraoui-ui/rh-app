package com.rh_app.hr_app.features.role_Permission.controller;

import com.rh_app.hr_app.features.role_Permission.service.KeycloakRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/roles")
public class RoleController {

    @Autowired
    private KeycloakRoleService keycloakRoleService;

    @PostMapping("/create")
    public String createRole(@RequestParam String roleName) {
        return keycloakRoleService.createRole(roleName);
    }

    @GetMapping
    public List<String> getRoles() {
        return keycloakRoleService.getAllRoles();
    }

    @DeleteMapping("/delete")
    public String deleteRole(@RequestParam String roleName) {
        return keycloakRoleService.deleteRole(roleName);
    }
}
