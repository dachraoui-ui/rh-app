package com.rh_app.hr_app.features.ticket.mapper;

import com.rh_app.hr_app.features.ticket.dto.TicketDto;
import com.rh_app.hr_app.features.ticket.model.Ticket;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.Objects;


@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class TicketMapper {

    /* ─────────────────────────────
       Entity  ➜  DTO  (read model)
       ───────────────────────────── */
    public static TicketDto toDto(Ticket entity) {
        if (entity == null) {
            return null;
        }
        return TicketDto.builder()
                .id(entity.getId())
                .category(entity.getCategory())
                .title(entity.getTitle())
                .description(entity.getDescription())
                .status(entity.getStatus())
                .priority(entity.getPriority())
                .createdBy(entity.getCreatedBy())
                .assignedTo(entity.getAssignedTo())
                .prioritySetBy(entity.getPrioritySetBy())
                .createdAt(entity.getCreatedAt())
                .resolvedAt(entity.getResolvedAt())
                .updatedAt(entity.getUpdatedAt())
                .build();
    }

    /* ─────────────────────────────
       DTO  ➜  Entity  (create flow)
       Only fields the client is allowed to fill
       ───────────────────────────── */
    public static Ticket toEntityForCreate(TicketDto dto,
                                           String creatorUsername,
                                           Instant now) {
        Objects.requireNonNull(dto, "TicketDto must not be null");
        Ticket entity = new Ticket();

        // Business fields coming from client
        entity.setCategory(dto.getCategory());
        entity.setTitle(dto.getTitle());
        entity.setDescription(dto.getDescription());

        // Optional priority (defaults to MEDIUM in entity)
        if (dto.getPriority() != null) {
            entity.setPriority(dto.getPriority());
        }

        // Server-controlled fields
        entity.setStatus(dto.getStatus() != null ? dto.getStatus() : null); // usually OPEN in service
        entity.setCreatedBy(creatorUsername);
        entity.setPrioritySetBy(creatorUsername);
        entity.setCreatedAt(now);

        return entity;
    }

    /* ─────────────────────────────
       Partial PATCH-style update.
       Any non-null field in dto overwrites
       the corresponding field in entity.
       ───────────────────────────── */
    public static void applyPatch(TicketDto dtoPatch,
                                  Ticket entity,
                                  String editorUsername) {

        if (dtoPatch.getCategory() != null) {
            entity.setCategory(dtoPatch.getCategory());
        }
        if (dtoPatch.getTitle() != null) {
            entity.setTitle(dtoPatch.getTitle());
        }
        if (dtoPatch.getDescription() != null) {
            entity.setDescription(dtoPatch.getDescription());
        }
        if (dtoPatch.getStatus() != null) {
            entity.setStatus(dtoPatch.getStatus());
            if (dtoPatch.getStatus().name().equals("RESOLVED")) {
                entity.setResolvedAt(Instant.now());
            }
        }
        if (dtoPatch.getPriority() != null) {
            entity.setPriority(dtoPatch.getPriority());
            entity.setPrioritySetBy(editorUsername);
        }
        if (dtoPatch.getAssignedTo() != null) {
            entity.setAssignedTo(dtoPatch.getAssignedTo());
        }
        // updatedAt is handled automatically by @UpdateTimestamp
    }
}
