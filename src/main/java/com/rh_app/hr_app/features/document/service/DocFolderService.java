package com.rh_app.hr_app.features.document.service;

import com.rh_app.hr_app.features.document.dto.*;
import com.rh_app.hr_app.features.document.mapper.DocFolderMapper;
import com.rh_app.hr_app.features.document.model.DocumentFolder;
import com.rh_app.hr_app.features.document.repository.DocFolderRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DocFolderService {

    private final DocFolderRepository repo;

    /* ---------- list all folders ---------- */
    public List<DocFolderDto> getAllFolders() {
        return repo.findAllByOrderByNameAsc().stream()
                .map(DocFolderMapper::toDto)
                .toList();
    }

    /* ---------- get folder by id ---------- */
    public DocFolderDto getById(Long id) {
        return DocFolderMapper.toDto(
                repo.findById(id).orElseThrow(() ->
                        new IllegalArgumentException("Folder not found with id: " + id)));
    }

    /* ---------- create ---------- */
    @Transactional
    public DocFolderDto create(DocFolderCreateDto dto) {
        // Validate folder name is not empty
        if (dto.name() == null || dto.name().trim().isEmpty()) {
            throw new IllegalArgumentException("Folder name cannot be empty");
        }

        // Check for duplicate folder names (case insensitive)
        if (repo.existsByNameIgnoreCase(dto.name())) {
            throw new IllegalArgumentException("Folder name already exists");
        }

        // Create new folder entity
        DocumentFolder entity = DocFolderMapper.toEntityForCreate(dto);
        return DocFolderMapper.toDto(repo.save(entity));
    }

    /* ---------- rename ---------- */
    @Transactional
    public DocFolderDto rename(Long id, DocFolderUpdateDto patch) {
        // Validate new name is provided
        if (patch.name() == null || patch.name().trim().isEmpty()) {
            throw new IllegalArgumentException("New folder name cannot be empty");
        }

        // Find the folder entity
        DocumentFolder entity = repo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Folder not found"));

        // Only check uniqueness if name is actually changing
        if (!entity.getName().equalsIgnoreCase(patch.name()) &&
                repo.existsByNameIgnoreCase(patch.name())) {
            throw new IllegalArgumentException("Folder name already exists");
        }

        // Apply the update (rename)
        DocFolderMapper.applyUpdate(entity, patch);

        // Entity is dirty-tracked, so we don't need explicit save
        return DocFolderMapper.toDto(entity);
    }

    /* ---------- delete ---------- */
    @Transactional
    public void delete(Long id) {
        if (!repo.existsById(id)) {
            throw new IllegalArgumentException("Folder not found with id: " + id);
        }

        // Note: You might want to check for contained documents first
        // and handle them appropriately (move, delete, prevent deletion, etc.)

        repo.deleteById(id);
    }

    /* ---------- check if folder exists ---------- */
    public boolean exists(Long id) {
        return repo.existsById(id);
    }

    /* ---------- check if folder name is available ---------- */
    public boolean isNameAvailable(String name) {
        return !repo.existsByNameIgnoreCase(name);
    }

    /* ---------- count folders ---------- */
    public long countFolders() {
        return repo.count();
    }
}