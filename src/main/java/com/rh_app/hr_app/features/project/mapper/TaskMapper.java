package com.rh_app.hr_app.features.project.mapper;

import com.rh_app.hr_app.features.project.dto.TaskDTO;
import com.rh_app.hr_app.features.project.model.Project;
import com.rh_app.hr_app.features.project.model.Task;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class TaskMapper {

    public TaskDTO toDTO(Task task) {
        if (task == null) {
            return null;
        }

        return TaskDTO.builder()
                .id(task.getId())
                .title(task.getTitle())
                .status(task.getStatus())
                .priority(task.getPriority())
                .createdAt(task.getCreatedAt())
                .updatedAt(task.getUpdatedAt())
                .projectId(task.getProject() != null ? task.getProject().getId() : null)
                .build();
    }

    public Task toEntity(TaskDTO dto, Project project) {
        if (dto == null) {
            return null;
        }

        Task task = Task.builder()
                .id(dto.getId())
                .title(dto.getTitle())
                .status(dto.getStatus())
                .priority(dto.getPriority())
                .build();

        if (project != null) {
            task.setProject(project);
        }

        return task;
    }

    public List<TaskDTO> toDTOList(List<Task> tasks) {
        return tasks.stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public List<Task> toEntityList(List<TaskDTO> dtos, Project project) {
        return dtos.stream()
                .map(dto -> toEntity(dto, project))
                .collect(Collectors.toList());
    }
}
