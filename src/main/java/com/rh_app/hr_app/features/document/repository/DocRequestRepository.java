package com.rh_app.hr_app.features.document.repository;

import com.rh_app.hr_app.core.enums.document_enums.DocRequestStatus;
import com.rh_app.hr_app.features.document.model.DocumentRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.Instant;
import java.util.Collection;
import java.util.List;

public interface DocRequestRepository extends JpaRepository<DocumentRequest, Long> {

    /* ---------- Lists for UI ---------- */

    /* Employee “My requests”. */
    Page<DocumentRequest> findByRequestedByOrderByCreatedAtDesc(
            String requestedBy, Pageable page);

    /* HR inbox filter (e.g. OPEN = REQUESTED+ACCEPTED+PREPARING). */
    Page<DocumentRequest> findByStatusInOrderByCreatedAtAsc(
            Collection<DocRequestStatus> statuses, Pageable page);

    /* GRH “assigned to me” view. */
    Page<DocumentRequest> findByAssignedToAndStatusInOrderByCreatedAtAsc(
            String assignedTo, Collection<DocRequestStatus> statuses, Pageable page);

    /* ---------- KPI / dashboard ---------- */

    long countByStatus(DocRequestStatus status);                      // per state
    long countByStatusIn(Collection<DocRequestStatus> statuses);      // e.g. open total
    long countByStatusAndTemplate_Type(DocRequestStatus status,
                                       com.rh_app.hr_app.core.enums.document_enums.DocTemplateType type);

    /* Overdue requests: still not READY after N hours. */
    List<DocumentRequest> findByStatusInAndCreatedAtBefore(
            Collection<DocRequestStatus> statuses, Instant threshold);
}
