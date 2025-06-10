package com.rh_app.hr_app.features.contract.dto;

import com.rh_app.hr_app.core.enums.ContractType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ContractDTO {
    private Long id;
    private ContractType type;
    private Date start_date;
    private Date end_date;
    private Double salary;
    private String Currency;
    private boolean isActive;
    private String employeeId;
}