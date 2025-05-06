/* src/main/java/com/rh_app/hr_app/features/ticket/controller/TicketController.java */
package com.rh_app.hr_app.features.ticket.controller;

import com.rh_app.hr_app.features.ticket.dto.*;
import com.rh_app.hr_app.features.ticket.model.TicketAttachment;
import com.rh_app.hr_app.features.ticket.service.TicketService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;
import java.time.Instant;
import java.util.List;

@RestController
@RequestMapping("/api/tickets")
@RequiredArgsConstructor
public class TicketController {

    private final TicketService service;

    /* ╔════════════════════════════════════════════════════╗
       ║ 1.  CREATE  – any authenticated employee           ║
       ╚════════════════════════════════════════════════════╝ */
    @PostMapping(consumes = "multipart/form-data")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<TicketDto> create(
            @RequestPart("payload") @Valid TicketCreateDto payload,
            @RequestPart(value = "files", required = false) List<MultipartFile> files,
            Principal principal) {

        TicketDto dto = service.createTicket(
                principal.getName(),     // Keycloak user-id (sub)
                payload,
                files);
        return ResponseEntity.ok(dto);
    }
    @GetMapping("/{id}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<TicketDto> getById(@PathVariable Long id) {
        TicketDto dto = service.findById(id);
        return ResponseEntity.ok(dto);
    }

    /* ╔════════════════════════════════════════════════════╗
       ║ 2.  UPDATE  – GRH/Manager/Support                  ║
       ╚════════════════════════════════════════════════════╝ */
    @PatchMapping("/{id}")
    @PreAuthorize("hasAnyRole('GRH','DRH','MANAGER','SUPPORT')")
    public ResponseEntity<TicketDto> update(
            @PathVariable Long id,
            @RequestBody @Valid TicketUpdateDto upd,
            Authentication auth) {

        TicketDto dto = service.updateTicket(
                id,
                upd,
                auth.getName(),
                hasRole(auth,"GRH") || hasRole(auth,"DRH"),   // ← privilege flag
                hasRole(auth,"MANAGER"),
                hasRole(auth,"SUPPORT")
        );
        return ResponseEntity.ok(dto);
    }


    /* ╔════════════════════════════════════════════════════╗
       ║ 3.  REOPEN  – creator only                         ║
       ╚════════════════════════════════════════════════════╝ */
    @PostMapping("/{id}/reopen")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<TicketDto> reopen(@PathVariable Long id,
                                            Principal principal) {

        TicketDto dto = service.reopen(id, principal.getName());
        return ResponseEntity.ok(dto);
    }
    /* 1️⃣  Employee – “My tickets” */
    @GetMapping("/my")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Page<TicketDto>> myTickets(Principal principal,
                                                     Pageable pageable) {
        return ResponseEntity.ok(
                service.findMyTickets(principal.getName(), pageable));
    }

    /* 2️⃣ Assignee – “Tickets assigned to me” */
    @GetMapping("/assigned")
    @PreAuthorize("hasAnyRole('SUPPORT','MANAGER','GRH','DRH')")
    public ResponseEntity<Page<TicketDto>> assigned(Authentication auth,
                                                    Pageable pageable) {
        return ResponseEntity.ok(
                service.findAssignedToMe(auth.getName(), pageable));
    }

    /* 3️⃣ GRH / DRH – list all (optional ?status=CLOSED …) */
    @GetMapping
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public ResponseEntity<Page<TicketDto>> all(@RequestParam(required = false) String status,
                                               Pageable pageable) {
        return ResponseEntity.ok(
                service.findAllTickets(status, pageable));
    }
    /**
     * Download a ticket attachment
     */
    @GetMapping("/{ticketId}/attachments/{attachmentId}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<byte[]> downloadAttachment(
            @PathVariable Long ticketId,
            @PathVariable Long attachmentId) {

        TicketAttachment attachment = service.getAttachmentForDownload(ticketId, attachmentId);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" + attachment.getOriginalName() + "\"")
                .contentType(MediaType.parseMediaType(attachment.getMimeType()))
                .body(attachment.getData());
    }
    /**
     * Get the employee's ticket count for the current month
     * Used to show the remaining quota in the UI
     */
    @GetMapping("/my/monthly-count")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Long> getMyMonthlyTicketCount(Principal principal) {
        long count = service.getUserMonthlyTicketCount(principal.getName());
        return ResponseEntity.ok(count);
    }


    /* ╔════════════════════════════════════════════════════╗
       ║ 4.  OPTIONAL KPI ENDPOINTS (GRH / DRH)             ║
       ╚════════════════════════════════════════════════════╝ */
    @GetMapping("/kpi/avg-resolution/department/{deptId}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public double avgResDept(@PathVariable Long deptId) {
        return service.avgResolutionHours(deptId);
    }

    @GetMapping("/kpi/avg-resolution/user/{userId}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public double avgResUser(@PathVariable String userId) {
        return service.avgResolutionHoursForUser(userId);
    }

    @GetMapping("/kpi/closed-by-user/{userId}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public long closedByUser(@PathVariable String userId,
                             @RequestParam Instant from,
                             @RequestParam Instant to) {
        return service.ticketsClosedByUser(userId, from, to);
    }

    @GetMapping("/kpi/reopened/department/{deptId}")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public long reopenedDept(@PathVariable Long deptId) {
        return service.reopenedInDepartment(deptId);
    }

    /* ──────────────────────────────────────────────────────
       utility
       ────────────────────────────────────────────────────── */
    private static boolean hasRole(Authentication auth, String role) {
        return auth.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_" + role));
    }
}
