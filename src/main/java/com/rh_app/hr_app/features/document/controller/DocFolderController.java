package com.rh_app.hr_app.features.document.controller;

import com.rh_app.hr_app.features.document.dto.*;
import com.rh_app.hr_app.features.document.service.DocFolderService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/doc-folders")
@RequiredArgsConstructor
public class DocFolderController {

    private final DocFolderService service;

    /* ───────────────────────────────
       Get all folders (alphabetically)
       ─────────────────────────────── */
    @GetMapping
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public List<DocFolderDto> getAllFolders() {
        return service.getAllFolders();
    }

    /* ───────────────────────────────
       Get folder by ID
       ─────────────────────────────── */
    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public DocFolderDto getFolder(@PathVariable Long id) {
        return service.getById(id);
    }

    /* ───────────────────────────────
       Create new folder (DRH only)
       ─────────────────────────────── */
    @PostMapping
    @PreAuthorize("hasRole('DRH')")
    public ResponseEntity<DocFolderDto> create(@Valid @RequestBody DocFolderCreateDto dto) {
        try {
            DocFolderDto created = service.create(dto);
            return ResponseEntity.status(HttpStatus.CREATED).body(created);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().build();
        }
    }

    /* ───────────────────────────────
       Rename folder (DRH only)
       ─────────────────────────────── */
    @PatchMapping("/{id}")
    @PreAuthorize("hasRole('DRH')")
    public ResponseEntity<DocFolderDto> rename(@PathVariable Long id,
                                               @RequestBody DocFolderUpdateDto patch) {
        try {
            DocFolderDto updated = service.rename(id, patch);
            return ResponseEntity.ok(updated);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }

    /* ───────────────────────────────
       Delete folder (DRH only)
       ─────────────────────────────── */
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('DRH')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        try {
            service.delete(id);
            return ResponseEntity.noContent().build();
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }

    /* ───────────────────────────────
       Check if folder name is available
       ─────────────────────────────── */
    @GetMapping("/check-name")
    @PreAuthorize("hasRole('DRH')")
    public ResponseEntity<Boolean> isNameAvailable(@RequestParam String name) {
        return ResponseEntity.ok(service.isNameAvailable(name));
    }

    /* ───────────────────────────────
       Get total number of folders
       ─────────────────────────────── */
    @GetMapping("/count")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<Long> countFolders() {
        return ResponseEntity.ok(service.countFolders());
    }
}