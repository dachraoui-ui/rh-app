package com.rh_app.hr_app.features.document.controller;

import com.rh_app.hr_app.features.document.dto.DocTemplateDto;
import com.rh_app.hr_app.features.document.dto.DocTemplateUploadDto;
import com.rh_app.hr_app.features.document.service.DocTemplateService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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
       Employee & HR – list active templates
       ─────────────────────────────── */
    @GetMapping
    @PreAuthorize("hasAnyRole('EMPLOYEE','INTERN','GRH','DRH')")
    public List<DocTemplateDto> list(@RequestParam Long folderId) {
        return service.listActiveInFolder(folderId);
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

}
