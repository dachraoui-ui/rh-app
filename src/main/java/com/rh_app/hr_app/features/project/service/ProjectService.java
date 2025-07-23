package com.rh_app.hr_app.features.project.service;

import com.rh_app.hr_app.features.project.dto.ProjectDTO;
import com.rh_app.hr_app.features.project.mapper.ProjectMapper;
import com.rh_app.hr_app.features.project.model.Project;
import com.rh_app.hr_app.features.project.model.Task;
import com.rh_app.hr_app.features.project.repository.ProjectRepository;
import com.rh_app.hr_app.features.project.repository.TaskRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProjectService {

    private final ProjectRepository projectRepository;
    private final TaskRepository taskRepository;
    private final ProjectMapper projectMapper;

    /**
     * Find projects with filtering
     */
    public List<ProjectDTO> findProjectsByFilters(
            String search,
            String status,
            String manager,
            LocalDate startDate,
            LocalDate endDate) {

        List<Project> projects = projectRepository.findProjectsByFilters(
                search, status, manager, startDate, endDate);

        return projectMapper.toDTOList(projects);
    }

    /**
     * Get project by ID
     */
    public ProjectDTO getProjectById(Long id) {
        Project project = projectRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Project not found with id: " + id));
        return projectMapper.toDTO(project);
    }

    /**
     * Create a new project
     */
    @Transactional
    public ProjectDTO createProject(ProjectDTO projectDTO) {
        // Set initial values
        projectDTO.setProgress(0);
        if (projectDTO.getStatus() == null) {
            projectDTO.setStatus("In Progress");
        }

        Project project = projectMapper.toEntity(projectDTO);
        Project savedProject = projectRepository.save(project);
        return projectMapper.toDTO(savedProject);
    }

    /**
     * Update an existing project
     */
    @Transactional
    public ProjectDTO updateProject(Long id, ProjectDTO projectDTO) {
        if (!projectRepository.existsById(id)) {
            throw new EntityNotFoundException("Project not found with id: " + id);
        }

        Project projectToUpdate = projectMapper.toEntity(projectDTO);
        projectToUpdate.setId(id);

        // If project is being marked as completed, update all tasks
        if ("Completed".equals(projectDTO.getStatus())) {
            markAllTasksAsDone(id);
        }

        Project updatedProject = projectRepository.save(projectToUpdate);
        return projectMapper.toDTO(updatedProject);
    }

    /**
     * Delete a project and its tasks
     */
    @Transactional
    public void deleteProject(Long id) {
        if (!projectRepository.existsById(id)) {
            throw new EntityNotFoundException("Project not found with id: " + id);
        }

        // Delete tasks first to avoid foreign key constraints
        taskRepository.deleteByProjectId(id);
        projectRepository.deleteById(id);
    }

    /**
     * Calculate and update project progress based on task completion
     */
    @Transactional
    public void updateProjectProgress(Long projectId) {
        Project project = projectRepository.findById(projectId)
                .orElseThrow(() -> new EntityNotFoundException("Project not found with id: " + projectId));

        long totalTasks = project.getTasks().size();
        if (totalTasks == 0) {
            project.setProgress(0);
        } else {
            long completedTasks = taskRepository.countByProjectIdAndStatus(projectId, "done");
            int progress = (int) ((completedTasks * 100) / totalTasks);
            project.setProgress(progress);
        }

        projectRepository.save(project);
    }

    /**
     * Mark all tasks as done for a project (used when project is completed)
     */
    @Transactional
    public void markAllTasksAsDone(Long projectId) {
        List<Task> tasks = taskRepository.findByProjectId(projectId);
        for (Task task : tasks) {
            task.setStatus("done");
            taskRepository.save(task);
        }

        // Set project progress to 100% when all tasks are marked as done
        Project project = projectRepository.findById(projectId)
                .orElseThrow(() -> new EntityNotFoundException("Project not found with id: " + projectId));
        project.setProgress(100);
        projectRepository.save(project);
    }
}
