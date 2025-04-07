package com.rh_app.hr_app.features.department.service;

import com.rh_app.hr_app.features.department.dto.DepartmentDto;
import com.rh_app.hr_app.features.department.mapper.DepartmentMapper;
import com.rh_app.hr_app.features.department.model.Department;
import com.rh_app.hr_app.features.department.repository.DepartmentRepository;
import lombok.RequiredArgsConstructor;
import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DepartmentService {


    private final DepartmentRepository departmentRepository;
    private final Keycloak keycloak;

    @Value("${keycloak.admin.realm}")
    private String realm;

    public DepartmentDto createDepartment(DepartmentDto dto) {
        Department department = DepartmentMapper.toEntity(dto);
        return DepartmentMapper.toDto(departmentRepository.save(department));
    }

    public List<DepartmentDto> getAllDepartments() {
        return departmentRepository.findAll()
                .stream()
                .map(DepartmentMapper::toDto)
                .collect(Collectors.toList());
    }

    public DepartmentDto getDepartmentById(Long id) {
        return departmentRepository.findById(id)
                .map(DepartmentMapper::toDto)
                .orElseThrow(() -> new RuntimeException("Department not found with id: " + id));
    }

    public void deleteDepartment(Long id) {
        departmentRepository.deleteById(id);
    }

    public DepartmentDto updateDepartment(Long id, DepartmentDto dto) {
        Department department = departmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Department not found with id: " + id));

        department.setNom(dto.getNom());
        department.setDescription(dto.getDescription());

        return DepartmentMapper.toDto(departmentRepository.save(department));
    }

    public List<Map<String, String>> getUsersByDepartment(Long departmentId) {
        return keycloak.realm(realm).users().list()
                .stream()
                .filter(user -> {
                    Map<String, List<String>> attributes = user.getAttributes();
                    return attributes != null &&
                            attributes.containsKey("departmentId") &&
                            attributes.get("departmentId").get(0).equals(String.valueOf(departmentId));
                })
                .map(user -> {
                    Map<String, String> userInfo = new HashMap<>();
                    userInfo.put("username", user.getUsername());
                    userInfo.put("firstName", user.getFirstName());
                    userInfo.put("lastName", user.getLastName());
                    return userInfo;
                })
                .collect(Collectors.toList());
    }


}
