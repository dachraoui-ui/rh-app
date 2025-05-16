package com.rh_app.hr_app.features.document.controller;

import com.rh_app.hr_app.features.document.dto.DocTemplateDto;
import com.rh_app.hr_app.features.document.dto.DocTemplateUploadDto;
import com.rh_app.hr_app.features.document.service.DocTemplateService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
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

    /* ───────────────────────────────
       DRH uploads a new template
       multipart/form-data  (file + meta JSON)
       ─────────────────────────────── */
    @PostMapping
    @PreAuthorize("hasRole('DRH')")
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
    @PreAuthorize("hasRole('DRH')")
    public ResponseEntity<Void> deleteTemplate(@PathVariable Long id) {
        service.deleteTemplate(id);
        return ResponseEntity.noContent().build();
    }
    /**
     * Move a document template to a different folder
     */
    @PatchMapping("/{id}/move/{folderId}")
    @PreAuthorize("hasRole('DRH')")
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



}
