package com.rh_app.hr_app.features.department.repository;

import com.rh_app.hr_app.features.department.model.Department;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DepartmentRepository extends JpaRepository<Department, Long> {

    /* ────────────────────────────────────────────────────────────────
       🔎  Basic uniqueness / existence checks
       ──────────────────────────────────────────────────────────────── */

    /** case-insensitive check used by service when creating/updating. */
    boolean existsByNameIgnoreCase(String name);

    /** enforce “one manager per department” rule. */
    boolean existsByManagerUserId(String managerUserId);

    /** find the department managed by a given user (handy for Manager dashboards). */
    Optional<Department> findByManagerUserId(String managerUserId);


    /* ────────────────────────────────────────────────────────────────
       🔎  Support-user related helper queries
       ──────────────────────────────────────────────────────────────── */

    /**
     * Return all departments where the given user appears in the
     * <code>supportUserIds</code> collection.
     *
     *  – Useful when a support agent logs in and needs to load ONLY the
     *    departments (and thus tickets) they are allowed to see.
     *
     * JPA can query an <code>@ElementCollection</code> with a simple JOIN.
     */
    @Query("""
           select d
             from Department d
             join d.supportUserIds su
            where su = :userId
           """)
    List<Department> findBySupportUserId(@Param("userId") String userId);

    /* If you ever want a boolean check instead of the List:
       boolean existsBySupportUserIdsContains(String userId);    // Spring Data can derive this one automatically
    */


}
