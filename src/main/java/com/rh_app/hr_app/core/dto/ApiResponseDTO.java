package com.rh_app.hr_app.core.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Generic API Response structure.
 * @param <T> Type of data in the response.
 */
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ApiResponseDTO<T> {

    private boolean success;
    private String message;
    private T data;

}
