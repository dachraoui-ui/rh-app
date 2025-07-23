package com.rh_app.hr_app.features.project.service;

import com.rh_app.hr_app.features.project.dto.TaskDTO;
import com.rh_app.hr_app.features.project.mapper.TaskMapper;
import com.rh_app.hr_app.features.project.model.Project;
import com.rh_app.hr_app.features.project.model.Task;
import com.rh_app.hr_app.features.project.repository.ProjectRepository;
import com.rh_app.hr_app.features.project.repository.TaskRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TaskService {

    private final TaskRepository taskRepository;
    private final ProjectRepository projectRepository;
    private final TaskMapper taskMapper;

    /**
     * Get all tasks for a project
     */
    public List<TaskDTO> getAllTasksByProjectId(Long projectId) {
        Project project = projectRepository.findById(projectId)
                .orElseThrow(() -> new EntityNotFoundException("Project not found with id: " + projectId));

        return taskMapper.toDTOList(taskRepository.findByProjectId(projectId));
    }

    /**
     * Get a specific task by ID
     */
    public TaskDTO getTaskById(Long projectId, Long taskId) {
        // Verify that the project exists
        if (!projectRepository.existsById(projectId)) {
            throw new EntityNotFoundException("Project not found with id: " + projectId);
        }

        Task task = taskRepository.findById(taskId)
                .orElseThrow(() -> new EntityNotFoundException("Task not found with id: " + taskId));

        // Verify that the task belongs to the specified project
        if (!task.getProject().getId().equals(projectId)) {
            throw new EntityNotFoundException("Task with id " + taskId + " does not belong to project with id " + projectId);
        }

        return taskMapper.toDTO(task);
    }

    /**
     * Create a new task for a project
     */
    @Transactional
    public TaskDTO createTask(Long projectId, TaskDTO taskDTO) {
        Project project = projectRepository.findById(projectId)
                .orElseThrow(() -> new EntityNotFoundException("Project not found with id: " + projectId));

        Task task = taskMapper.toEntity(taskDTO, project);
        Task savedTask = taskRepository.save(task);

        // Update project progress after adding a task
        updateProjectProgress(projectId);

        return taskMapper.toDTO(savedTask);
    }

    /**
     * Update an existing task
     */
    @Transactional
    public TaskDTO updateTask(Long projectId, Long taskId, TaskDTO taskDTO) {
        // Verify that the project exists
        Project project = projectRepository.findById(projectId)
                .orElseThrow(() -> new EntityNotFoundException("Project not found with id: " + projectId));

        // Verify that the task exists
        if (!taskRepository.existsById(taskId)) {
            throw new EntityNotFoundException("Task not found with id: " + taskId);
        }

        Task taskToUpdate = taskMapper.toEntity(taskDTO, project);
        taskToUpdate.setId(taskId);

        Task updatedTask = taskRepository.save(taskToUpdate);

        // Update project progress after updating a task
        updateProjectProgress(projectId);

        return taskMapper.toDTO(updatedTask);
    }

    /**
     * Delete a task
     */
    @Transactional
    public void deleteTask(Long projectId, Long taskId) {
        // Verify that the project exists
        if (!projectRepository.existsById(projectId)) {
            throw new EntityNotFoundException("Project not found with id: " + projectId);
        }

        // Verify that the task exists
        Task task = taskRepository.findById(taskId)
                .orElseThrow(() -> new EntityNotFoundException("Task not found with id: " + taskId));

        // Verify that the task belongs to the specified project
        if (!task.getProject().getId().equals(projectId)) {
            throw new EntityNotFoundException("Task with id " + taskId + " does not belong to project with id " + projectId);
        }

        taskRepository.deleteById(taskId);

        // Update project progress after deleting a task
        updateProjectProgress(projectId);
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

    /**
     * Calculate and update project progress based on task completion
     */
    private void updateProjectProgress(Long projectId) {
        Project project = projectRepository.findById(projectId)
                .orElseThrow(() -> new EntityNotFoundException("Project not found with id: " + projectId));

        List<Task> tasks = taskRepository.findByProjectId(projectId);
        if (tasks.isEmpty()) {
            project.setProgress(0);
        } else {
            long completedTasks = tasks.stream().filter(t -> "done".equals(t.getStatus())).count();
            int progress = (int) ((completedTasks * 100) / tasks.size());
            project.setProgress(progress);
        }

        projectRepository.save(project);
    }
}
