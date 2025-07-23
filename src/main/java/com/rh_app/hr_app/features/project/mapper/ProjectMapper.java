package com.rh_app.hr_app.features.project.mapper;

import com.rh_app.hr_app.features.project.dto.ProjectDTO;
import com.rh_app.hr_app.features.project.dto.TaskDTO;
import com.rh_app.hr_app.features.project.model.Project;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class ProjectMapper {

    private final TaskMapper taskMapper;

    @Autowired
    public ProjectMapper(TaskMapper taskMapper) {
        this.taskMapper = taskMapper;
    }

    public ProjectDTO toDTO(Project project) {
        if (project == null) {
            return null;
        }

        ProjectDTO dto = ProjectDTO.builder()
                .id(project.getId())
                .title(project.getTitle())
                .description(project.getDescription())
                .manager(project.getManager())
                .managerId(project.getManagerId())
                .startDate(project.getStartDate())
                .endDate(project.getEndDate())
                .status(project.getStatus())
                .progress(project.getProgress())
                .createdAt(project.getCreatedAt())
                .updatedAt(project.getUpdatedAt())
                .build();

        if (project.getTasks() != null && !project.getTasks().isEmpty()) {
            dto.setTasks(taskMapper.toDTOList(project.getTasks()));
        }

        return dto;
    }

    public Project toEntity(ProjectDTO dto) {
        if (dto == null) {
            return null;
        }

        Project project = Project.builder()
                .id(dto.getId())
                .title(dto.getTitle())
                .description(dto.getDescription())
                .manager(dto.getManager())
                .managerId(dto.getManagerId())
                .startDate(dto.getStartDate())
                .endDate(dto.getEndDate())
                .status(dto.getStatus())
                .progress(dto.getProgress())
                .build();

        // Tasks are typically managed separately
        return project;
    }

    public List<ProjectDTO> toDTOList(List<Project> projects) {
        return projects.stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public List<Project> toEntityList(List<ProjectDTO> dtos) {
        return dtos.stream()
                .map(this::toEntity)
                .collect(Collectors.toList());
    }
}
