package com.rh_app.hr_app.features.contract.repository;

import com.rh_app.hr_app.core.enums.ContractType;
import com.rh_app.hr_app.features.contract.model.Contract;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface ContractRepo extends JpaRepository<Contract, Long> {

    // Find all active contracts for a specific employee
    List<Contract> findByEmployeeIdAndIsActiveTrue(String employeeId);

    // Find all contracts for a specific employee regardless of active status
    List<Contract> findByEmployeeId(String employeeId);

    // Find active contracts by type
    List<Contract> findByTypeAndIsActiveTrue(ContractType type);

    // Find contracts by type regardless of active status
    List<Contract> findByType(ContractType type);

    // Find active contracts (current date between start and end date)
    @Query("SELECT c FROM Contract c WHERE c.isActive = true AND :currentDate BETWEEN c.start_date AND c.end_date")
    List<Contract> findActiveContracts(@Param("currentDate") Date currentDate);

    // Find active contracts that will expire within a certain number of days
    @Query("SELECT c FROM Contract c WHERE c.isActive = true AND c.end_date BETWEEN :today AND :futureDate")
    List<Contract> findActiveContractsExpiringBetween(@Param("today") Date today, @Param("futureDate") Date futureDate);

    // Find active contracts by salary range
    List<Contract> findBySalaryBetweenAndIsActiveTrue(Double minSalary, Double maxSalary);

    // Find contracts by salary range regardless of active status
    List<Contract> findBySalaryBetween(Double minSalary, Double maxSalary);

    // Find active contracts by employee ID and contract type
    List<Contract> findByEmployeeIdAndTypeAndIsActiveTrue(String employeeId, ContractType type);

    // Find contracts by employee ID and contract type regardless of active status
    List<Contract> findByEmployeeIdAndType(String employeeId, ContractType type);

    // Find all active contracts
    List<Contract> findByIsActiveTrue();

    // Find all inactive contracts
    List<Contract> findByIsActiveFalse();
}