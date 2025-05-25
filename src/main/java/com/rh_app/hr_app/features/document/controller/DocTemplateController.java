package com.rh_app.hr_app.features.document.controller;

import com.rh_app.hr_app.core.enums.document_enums.DocTemplateType;
import com.rh_app.hr_app.features.document.dto.DocTemplateDto;
import com.rh_app.hr_app.features.document.dto.DocTemplateUploadDto;
import com.rh_app.hr_app.features.document.service.DocTemplateService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/doc-templates")
@RequiredArgsConstructor
public class DocTemplateController {

    private final DocTemplateService service;

    /* ───────────────────────────────
       Employee & HR – list active templates with role-based filtering
       ─────────────────────────────── */
    @GetMapping
    @PreAuthorize("isAuthenticated()")
    public List<DocTemplateDto> list(@RequestParam Long folderId,
                                     @AuthenticationPrincipal Jwt jwt) {
        boolean isHrRole = jwt.getClaimAsMap("realm_access").toString().contains("DRH") ||
                jwt.getClaimAsMap("realm_access").toString().contains("GRH");
        return service.listActiveInFolderWithRoleFiltering(folderId, isHrRole);
    }

    /**
     * List all active templates across all folders with role-based filtering
     */
    @GetMapping("/all")
    @PreAuthorize("isAuthenticated()")
    public List<DocTemplateDto> listAllActive(@AuthenticationPrincipal Jwt jwt) {
        boolean isHrRole = jwt.getClaimAsMap("realm_access").toString().contains("DRH") ||
                jwt.getClaimAsMap("realm_access").toString().contains("GRH");
        return service.listAllActiveWithRoleFiltering(isHrRole);
    }
    /**
     * List all templates (both active and inactive) - HR only
     */
    @GetMapping("/all-templates")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<DocTemplateDto>> getAllTemplates() {
        List<DocTemplateDto> templates = service.listAllTemplates();
        return ResponseEntity.ok(templates);
    }

    /**
     * List only inactive templates - HR only
     */
    @GetMapping("/inactive")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<List<DocTemplateDto>> getInactiveTemplates() {
        List<DocTemplateDto> templates = service.listInactiveTemplates();
        return ResponseEntity.ok(templates);
    }

    /* ───────────────────────────────
       DRH uploads a new template
       multipart/form-data  (file + meta JSON)
       ─────────────────────────────── */
    @PostMapping
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public DocTemplateDto upload(@RequestPart("file") MultipartFile file,
                                 @RequestPart("meta") DocTemplateUploadDto meta,
                                 @org.springframework.security.core.annotation.AuthenticationPrincipal
                                 org.springframework.security.oauth2.jwt.Jwt jwt)
            throws IOException {

        String uploader = jwt.getClaim("preferred_username");
        return service.upload(file, meta, uploader);
    }

    /* ───────────────────────────────
       HR download original template (for editing)
       ─────────────────────────────── */
    @GetMapping("/{id}/download")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<byte[]> download(@PathVariable Long id) {

        var tpl = service.loadEntity(id);   // ← entity, has getData()

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" + tpl.getOriginalName() + "\"")
                .contentType(MediaType.parseMediaType(tpl.getMimeType()))
                .body(tpl.getData());               // works: entity has the bytes
    }
    /**
     * Delete a document template
     */
    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<?> deleteTemplate(@PathVariable Long id) {
        try {
            boolean deleted = service.deleteTemplate(id);

            if (deleted) {
                // Successfully deleted
                return ResponseEntity.noContent().build();
            } else {
                // Template is in use, can't delete
                return ResponseEntity
                        .status(HttpStatus.CONFLICT)
                        .body("This document template cannot be deleted because it is currently in use");
            }
        } catch (IllegalArgumentException e) {
            // Template not found
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            // Other unexpected errors
            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred while deleting the template: " + e.getMessage());
        }
    }

    /**
     * Deactivate a document template (soft delete)
     */
    @PatchMapping("/{id}/deactivate")
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    public ResponseEntity<DocTemplateDto> deactivateTemplate(@PathVariable Long id) {
        try {
            DocTemplateDto deactivated = service.deactivateTemplate(id);
            return ResponseEntity.ok(deactivated);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    /**
     * Activate a previously deactivated document template
     */
    @PatchMapping("/{id}/activate")
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    public ResponseEntity<DocTemplateDto> activateTemplate(@PathVariable Long id) {
        try {
            DocTemplateDto activated = service.activateTemplate(id);
            return ResponseEntity.ok(activated);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    /**
     * Move a document template to a different folder
     */
    @PatchMapping("/{id}/move/{folderId}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<DocTemplateDto> moveToFolder(
            @PathVariable Long id,
            @PathVariable Long folderId) {
        try {
            DocTemplateDto updated = service.moveToFolder(id, folderId);
            return ResponseEntity.ok(updated);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(null);
        }
    }
    @PatchMapping("/{id}/update")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<DocTemplateDto> updateTemplateNameAndType(
            @PathVariable Long id,
            @RequestParam(required = false) String name,
            @RequestParam(required = false) DocTemplateType type) {
        try {
            DocTemplateDto updated = service.updateTemplateNameAndType(id, name, type);
            return ResponseEntity.ok(updated);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }



}
