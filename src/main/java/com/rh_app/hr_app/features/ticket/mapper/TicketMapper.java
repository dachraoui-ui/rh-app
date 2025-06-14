/* src/main/java/com/rh_app/hr_app/features/ticket/mapper/TicketMapper.java */
package com.rh_app.hr_app.features.ticket.mapper;

import com.rh_app.hr_app.core.enums.ticket_enums.*;
import com.rh_app.hr_app.features.department.model.Department;
import com.rh_app.hr_app.features.ticket.dto.*;
import com.rh_app.hr_app.features.ticket.model.*;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.util.stream.Collectors;

/**
 * Centralised mapper for Ticket ↔ DTOs.
 *
 *   • toDto(…) – READ
 *   • toEntityForCreate(…) – CREATE (employee)
 *   • applyUpdate(…) – UPDATE (workflow changes)
 */
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class TicketMapper {

    /* ─────────────────────────────────────────────
       1) Entity ➜ DTO   (READ)
       ───────────────────────────────────────────── */
    public static TicketDto toDto(Ticket t) {
        if (t == null) return null;

        return TicketDto.builder()
                .id(t.getId())
                // who / where
                .departmentId(t.getDepartment() != null
                        ? t.getDepartment().getId() : null)
                .createdBy(t.getCreatedBy())
                .assignedTo(t.getAssignedTo())
                .category(t.getCategory())

                // workflow
                .priority(mapPriorityToEnum(t.getPriority()))
                .status(mapStatusToEnum(t.getStatus()))
                .escalationLevel(t.getEscalationLevel())
                .reopenedCount((int) t.getReopenCount())

                // timestamps
                .createdAt(t.getCreatedAt())
                .updatedAt(t.getUpdatedAt())
                .resolvedAt(t.getResolvedAt())

                // free‑text
                .description(t.getDescription())

                // attachments
                .attachments(
                        t.getAttachments().stream()
                                .map(TicketAttachmentMapper::toDto)
                                .collect(Collectors.toList())
                )
                .build();
    }

    /* ─────────────────────────────────────────────
       2) DTO ➜ Entity   (CREATE)
       ───────────────────────────────────────────── */
    public static Ticket toEntityForCreate(TicketCreateDto dto,
                                           Department     department,
                                           String         employeeId) {

        Ticket t = new Ticket();

        /* ── classification / content ───────────────────────────── */
        t.setCategory(dto.category());
        t.setDescription(dto.description());
        t.setDepartment(department);             // already looked-up by caller

        /* ── workflow defaults ──────────────────────────────────── */
        t.setCreatedBy(employeeId);              // employee who opened it
        t.setAssignedTo(null);                   // un-assigned
        t.setStatus("OPEN");                     // initial state
        t.setEscalationLevel(0);                 // 0 = no escalation yet

        // default to MEDIUM if caller omitted priority
        TicketPriority pr = dto.priority() != null
                ? dto.priority()
                : TicketPriority.MEDIUM;
        t.setPriority(mapPriorityToShort(pr));

        t.setReopenCount((short) 0);             // first time the ticket exists

        return t;
    }



    /* ─────────────────────────────────────────────
       3) UPDATE helper – mutates *managed* entity
          Only called by the service layer that
          checked business rules.
       ───────────────────────────────────────────── */
    public static void applyUpdate(TicketUpdateDto upd, Ticket entity) {

        /* ── priority ─────────────────────────── */
        if (upd.getPriority() != null) {
            entity.setPriority(mapPriorityToShort(upd.getPriority()));
        }

        /* ── status ───────────────────────────── */
        if (upd.getStatus() != null) {
            entity.setStatus(mapStatusToString(upd.getStatus()));

            // example side-effect: when GRH archives the ticket
            // if (upd.getStatus() == TicketStatus.ARCHIVED) { … }
        }

        /* ── assignment ───────────────────────── */
        if (upd.getAssignedTo() != null) {
            entity.setAssignedTo(upd.getAssignedTo());
        }

        /* ── assignment ───────────────────────── */
        if (upd.getAssignedTo() != null) {
            String newAssignee = upd.getAssignedTo();
            entity.setAssignedTo(newAssignee);

            // Check if assigning to a manager or DRH
            Department dept = entity.getDepartment();
            if (dept != null && dept.getManagerUserId() != null &&
                    newAssignee.equals(dept.getManagerUserId())) {
                // If assigned to department manager, set level to 1
                entity.setEscalationLevel(1);
            } else if ("DRH".equals(newAssignee)) {
                // If assigned to DRH, set level to 2
                entity.setEscalationLevel(2);
            }
        }

    }

    /* ─────────────────────────────────────────────
       4) tiny helpers  (short ↔ enum, String ↔ enum)
       ───────────────────────────────────────────── */

    private static TicketPriority mapPriorityToEnum(short code) {
        return switch (code) {
            case 1 -> TicketPriority.CRITICAL;
            case 2 -> TicketPriority.HIGH;
            case 3 -> TicketPriority.MEDIUM;
            case 4 -> TicketPriority.LOW;
            default -> TicketPriority.MEDIUM;
        };
    }

    private static short mapPriorityToShort(TicketPriority p) {
        return switch (p) {
            case CRITICAL -> 1;
            case HIGH     -> 2;
            case MEDIUM   -> 3;
            case LOW      -> 4;
        };
    }

    private static TicketStatus mapStatusToEnum(String s) {
        return (s == null) ? TicketStatus.OPEN : TicketStatus.valueOf(s);
    }

    /** only needed when you must persist by enum */
    public static String mapStatusToString(TicketStatus st) {
        return st.name();
    }
}
