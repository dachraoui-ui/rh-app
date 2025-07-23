package com.rh_app.hr_app.features.project.repository;

import com.rh_app.hr_app.features.project.model.Project;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ProjectRepository extends JpaRepository<Project, Long> {

    @Query(value = "SELECT p.* FROM app.project p WHERE " +
           "(:search IS NULL OR LOWER(p.title::text) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
           "LOWER(p.description::text) LIKE LOWER(CONCAT('%', :search, '%'))) AND " +
           "(:status IS NULL OR p.status = :status) AND " +
           "(:manager IS NULL OR LOWER(p.manager::text) LIKE LOWER(CONCAT('%', :manager, '%'))) AND " +
           "(:startDate IS NULL OR p.start_date >= :startDate) AND " +
           "(:endDate IS NULL OR p.end_date <= :endDate) " +
           "ORDER BY p.id",
           nativeQuery = true)
    List<Project> findProjectsByFilters(
        @Param("search") String search,
        @Param("status") String status,
        @Param("manager") String manager,
        @Param("startDate") LocalDate startDate,
        @Param("endDate") LocalDate endDate
    );
}
