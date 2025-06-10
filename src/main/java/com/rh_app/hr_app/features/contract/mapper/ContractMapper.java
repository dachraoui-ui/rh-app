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
                .isActive(contract.isActive())
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

        return Contract.builder()
                .id(dto.getId())
                .type(dto.getType())
                .start_date(dto.getStart_date())
                .end_date(dto.getEnd_date())
                .salary(dto.getSalary())
                .Currency(dto.getCurrency())
                .isActive(dto.isActive())
                .employeeId(dto.getEmployeeId())
                .build();
    }

    /**
     * Converts a list of Contract entities to a list of ContractDTOs
     * Used for batch operations when returning multiple contracts
     */
    public List<ContractDTO> toDTOList(List<Contract> contracts) {
        return contracts.stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    /**
     * Converts a list of ContractDTOs to a list of Contract entities
     * Used for batch operations when processing multiple contracts
     */
    public List<Contract> toEntityList(List<ContractDTO> dtos) {
        return dtos.stream()
                .map(this::toEntity)
                .collect(Collectors.toList());
    }
}