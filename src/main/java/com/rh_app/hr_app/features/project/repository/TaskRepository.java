package com.rh_app.hr_app.features.project.repository;

import com.rh_app.hr_app.features.project.model.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {
    List<Task> findByProjectId(Long projectId);

    void deleteByProjectId(Long projectId);

    long countByProjectIdAndStatus(Long projectId, String status);
}
