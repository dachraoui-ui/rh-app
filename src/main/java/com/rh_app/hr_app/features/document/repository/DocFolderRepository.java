package com.rh_app.hr_app.features.document.repository;

import com.rh_app.hr_app.features.document.model.DocumentFolder;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DocFolderRepository extends JpaRepository<DocumentFolder, Long> {

    /* List all folders alphabetically */
    List<DocumentFolder> findAllByOrderByNameAsc();

    /* Uniqueness check used when creating/renaming */
    boolean existsByNameIgnoreCase(String name);
}