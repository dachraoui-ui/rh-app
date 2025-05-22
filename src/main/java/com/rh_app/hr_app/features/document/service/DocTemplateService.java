package com.rh_app.hr_app.features.document.service;

import com.rh_app.hr_app.core.enums.document_enums.DocTemplateType;
import com.rh_app.hr_app.features.document.dto.DocTemplateDto;
import com.rh_app.hr_app.features.document.dto.DocTemplateUploadDto;
import com.rh_app.hr_app.features.document.mapper.DocTemplateMapper;
import com.rh_app.hr_app.features.document.model.DocumentFolder;
import com.rh_app.hr_app.features.document.model.DocumentTemplate;
import com.rh_app.hr_app.features.document.repository.DocFolderRepository;
import com.rh_app.hr_app.features.document.repository.DocTemplateRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
@RequiredArgsConstructor
public class DocTemplateService {

    private final DocTemplateRepository tplRepo;
    private final DocFolderRepository   folderRepo;


    /**
     * List templates in folder with role-based filtering
     * @param folderId Folder ID to list templates from
     * @param isHrRole Whether the current user has DRH or GRH role
     * @return Filtered list of document templates
     */
    public List<DocTemplateDto> listInFolderWithRoleFiltering(Long folderId, boolean isHrRole) {
        List<DocumentTemplate> templates;

        if (isHrRole) {
            // For HR roles, show all templates (active and inactive)
            templates = tplRepo.findByFolderIdOrderByNameAsc(folderId);
        } else {
            // For non-HR roles, only show active templates
            templates = tplRepo.findByActiveTrueAndFolderIdOrderByNameAsc(folderId);
        }

        // Apply type-based filtering for non-HR roles
        if (!isHrRole) {
            return templates.stream()
                    .filter(t -> t.getType() == DocTemplateType.ASSESSMENT ||
                            t.getType() == DocTemplateType.CERTIFICATE ||
                            t.getType() == DocTemplateType.OTHER)
                    .map(DocTemplateMapper::toDto)
                    .toList();
        }

        return templates.stream().map(DocTemplateMapper::toDto).toList();
    }

    /**
     * List all templates with role-based filtering
     * @param isHrRole Whether the current user has DRH or GRH role
     * @return Filtered list of document templates
     */
    public List<DocTemplateDto> listAllWithRoleFiltering(boolean isHrRole) {
        List<DocumentTemplate> templates;

        if (isHrRole) {
            // For HR roles, show all templates (active and inactive)
            templates = tplRepo.findAllByOrderByNameAsc();
        } else {
            // For non-HR roles, only show active templates
            templates = tplRepo.findByActiveTrueOrderByNameAsc();
        }

        // Apply type-based filtering for non-HR roles
        if (!isHrRole) {
            return templates.stream()
                    .filter(t -> t.getType() == DocTemplateType.ASSESSMENT ||
                            t.getType() == DocTemplateType.CERTIFICATE ||
                            t.getType() == DocTemplateType.OTHER)
                    .map(DocTemplateMapper::toDto)
                    .toList();
        }

        return templates.stream().map(DocTemplateMapper::toDto).toList();
    }


    /* ---------- Upload by DRH ---------- */
    @Transactional
    public DocTemplateDto upload(MultipartFile file,
                                 DocTemplateUploadDto meta,
                                 String uploader) throws IOException {

        DocumentFolder folder = folderRepo.findById(meta.folderId())
                .orElseThrow(() -> new IllegalArgumentException("Folder not found"));

        // Get the bytes from the file
        byte[] fileBytes = file.getBytes();

        // Add debug info
        System.out.println("File content type: " + file.getContentType());
        System.out.println("File size: " + fileBytes.length);
        System.out.println("File bytes array type: " + fileBytes.getClass().getName());

        // Create the template entity
        var entity = DocTemplateMapper.toEntityForUpload(
                meta,
                folder,
                fileBytes,
                fileBytes.length,
                file.getContentType(),
                file.getOriginalFilename(),
                uploader);

        // Additional check before save
        if (entity.getData() == null) {
            throw new IllegalStateException("Document template data is null before saving");
        }

        System.out.println("Entity data length before save: " +
                (entity.getData() != null ? entity.getData().length : 0));

        // Save the entity
        return DocTemplateMapper.toDto(tplRepo.save(entity));
    }

    @Transactional
    public DocumentTemplate loadEntity(Long id) {
        return tplRepo.findById(id).orElseThrow();
    }

    /**
     * Delete a document template by ID
     * @param id The ID of the template to delete
     * @throws IllegalArgumentException if the template doesn't exist
     */
    @Transactional
    public boolean deleteTemplate(Long id) {
        DocumentTemplate template = tplRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Template not found with ID: " + id));

        // Check if the template is referenced by any requests
        // This would typically be done via a repository method that checks related entities
        boolean isTemplateInUse = isTemplateReferencedByRequests(id);

        if (isTemplateInUse) {
            // Template is in use, can't delete
            return false;
        }
        // Template is not in use, safe to delete
        tplRepo.delete(template);
        return true;
    }
    // Helper method to check if a template is referenced by any requests
    private boolean isTemplateReferencedByRequests(Long templateId) {
        // You would need to implement this method based on your data model
        // For example, querying a document request repository with:
        // return docRequestRepository.existsByTemplateId(templateId);

        // This is a placeholder - replace with actual implementation
        return tplRepo.isTemplateInUse(templateId);
    }

    /**
     * Deactivate a document template (soft delete)
     * @param id The ID of the template to deactivate
     * @return The updated template DTO with active=false
     * @throws IllegalArgumentException if the template doesn't exist
     */
    @Transactional
    public DocTemplateDto deactivateTemplate(Long id) {
        DocumentTemplate template = tplRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Template not found with ID: " + id));
        // Check if already inactive
        if (!template.isActive()) {
            return DocTemplateMapper.toDto(template);
        }
        // Set as inactive
        template.setActive(false);
        // Return the updated template
        return DocTemplateMapper.toDto(template);
    }
    /**
     * Activate a document template
     * @param id The ID of the template to activate
     * @return The updated template DTO with active=true
     * @throws IllegalArgumentException if the template doesn't exist
     */
    @Transactional
    public DocTemplateDto activateTemplate(Long id) {
        DocumentTemplate template = tplRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Template not found with ID: " + id));

        // Check if already active
        if (template.isActive()) {
            return DocTemplateMapper.toDto(template);
        }

        // Set as active
        template.setActive(true);

        // Return the updated template
        return DocTemplateMapper.toDto(template);
    }


    /**
     * Move a document template to a different folder
     * @param templateId The ID of the template to move
     * @param targetFolderId The ID of the destination folder
     * @return Updated document template
     * @throws IllegalArgumentException if either template or folder doesn't exist
     */
    @Transactional
    public DocTemplateDto moveToFolder(Long templateId, Long targetFolderId) {
        // Find the template and the target folder
        DocumentTemplate template = tplRepo.findById(templateId)
                .orElseThrow(() -> new IllegalArgumentException("Template not found with ID: " + templateId));

        DocumentFolder targetFolder = folderRepo.findById(targetFolderId)
                .orElseThrow(() -> new IllegalArgumentException("Target folder not found with ID: " + targetFolderId));

        // Check if this is a no-op (moving to same folder)
        if (template.getFolder().getId().equals(targetFolderId)) {
            return DocTemplateMapper.toDto(template);
        }

        // Update the template's folder
        template.setFolder(targetFolder);

        // The entity is managed, no need to call save() explicitly since we're in a @Transactional method

        return DocTemplateMapper.toDto(template);
    }
    @Transactional
    public DocTemplateDto updateTemplateNameAndType(Long id, String name, DocTemplateType type) {
        DocumentTemplate template = tplRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Template not found with ID: " + id));

        if (name != null && !name.isBlank()) {
            template.setName(name);
        }

        if (type != null) {
            template.setType(type);
        }

        // No explicit save needed in @Transactional context
        return DocTemplateMapper.toDto(template);
    }

    /* ---------- KPI helpers ---------- */
    public long countActive()                       { return tplRepo.countByActiveTrue(); }
    public long countRetired()                      { return tplRepo.countByActiveFalse(); }
    public long countActiveByType(DocTemplateType t){ return tplRepo.countByActiveTrueAndType(t); }
}
