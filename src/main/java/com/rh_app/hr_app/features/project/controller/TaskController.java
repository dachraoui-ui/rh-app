package com.rh_app.hr_app.features.project.controller;

import com.rh_app.hr_app.features.project.dto.TaskDTO;
import com.rh_app.hr_app.features.project.service.TaskService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/projects/{projectId}/tasks")
@RequiredArgsConstructor
public class TaskController {

    private final TaskService taskService;

    @GetMapping
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    public ResponseEntity<List<TaskDTO>> getAllTasksByProjectId(@PathVariable Long projectId) {
        return ResponseEntity.ok(taskService.getAllTasksByProjectId(projectId));
    }

    @GetMapping("/{taskId}")
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    public ResponseEntity<TaskDTO> getTaskById(
            @PathVariable Long projectId,
            @PathVariable Long taskId) {

        return ResponseEntity.ok(taskService.getTaskById(projectId, taskId));
    }

    @PostMapping
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    public ResponseEntity<TaskDTO> createTask(
            @PathVariable Long projectId,
            @Valid @RequestBody TaskDTO taskDTO) {

        return new ResponseEntity<>(taskService.createTask(projectId, taskDTO), HttpStatus.CREATED);
    }

    @PutMapping("/{taskId}")
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    public ResponseEntity<TaskDTO> updateTask(
            @PathVariable Long projectId,
            @PathVariable Long taskId,
            @Valid @RequestBody TaskDTO taskDTO) {

        return ResponseEntity.ok(taskService.updateTask(projectId, taskId, taskDTO));
    }

    @DeleteMapping("/{taskId}")
    @PreAuthorize("hasAnyRole('DRH','GRH')")
    public ResponseEntity<Void> deleteTask(
            @PathVariable Long projectId,
            @PathVariable Long taskId) {

        taskService.deleteTask(projectId, taskId);
        return ResponseEntity.noContent().build();
    }
}
