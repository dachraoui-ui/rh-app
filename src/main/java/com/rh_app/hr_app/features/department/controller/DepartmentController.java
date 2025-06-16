package com.rh_app.hr_app.features.department.controller;

import com.rh_app.hr_app.features.department.dto.DepartmentDto;
import com.rh_app.hr_app.features.department.service.DepartmentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/departments")
@RequiredArgsConstructor
public class DepartmentController {

    private final DepartmentService service;

    /* ───────────────  DRH writes  ─────────────── */

    @PostMapping
    @PreAuthorize("hasRole('DRH')")
    public ResponseEntity<DepartmentDto> create(@Valid @RequestBody DepartmentDto dto) {
        return ResponseEntity.ok(service.createDepartment(dto));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('DRH')")
    public ResponseEntity<DepartmentDto> update(@PathVariable Long id,
                                                @Valid @RequestBody DepartmentDto patch) {
        return ResponseEntity.ok(service.updateDepartment(id, patch));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('DRH')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        service.deleteDepartment(id);
        return ResponseEntity.noContent().build();
    }

    /* ───────────────  GRH / DRH read  ─────────────── */

    @GetMapping
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<DepartmentDto>> listAll() {
        return ResponseEntity.ok(service.getAllDepartments());
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<DepartmentDto> getById(@PathVariable Long id) {
        return ResponseEntity.ok(service.getDepartmentById(id));
    }

    /**
     * Get all manager user IDs across all departments
     */
    @GetMapping("/managers")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<String>> getAllDepartmentManagers() {
        return ResponseEntity.ok(service.getAllDepartmentManagers());
    }

    /**
     * Get all support users for a specific department
     */
    @GetMapping("/{id}/support-users")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<Map<String, Map<String, String>>> getSupportUsersByDepartment(@PathVariable Long id) {
        return ResponseEntity.ok(service.getSupportUsersByDepartment(id));
    }
}
