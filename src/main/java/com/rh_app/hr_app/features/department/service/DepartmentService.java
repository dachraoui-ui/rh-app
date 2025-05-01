package com.rh_app.hr_app.features.department.service;

import com.rh_app.hr_app.features.department.dto.DepartmentDto;
import com.rh_app.hr_app.features.department.mapper.DepartmentMapper;
import com.rh_app.hr_app.features.department.model.Department;
import com.rh_app.hr_app.features.department.repository.DepartmentRepository;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.NotFoundException;
import lombok.RequiredArgsConstructor;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DepartmentService {

    private final DepartmentRepository departmentRepo;
    private final Keycloak              keycloak;          // ↔ Keycloak Admin REST

    @Value("${keycloak.admin.realm}")   // e.g. hr-app-realm
    private String realm;

    /* ────────────────────────────────────────────────────────────────
       CRUD -- with the business rules we agreed on
       ──────────────────────────────────────────────────────────────── */

    /** Create a department with ONE manager and 1-3 support users. */
    @Transactional
    public DepartmentDto createDepartment(DepartmentDto dto) {

        /* 1️⃣  Validation -- name must be unique (case-insensitive) */
        if (departmentRepo.existsByNameIgnoreCase(dto.getName())) {
            throw new IllegalArgumentException("Department name already used: " + dto.getName());
        }

        /* 2️⃣  Exactly one manager, and that manager must not already
                manage another department                                       */
        if (dto.getManagerUserId() == null || dto.getManagerUserId().isBlank()) {
            throw new IllegalArgumentException("Manager user-id is mandatory");
        }
        if (departmentRepo.existsByManagerUserId(dto.getManagerUserId())) {
            throw new IllegalArgumentException("This user already manages another department");
        }

        /* 3️⃣  1-3 distinct support IDs                                          */
        Set<String> supportIds = Optional.ofNullable(dto.getSupportUserIds())
                .map(HashSet::new)          // defensive copy
                .orElseThrow(() ->
                        new IllegalArgumentException("At least one support user is required"));
        if (supportIds.isEmpty() || supportIds.size() > 3) {
            throw new IllegalArgumentException("Support user count must be between 1 and 3");
        }
        if (supportIds.contains(dto.getManagerUserId())) {
            throw new IllegalArgumentException("Manager cannot also be listed as support");
        }

        /* 4️⃣  Persist */
        Department entity = DepartmentMapper.toEntity(dto);
        supportIds.forEach(entity::addSupportUser);   // uses entity helper method
        Department saved  = departmentRepo.save(entity);

        return DepartmentMapper.toDto(saved);
    }

    /** Simple read-all (returns lightweight DTOs). */
    public List<DepartmentDto> getAllDepartments() {
        return departmentRepo.findAll()
                .stream()
                .map(DepartmentMapper::toDto)
                .toList();
    }

    public DepartmentDto getDepartmentById(Long id) {
        return departmentRepo.findById(id)
                .map(DepartmentMapper::toDto)
                .orElseThrow(() -> new NoSuchElementException("Department " + id + " not found"));
    }

    /** Update name / description / manager / supports.
     *  All the same business rules apply. */
    @Transactional
    public DepartmentDto updateDepartment(Long id, DepartmentDto patch) {

        Department d = departmentRepo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Department " + id + " not found"));

        /* — name (unique) — */
        if (patch.getName() != null && !patch.getName().equalsIgnoreCase(d.getName())) {
            if (departmentRepo.existsByNameIgnoreCase(patch.getName())) {
                throw new IllegalArgumentException("Another department already uses that name");
            }
            d.setName(patch.getName());
        }

        /* — description — */
        if (patch.getDescription() != null) {
            d.setDescription(patch.getDescription());
        }

        /* — manager — */
        String newMgr = patch.getManagerUserId();
        if (newMgr != null && !newMgr.equals(d.getManagerUserId())) {
            if (departmentRepo.existsByManagerUserId(newMgr)) {
                throw new IllegalArgumentException("This user already manages another department");
            }
            // also be sure manager isn’t in the support set
            if (d.getSupportUserIds().contains(newMgr)) {
                d.removeSupportUser(newMgr);
            }
            d.setManagerUserId(newMgr);
        }

        /* — support list (replace totally for simplicity) — */
        if (patch.getSupportUserIds() != null) {
            if (patch.getSupportUserIds().isEmpty() || patch.getSupportUserIds().size() > 3) {
                throw new IllegalArgumentException("Support user count must be between 1 and 3");
            }
            if (patch.getSupportUserIds().contains(d.getManagerUserId())) {
                throw new IllegalArgumentException("Manager cannot also be support");
            }
            d.getSupportUserIds().clear();
            patch.getSupportUserIds().forEach(d::addSupportUser);
        }

        return DepartmentMapper.toDto(d);   // entity is managed → auto-flushed
    }

    /** Delete department (only if business rules allow). */
    public void deleteDepartment(Long id) {
        departmentRepo.deleteById(id);
    }

    /* ────────────────────────────────────────────────────────────────
       Convenience helpers
       ──────────────────────────────────────────────────────────────── */

    /** For a Support agent dashboard – which departments do *I* belong to? */
    public List<DepartmentDto> departmentsForSupport(String supportUserId) {
        return departmentRepo.findBySupportUserId(supportUserId)
                .stream()
                .map(DepartmentMapper::toDto)
                .toList();
    }

    /** Fetch (pretty) user details for Manager + Supports via Keycloak Admin API. */
    public Map<String, Map<String, String>> getPeopleDirectory(Long deptId) {

        Department d = departmentRepo.findById(deptId)
                .orElseThrow(() -> new NoSuchElementException("Department " + deptId + " not found"));

        /* Build a set of unique Keycloak-user-ids we must fetch */
        Set<String> ids = new HashSet<>();
        ids.add(d.getManagerUserId());
        ids.addAll(d.getSupportUserIds());

        /* Call Keycloak once per user and build a small map: id → {username, first, last} */
        return ids.stream()
                .map(this::loadUserFromKeycloak)
                .filter(Objects::nonNull)
                .collect(Collectors.toMap(
                        UserRepresentation::getId,
                        u -> {
                            Map<String,String> m = new LinkedHashMap<>();
                            m.put("username",  u.getUsername());
                            m.put("firstName", u.getFirstName());
                            m.put("lastName",  u.getLastName());
                            return m;
                        }));
    }

    /* ─── private helper ─────────────────────────────────────────── */

    private UserRepresentation loadUserFromKeycloak(String userId) {
        try {
            return keycloak.realm(realm).users().get(userId).toRepresentation();
        } catch (NotFoundException nf) {
            return null;  // user was deleted from KC – up to caller to handle
        }
    }
}
