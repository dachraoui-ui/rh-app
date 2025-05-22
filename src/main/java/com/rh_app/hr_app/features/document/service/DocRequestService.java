package com.rh_app.hr_app.features.document.service;

import com.rh_app.hr_app.core.enums.document_enums.DocRequestStatus;
import com.rh_app.hr_app.core.enums.document_enums.DocTemplateType;
import com.rh_app.hr_app.features.document.dto.*;
import com.rh_app.hr_app.features.document.mapper.DocRequestMapper;
import com.rh_app.hr_app.features.document.mapper.DocTemplateMapper;
import com.rh_app.hr_app.features.document.model.DocumentRequest;
import com.rh_app.hr_app.features.document.model.DocumentTemplate;
import com.rh_app.hr_app.features.document.repository.DocRequestRepository;
import com.rh_app.hr_app.features.document.repository.DocTemplateRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.Instant;
import java.util.List;
import java.util.Set;

@Slf4j
@Service
@RequiredArgsConstructor
public class DocRequestService {

    private final DocRequestRepository repo;
    private final DocTemplateRepository tplRepo;

    /* ====== EMPLOYEE FLOW ================================================= */

    @Transactional
    public DocRequestDto create(DocRequestCreateDto dto, String employee) {
        var template = tplRepo.findById(dto.templateId()).orElseThrow();
        var entity = DocRequestMapper.toEntityForCreate(
                dto, template, employee, Instant.now());
        return DocRequestMapper.toDto(repo.save(entity));
    }

    public Page<DocRequestDto> listMine(String employee, Pageable p) {
        return repo.findByRequestedByOrderByCreatedAtDesc(employee, p)
                .map(DocRequestMapper::toDto);
    }

    /* ====== HR INBOX ====================================================== */

    private static final List<DocRequestStatus> BACKLOG =
            List.of(DocRequestStatus.REQUESTED,
                    DocRequestStatus.ACCEPTED,
                    DocRequestStatus.PREPARING,
                    DocRequestStatus.READY,
                    DocRequestStatus.DELIVERED,
                    DocRequestStatus.REJECTED);

    /* List all document requests regardless of status */
    public Page<DocRequestDto> listAllRequests(Pageable p) {
        return repo.findAllByOrderByCreatedAtAsc(p)
                .map(DocRequestMapper::toDto);
    }

    public Page<DocRequestDto> listAssigned(String grh, Pageable p) {
        return repo.findByAssignedToAndStatusInOrderByCreatedAtAsc(grh, BACKLOG, p)
                .map(DocRequestMapper::toDto);
    }
    /**
     * Retrieve a document request file for download by an employee
     * @param id Request ID
     * @param username Employee username
     * @return The document request with file data
     * @throws IllegalArgumentException if request doesn't exist or doesn't belong to user
     * @throws IllegalStateException if document isn't ready for download
     */
    @Transactional
    public DocumentRequest getRequestFileForDownload(Long id, String username) {
        DocumentRequest request = repo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Document request not found"));

        // Verify the request belongs to this user
        if (!request.getRequestedBy().equals(username)) {
            throw new IllegalArgumentException("Document request not found");
        }

        // Verify document is READY or DELIVERED
        if (request.getStatus() != DocRequestStatus.READY &&
                request.getStatus() != DocRequestStatus.DELIVERED) {
            throw new IllegalStateException("Document is not ready for download");
        }

        // If document was ready but not delivered yet, mark as delivered
        if (request.getStatus() == DocRequestStatus.READY) {
            request.setStatus(DocRequestStatus.DELIVERED);
            request.setDeliveredAt(Instant.now());
        }

        return request;
    }

    /* ====== WORKFLOW  (GRH / DRH) ======================================== */

    @Transactional
    public DocRequestDto patchWorkflow(Long id,
                                       DocRequestWorkflowDto patch,
                                       String hrUser) {
        DocumentRequest entity = repo.findById(id).orElseThrow();
        DocRequestMapper.applyWorkflow(entity, patch, hrUser, Instant.now());
        return DocRequestMapper.toDto(entity);
    }

    @Transactional
    public DocRequestDto markReady(Long id,
                                   MultipartFile pdf,
                                   String hrUser) throws IOException {

        DocumentRequest r = repo.findById(id).orElseThrow();
        if (r.getStatus() != DocRequestStatus.PREPARING
                && r.getStatus() != DocRequestStatus.ACCEPTED)
            throw new IllegalStateException("Request not in a preparable state");

        r.setOutputData(pdf.getBytes());
        r.setOutputName(pdf.getOriginalFilename());
        r.setOutputMime(pdf.getContentType());
        r.setOutputSize((long) pdf.getBytes().length);
        r.setStatus(DocRequestStatus.READY);
        r.setResolvedBy(hrUser);
        r.setResolvedAt(Instant.now());
        return DocRequestMapper.toDto(r);
    }


    /* ====== KPI helpers =================================================== */

    public long countByStatus(DocRequestStatus s)               { return repo.countByStatus(s); }
    public long countOpen()                                     { return repo.countByStatusIn(BACKLOG); }
    public long countReady()                                    { return repo.countByStatus(DocRequestStatus.READY); }
    public long countDelivered()                                { return repo.countByStatus(DocRequestStatus.DELIVERED); }

    /* Overdue = still not READY after X hours */
    public List<DocRequestDto> findOverdue(long hours) {
        Instant threshold = Instant.now().minusSeconds(hours * 3600);
        return repo.findByStatusInAndCreatedAtBefore(
                        List.of(DocRequestStatus.REQUESTED,
                                DocRequestStatus.ACCEPTED),
                        threshold)
                .stream().map(DocRequestMapper::toDto).toList();
    }
}
