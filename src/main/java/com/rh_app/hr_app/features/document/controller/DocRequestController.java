package com.rh_app.hr_app.features.document.controller;

import com.rh_app.hr_app.core.enums.document_enums.DocRequestStatus;
import com.rh_app.hr_app.core.enums.document_enums.DocTemplateType;
import com.rh_app.hr_app.features.document.dto.*;
import com.rh_app.hr_app.features.document.service.DocRequestService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/doc-requests")
@RequiredArgsConstructor
public class DocRequestController {

    private final DocRequestService service;

    /* ══ EMPLOYEE / INTERN ═══════════════════════════════════════ */

    @PostMapping
    @PreAuthorize("hasAnyRole('EMPLOYEE','INTERN','MANAGER','SUPPORT')")
    @ResponseStatus(HttpStatus.CREATED)
    public DocRequestDto create(@Valid @RequestBody DocRequestCreateDto dto,
                                @AuthenticationPrincipal Jwt jwt) {
        String user = jwt.getClaim("preferred_username");
        return service.create(dto, user);
    }

    @GetMapping("/my")
    @PreAuthorize("hasAnyRole('EMPLOYEE','INTERN','MANAGER','SUPPORT')")
    public List<DocRequestDto> my(@AuthenticationPrincipal Jwt jwt) {
        String user = jwt.getClaim("preferred_username");
        return service.listAllMine(user);
    }

    /* ══ HR INBOX ═════════════════════════════════════ */

    @GetMapping("/backlog")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public List<DocRequestDto> backlog() {
        return service.listAllBacklog();
    }


    /* ══ WORKFLOW PATCH (JSON) ══════════════════════════════════ */

    @PatchMapping("/{id}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public DocRequestDto workflow(@PathVariable Long id,
                                  @RequestBody DocRequestWorkflowDto patch,
                                  @AuthenticationPrincipal Jwt jwt) {
        return service.patchWorkflow(id, patch,
                jwt.getClaim("preferred_username"));
    }

    /* ══ MARK READY  (PDF upload) ═══════════════════════════════ */

    @PatchMapping(path = "/{id}/ready", consumes = "multipart/form-data")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public DocRequestDto ready(@PathVariable Long id,
                               @RequestPart("file") MultipartFile pdf,
                               @AuthenticationPrincipal Jwt jwt)
            throws IOException {

        return service.markReady(id, pdf,
                jwt.getClaim("preferred_username"));
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

    /* ══ KPI quick counts (GRH / DRH) ═══════════════════════════ */

    @GetMapping("/count/open")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public long open() { return service.countOpen(); }

    @GetMapping("/count/ready")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public long ready() { return service.countReady(); }

    @GetMapping("/count/delivered")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public long delivered() { return service.countDelivered(); }

    /* List of overdue requests (for dashboard) */
    @GetMapping("/overdue")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public List<DocRequestDto> overdue(@RequestParam(defaultValue = "48") long hours) {
        return service.findOverdue(hours);
    }
}
