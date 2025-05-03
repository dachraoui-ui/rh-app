package com.rh_app.hr_app.features.ticket.controller;

import com.rh_app.hr_app.core.enums.ticket_enums.TicketStatus;
import com.rh_app.hr_app.features.ticket.dto.TicketDto;
import com.rh_app.hr_app.features.ticket.service.TicketService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;




@RestController
@RequestMapping("/api/tickets")
@RequiredArgsConstructor
public class TicketController {

    private final TicketService service;

    /* ─────────────────────────────
       1️⃣  EMPLOYEE or INTERN ▸ create
       ───────────────────────────── */
    @PostMapping
    @PreAuthorize("hasAnyRole('EMPLOYEE','INTERN','SUPPORT','MANAGER')")
    @ResponseStatus(HttpStatus.CREATED)
    public TicketDto create(@Valid @RequestBody TicketDto dto,
                            @AuthenticationPrincipal Jwt jwt) {

        String username = jwt.getClaim("preferred_username");
        return service.create(dto, username);
    }

    /* ─────────────────────────────
       2️⃣  EMPLOYEE or INTERN ▸ my tickets
       ───────────────────────────── */
    @GetMapping("/my")
    @PreAuthorize("hasAnyRole('EMPLOYEE','INTERN','SUPPORT','MANAGER')")
    public Page<TicketDto> myTickets(Pageable pageable,
                                     @AuthenticationPrincipal Jwt jwt) {

        String username = jwt.getClaim("preferred_username");
        return service.listMine(username, pageable);
    }

    /* ─────────────────────────────
       3️⃣  GRH / DRH ▸ assigned
       ───────────────────────────── */
    @GetMapping("/assigned")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public Page<TicketDto> assignedToMe(Pageable pageable,
                                        @AuthenticationPrincipal Jwt jwt) {

        String username = jwt.getClaim("preferred_username");
        return service.listAssigned(username, pageable);
    }

    /* ─────────────────────────────
   4️⃣  ALL ROLES ▸ get by id
   ───────────────────────────── */
    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('EMPLOYEE','INTERN','GRH','DRH')")
    public TicketDto get(@PathVariable Long id,
                         @AuthenticationPrincipal Jwt jwt) {

        TicketDto ticket   = service.findById(id);
        String    username = jwt.getClaim("preferred_username");

        // ───── pull authorities from the SecurityContext ─────
        var auths = org.springframework.security.core.context.SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getAuthorities();

        boolean isDrh         = auths.stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_DRH"));
        boolean isGrh         = auths.stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_GRH"));
        boolean isEmpOrIntern = auths.stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_EMPLOYEE")
                        || a.getAuthority().equals("ROLE_INTERN"));

        if (isDrh) return ticket;                                    // DRH sees everything
        if (isEmpOrIntern && ticket.getCreatedBy().equals(username)) // owner
            return ticket;
        if (isGrh && username.equals(ticket.getAssignedTo()))        // handler
            return ticket;

        throw new org.springframework.web.server.ResponseStatusException(
                HttpStatus.FORBIDDEN, "You are not allowed to view this ticket.");
    }


    @GetMapping
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public Page<TicketDto> allTickets(Pageable pageable) {
        return service.listAll(pageable);
    }
    /* ===========================================
   5 bis)  GRH / DRH ▸  quick-resolve ticket
   =========================================== */
    @PostMapping("/{id}/resolve")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    @ResponseStatus(HttpStatus.OK)
    public TicketDto resolve(@PathVariable Long id,
                             @AuthenticationPrincipal Jwt jwt) {

        String editor = jwt.getClaim("preferred_username");
        return service.resolve(id, editor);
    }


    /* ─────────────────────────────
       5️⃣  GRH / DRH ▸ workflow patch
       ───────────────────────────── */
    @PatchMapping("/{id}/workflow")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public TicketDto workflow(@PathVariable Long id,
                              @RequestBody TicketDto patch,
                              @AuthenticationPrincipal Jwt jwt) {

        String editor = jwt.getClaim("preferred_username");
        return service.applyWorkflowPatch(id, patch, editor);
    }

    /* ─────────────────────────────
       6️⃣  DRH only ▸ delete
       ───────────────────────────── */
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('DRH')")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }

    /* ─────────────────────────────
       7️⃣  KPI endpoints (GRH / DRH)
       ───────────────────────────── */
    @GetMapping("/count/open")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public long openCount() {
        return service.countByStatus(TicketStatus.OPEN);
    }

    @GetMapping("/count/open/high")
    @PreAuthorize("hasAnyRole('GRH','DRH')")
    public long highUrgencyOpen() {
        return service.countHighUrgencyOpen();
    }
}
