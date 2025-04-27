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

    /* ---------- Employee list (active only) ---------- */
    public List<DocTemplateDto> listActiveInFolder(Long folderId) {
        return tplRepo.findByActiveTrueAndFolderIdOrderByNameAsc(folderId)
                .stream().map(DocTemplateMapper::toDto).toList();
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

    /* ---------- KPI helpers ---------- */
    public long countActive()                       { return tplRepo.countByActiveTrue(); }
    public long countRetired()                      { return tplRepo.countByActiveFalse(); }
    public long countActiveByType(DocTemplateType t){ return tplRepo.countByActiveTrueAndType(t); }
}
