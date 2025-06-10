package com.rh_app.hr_app.features.contract.service;

import com.rh_app.hr_app.core.enums.ContractType;
import com.rh_app.hr_app.features.contract.dto.ContractDTO;
import com.rh_app.hr_app.features.contract.mapper.ContractMapper;
import com.rh_app.hr_app.features.contract.model.Contract;
import com.rh_app.hr_app.features.contract.repository.ContractRepo;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ContractService {

    private final ContractRepo contractRepo;
    private final ContractMapper contractMapper;

    // ============== Basic CRUD Operations ==============

    @Transactional
    public ContractDTO createContract(ContractDTO contractDTO) {
        Contract contract = contractMapper.toEntity(contractDTO);
        contract.setActive(true); // Ensure new contracts are active
        Contract savedContract = contractRepo.save(contract);
        return contractMapper.toDTO(savedContract);
    }

    public ContractDTO getContractById(Long id) {
        return contractRepo.findById(id)
                .map(contractMapper::toDTO)
                .orElseThrow(() -> new EntityNotFoundException("Contract not found with id: " + id));
    }

    @Transactional
    public ContractDTO updateContract(Long id, ContractDTO contractDTO) {
        if (!contractRepo.existsById(id)) {
            throw new EntityNotFoundException("Contract not found with id: " + id);
        }

        Contract contract = contractMapper.toEntity(contractDTO);
        contract.setId(id); // Ensure the ID is set correctly
        Contract updatedContract = contractRepo.save(contract);
        return contractMapper.toDTO(updatedContract);
    }

    /**
     * Archives a contract by marking it as inactive instead of physically deleting it
     */
    @Transactional
    public void archiveContract(Long id) {
        Contract contract = contractRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Contract not found with id: " + id));
        contract.setActive(false);
        contractRepo.save(contract);
    }

    /**
     * Permanently deletes the contract from the database
     */
    @Transactional
    public void deleteContract(Long id) {
        if (!contractRepo.existsById(id)) {
            throw new EntityNotFoundException("Contract not found with id: " + id);
        }
        contractRepo.deleteById(id);
    }

    /**
     * Restore a previously archived contract
     */
    @Transactional
    public ContractDTO restoreContract(Long id) {
        Contract contract = contractRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Contract not found with id: " + id));
        contract.setActive(true);
        Contract savedContract = contractRepo.save(contract);
        return contractMapper.toDTO(savedContract);
    }
    // ============== Operational Query Methods ==============

    /**
     * Gets all contracts regardless of status
     */
    public List<ContractDTO> getAllContracts() {
        return contractMapper.toDTOList(contractRepo.findAll());
    }

    /**
     * Gets active contracts for a specific employee
     */
    public List<ContractDTO> getActiveContractsByEmployeeId(String employeeId) {
        return contractMapper.toDTOList(contractRepo.findByEmployeeIdAndIsActiveTrue(employeeId));
    }

    /**
     * Gets all contracts for a specific employee
     */
    public List<ContractDTO> getAllContractsByEmployeeId(String employeeId) {
        return contractMapper.toDTOList(contractRepo.findByEmployeeId(employeeId));
    }

    /**
     * Gets active contracts by employee and type
     */
    public List<ContractDTO> getActiveContractsByEmployeeIdAndType(String employeeId, ContractType type) {
        return contractMapper.toDTOList(
                contractRepo.findByEmployeeIdAndTypeAndIsActiveTrue(employeeId, type));
    }

    // ============== KPI Methods ==============

    /**
     * Gets contracts expiring within specified days - for renewal planning
     */
    public List<ContractDTO> getActiveContractsExpiringInDays(int days) {
        Date today = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(today);
        calendar.add(Calendar.DAY_OF_MONTH, days);
        Date futureDate = calendar.getTime();

        return contractMapper.toDTOList(
                contractRepo.findActiveContractsExpiringBetween(today, futureDate));
    }

    /**
     * Gets salary distribution data for analytics
     */
    public List<ContractDTO> getActiveContractsBySalaryRange(Double minSalary, Double maxSalary) {
        return contractMapper.toDTOList(
                contractRepo.findBySalaryBetweenAndIsActiveTrue(minSalary, maxSalary));
    }

    /**
     * Gets contract type distribution for workforce analysis
     */
    public List<ContractDTO> getActiveContractsByType(ContractType type) {
        return contractMapper.toDTOList(contractRepo.findByTypeAndIsActiveTrue(type));
    }

    /**
     * Gets count of active contracts - for workforce size metrics
     */
    public List<ContractDTO> getAllActiveContracts() {
        return contractMapper.toDTOList(contractRepo.findByIsActiveTrue());
    }

    /**
     * Gets count of archived contracts - for turnover metrics
     */
    public List<ContractDTO> getInactiveContracts() {
        return contractMapper.toDTOList(contractRepo.findByIsActiveFalse());
    }

    /**
     * Gets currently active contracts based on date validation
     */
    public List<ContractDTO> getActiveContracts() {
        return contractMapper.toDTOList(contractRepo.findActiveContracts(new Date()));
    }


}