package com.rh_app.hr_app.features.department.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.Instant;
import java.util.HashSet;
import java.util.Set;

/**
 * One HR department in the company.
 * • exactly ONE manager  (Keycloak user-id) − enforced by a UNIQUE DB-constraint
 * • between 1 and 3 support agents          − enforced by @Size + helper methods
 */
@Entity
@Table(
        name = "department",
        uniqueConstraints = {
                // ❶ no two departments may share the same name
                @UniqueConstraint(name = "uk_department_name",
                        columnNames = "name"),
                // ❷ one Keycloak user can manage at most ONE department
                @UniqueConstraint(name = "uk_department_manager",
                        columnNames = "manager_user_id")
        }
)
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class Department {

    /* ---------- primary key ---------- */

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /* ---------- basic info ---------- */

    @Column(nullable = false, length = 80)
    private String name;

    @Column(length = 200)
    private String description;

    /* ---------- manager (ONE-to-ONE) ---------- */

    /**
     * UUID coming from Keycloak – *not* a local User entity.
     * UNIQUE constraint (#uk_department_manager) guarantees
     * that this user is manager of exactly one department.
     */
    @Column(name = "manager_user_id",
            nullable = false,
            length = 36)
    private String managerUserId;

    /* ---------- support staff (1 … 3) ---------- */

    /**
     * Set of Keycloak user-ids that act as support agents for
     * this department.  Stored in a separate join-table so we
     * do not need a full “SupportUser” entity.
     */
    @ElementCollection(fetch = FetchType.LAZY)
    @CollectionTable(
            name = "department_support",
            joinColumns = @JoinColumn(name = "department_id"),
            uniqueConstraints = {
                    // one user can appear only once per department
                    @UniqueConstraint(name = "uk_department_support_unique",
                            columnNames = { "department_id", "support_user_id" })
            }
    )
    @Column(name = "support_user_id", length = 36, nullable = false)
    @Size(max = 3, message = "A department may have at most 3 support users")
    private Set<String> supportUserIds = new HashSet<>();

    /* ---------- audit ---------- */

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private Instant createdAt;

    /* ---------- helpers ---------- */

    /**
     * Add a new support agent, enforcing the 1-to-3 rule
     * in Java *and* @Size in DB/Bean-Validation.
     */
    public void addSupportUser(String userId) {
        if (supportUserIds.size() >= 3) {
            throw new IllegalStateException("Department already has 3 support users");
        }
        supportUserIds.add(userId);
    }

    public void removeSupportUser(String userId) {
        supportUserIds.remove(userId);
    }
}
