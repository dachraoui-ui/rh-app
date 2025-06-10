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

    public List<DocRequestDto> listAllMine(String employee) {
        return repo.findByRequestedByOrderByCreatedAtDesc(employee)
                .stream()
                .map(DocRequestMapper::toDto)
                .toList();
    }

    /* ====== HR INBOX ====================================================== */

    private static final List<DocRequestStatus> BACKLOG =
            List.of(DocRequestStatus.REQUESTED,
                    DocRequestStatus.ACCEPTED,
                    DocRequestStatus.PREPARING,
                    DocRequestStatus.REJECTED,
                    DocRequestStatus.READY,
                    DocRequestStatus.DELIVERED);

    public List<DocRequestDto> listAllBacklog() {
        return repo.findByStatusInOrderByCreatedAtAsc(BACKLOG)
                .stream()
                .map(DocRequestMapper::toDto)
                .toList();
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
        r.setResolvedAt(Instant.now());
        return DocRequestMapper.toDto(r);
    }
    @Transactional
    public DocTemplateDto updateTemplateNameAndType(Long id, String name, DocTemplateType type) {
        DocumentTemplate template = tplRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Template not found with ID: " + id));

        if (name != null && !name.isBlank()) {
            template.setName(name);
        }

        if (type != null) {
            template.setType(type);
        }

        // No explicit save needed in @Transactional context
        return DocTemplateMapper.toDto(template);
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
