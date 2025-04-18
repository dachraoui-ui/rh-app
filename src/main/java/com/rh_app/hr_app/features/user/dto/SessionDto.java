package com.rh_app.hr_app.features.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class SessionDto {
    private String id;
    private String ipAddress;
    private Long started;     // Timestamp when the session started
    private Long lastAccess;  // Timestamp of the last access
    private String username;  // Username associated with the session
}
