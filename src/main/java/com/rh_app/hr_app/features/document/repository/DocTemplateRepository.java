package com.rh_app.hr_app.features.document.repository;

import com.rh_app.hr_app.core.enums.document_enums.DocTemplateType;
import com.rh_app.hr_app.features.document.model.DocumentTemplate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface DocTemplateRepository extends JpaRepository<DocumentTemplate, Long> {

    /* List visible templates for employees (active only). */
    List<DocumentTemplate> findByActiveTrueAndFolderIdOrderByNameAsc(Long folderId);
    /**
     * Find all active templates sorted by name
     */
    List<DocumentTemplate> findByActiveTrueOrderByNameAsc();
    List<DocumentTemplate> findByFolderIdOrderByNameAsc(Long folderId);
    List<DocumentTemplate> findAllByOrderByNameAsc();

    @Query("SELECT CASE WHEN COUNT(r) > 0 THEN true ELSE false END FROM DocumentRequest r WHERE r.template.id = :templateId")
    boolean isTemplateInUse(@Param("templateId") Long templateId);

    /* KPI helpers ---------------------------------------------------- */

    long countByActiveTrue();                                 // total active
    long countByActiveFalse();                                // retired

    long countByActiveTrueAndType(DocTemplateType type);      // active per type
}
