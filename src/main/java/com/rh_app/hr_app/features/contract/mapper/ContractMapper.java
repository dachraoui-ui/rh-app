package com.rh_app.hr_app.features.contract.mapper;

import com.rh_app.hr_app.features.contract.dto.ContractDTO;
import com.rh_app.hr_app.features.contract.model.Contract;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class ContractMapper {

    /**
     * Converts a Contract entity to a ContractDTO
     * Used when sending data to client/frontend
     */
    public ContractDTO toDTO(Contract contract) {
        if (contract == null) {
            return null;
        }

        return ContractDTO.builder()
                .id(contract.getId())
                .type(contract.getType())
                .start_date(contract.getStart_date())
                .end_date(contract.getEnd_date())
                .salary(contract.getSalary())
                .Currency(contract.getCurrency())
                .employeeId(contract.getEmployeeId())
                .build();
    }

    /**
     * Converts a ContractDTO to a Contract entity
     * Used when receiving data from client/frontend for persistence
     */
    public Contract toEntity(ContractDTO dto) {
        if (dto == null) {
            return null;
        }
