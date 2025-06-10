package com.rh_app.hr_app.features.contract.controller;

import com.rh_app.hr_app.core.enums.ContractType;
import com.rh_app.hr_app.features.contract.dto.ContractDTO;
import com.rh_app.hr_app.features.contract.service.ContractService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/contracts")
@RequiredArgsConstructor
public class ContractController {

    private final ContractService contractService;

    // ============== Basic CRUD Operations ==============

    @PostMapping
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<ContractDTO> createContract(@RequestBody ContractDTO contractDTO) {
        return new ResponseEntity<>(contractService.createContract(contractDTO), HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<ContractDTO> getContractById(@PathVariable Long id) {
        return ResponseEntity.ok(contractService.getContractById(id));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<ContractDTO> updateContract(@PathVariable Long id, @RequestBody ContractDTO contractDTO) {
        return ResponseEntity.ok(contractService.updateContract(id, contractDTO));
    }

    @DeleteMapping("/{id}/archive")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<Void> archiveContract(@PathVariable Long id) {
        contractService.archiveContract(id);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<Void> deleteContract(@PathVariable Long id) {
        contractService.deleteContract(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/restore")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<ContractDTO> restoreContract(@PathVariable Long id) {
        return ResponseEntity.ok(contractService.restoreContract(id));
    }

    // ============== Operational Query Endpoints ==============

    @GetMapping
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<ContractDTO>> getAllContracts() {
        return ResponseEntity.ok(contractService.getAllContracts());
    }

    @GetMapping("/employee/{employeeId}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<ContractDTO>> getContractsByEmployeeId(
            @PathVariable String employeeId,
            @RequestParam(required = false, defaultValue = "true") boolean activeOnly) {

        if (activeOnly) {
            return ResponseEntity.ok(contractService.getActiveContractsByEmployeeId(employeeId));
        } else {
            return ResponseEntity.ok(contractService.getAllContractsByEmployeeId(employeeId));
        }
    }

    @GetMapping("/employee/{employeeId}/type/{type}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<ContractDTO>> getContractsByEmployeeIdAndType(
            @PathVariable String employeeId,
            @PathVariable ContractType type) {

        return ResponseEntity.ok(contractService.getActiveContractsByEmployeeIdAndType(employeeId, type));
    }

    // ============== KPI Endpoints ==============

    @GetMapping("/active")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<ContractDTO>> getActiveContracts() {
        return ResponseEntity.ok(contractService.getAllActiveContracts());
    }

    @GetMapping("/inactive")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<ContractDTO>> getInactiveContracts() {
        return ResponseEntity.ok(contractService.getInactiveContracts());
    }

    @GetMapping("/current")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<ContractDTO>> getCurrentlyActiveContracts() {
        return ResponseEntity.ok(contractService.getActiveContracts());
    }

    @GetMapping("/expiring")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<ContractDTO>> getExpiringContracts(
            @RequestParam(defaultValue = "30") int days) {

        return ResponseEntity.ok(contractService.getActiveContractsExpiringInDays(days));
    }

    @GetMapping("/salary-range")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<ContractDTO>> getContractsBySalaryRange(
            @RequestParam Double min,
            @RequestParam Double max) {

        return ResponseEntity.ok(contractService.getActiveContractsBySalaryRange(min, max));
    }

    @GetMapping("/type/{type}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<ContractDTO>> getContractsByType(@PathVariable ContractType type) {
        return ResponseEntity.ok(contractService.getActiveContractsByType(type));
    }
}