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
     * List active templates in folder with role-based filtering
     * @param folderId Folder ID to list templates from
     * @param isHrRole Whether the current user has DRH or GRH role
     * @return Filtered list of document templates
     */
    public List<DocTemplateDto> listActiveInFolderWithRoleFiltering(Long folderId, boolean isHrRole) {
        List<DocumentTemplate> templates = tplRepo.findByActiveTrueAndFolderIdOrderByNameAsc(folderId);

        // If HR role, return all templates
        if (isHrRole) {
            return templates.stream().map(DocTemplateMapper::toDto).toList();
        }

        // Otherwise filter only allowed types
        return templates.stream()
                .filter(t -> t.getType() == DocTemplateType.ASSESSMENT ||
                        t.getType() == DocTemplateType.CERTIFICATE ||
                        t.getType() == DocTemplateType.OTHER)
                .map(DocTemplateMapper::toDto)
                .toList();
    }

    /**
     * List all active templates with role-based filtering
     * @param isHrRole Whether the current user has DRH or GRH role
     * @return Filtered list of all active document templates
     */
    public List<DocTemplateDto> listAllActiveWithRoleFiltering(boolean isHrRole) {
        List<DocumentTemplate> templates = tplRepo.findByActiveTrueOrderByNameAsc();

        // If HR role, return all templates
        if (isHrRole) {
            return templates.stream().map(DocTemplateMapper::toDto).toList();
        }

        // Otherwise filter only allowed types
        return templates.stream()
                .filter(t -> t.getType() == DocTemplateType.ASSESSMENT ||
                        t.getType() == DocTemplateType.CERTIFICATE ||
                        t.getType() == DocTemplateType.OTHER)
                .map(DocTemplateMapper::toDto)
                .toList();
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
    public void deleteTemplate(Long id) {
        DocumentTemplate template = tplRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Template not found with ID: " + id));

        // You can choose to either:
        // 1. Hard delete (actually remove from database)
        tplRepo.delete(template);

        // Or alternatively:
        // 2. Soft delete (just mark as inactive)
        // template.setActive(false);
        // No need to call save() here since the entity is managed and will be dirty-tracked
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

    /* ---------- KPI helpers ---------- */
    public long countActive()                       { return tplRepo.countByActiveTrue(); }
    public long countRetired()                      { return tplRepo.countByActiveFalse(); }
    public long countActiveByType(DocTemplateType t){ return tplRepo.countByActiveTrueAndType(t); }
}
