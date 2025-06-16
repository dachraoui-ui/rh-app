package com.rh_app.hr_app.features.document.controller;

import com.rh_app.hr_app.features.document.dto.DocFolderKpiDto;
import com.rh_app.hr_app.features.document.service.DocumentKpiService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/doc-kpi")
@RequiredArgsConstructor
public class DocumentKpiController {

    private final DocumentKpiService kpiService;

    /* ───────────────────────────────
       Get folder KPIs (only for management roles)
       ─────────────────────────────── */
    @GetMapping("/folders")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<DocFolderKpiDto> getFolderKpis() {
        return ResponseEntity.ok(kpiService.getFolderKpis());
    }


}