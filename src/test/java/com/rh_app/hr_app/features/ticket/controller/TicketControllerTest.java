package com.rh_app.hr_app.features.ticket.controller;

import com.rh_app.hr_app.core.enums.ticket_enums.HrRequestCategory;
import com.rh_app.hr_app.core.enums.ticket_enums.TicketPriority;
import com.rh_app.hr_app.core.enums.ticket_enums.TicketStatus;
import com.rh_app.hr_app.features.ticket.dto.TicketDto;
import com.rh_app.hr_app.features.ticket.dto.TicketUpdateDto;
import com.rh_app.hr_app.features.ticket.service.TicketService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.time.Instant;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

public class TicketControllerTest {

    @Mock
    private TicketService ticketService;

    @Mock
    private Authentication authentication;

    @InjectMocks
    private TicketController ticketController;

    private final String TEST_USER_ID = "test-user";
    private final Long TEST_TICKET_ID = 1L;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);

        // Setup authentication mock
        when(authentication.getName()).thenReturn(TEST_USER_ID);
    }

    @Test
    void testTicketEscalationByGRH() {
        // Arrange
        // Setup GRH role
        Collection<GrantedAuthority> authorities = Collections.singletonList(
            new SimpleGrantedAuthority("ROLE_GRH")
        );
        doReturn(authorities).when(authentication).getAuthorities();

        // Create update DTO for escalation (changing priority and assignee)
        TicketUpdateDto updateDto = TicketUpdateDto.builder()
            .status(TicketStatus.IN_PROGRESS)
            .priority(TicketPriority.HIGH)
            .assignedTo("manager-user-id")
            .build();

        // Mock service response
        TicketDto expectedResponse = TicketDto.builder()
            .id(TEST_TICKET_ID)
            .status(TicketStatus.IN_PROGRESS)
            .priority(TicketPriority.HIGH)
            .assignedTo("manager-user-id")
            .build();

        when(ticketService.updateTicket(
            eq(TEST_TICKET_ID), 
            any(TicketUpdateDto.class), 
            eq(TEST_USER_ID), 
            eq(true),  // isGrh
            eq(false), // isManager
            eq(false)  // isSupport
        )).thenReturn(expectedResponse);

        // Act
        ResponseEntity<TicketDto> response = ticketController.update(TEST_TICKET_ID, updateDto, authentication);

        // Assert
        assertNotNull(response);
        assertEquals(200, response.getStatusCodeValue());
        assertNotNull(response.getBody());
        assertEquals(TEST_TICKET_ID, response.getBody().getId());
        assertEquals(TicketStatus.IN_PROGRESS.toString(), response.getBody().getStatus().toString());
        assertEquals(TicketPriority.HIGH.toString(), response.getBody().getPriority().toString());
        assertEquals("manager-user-id", response.getBody().getAssignedTo());

        // Verify service was called with correct parameters
        verify(ticketService).updateTicket(
            eq(TEST_TICKET_ID), 
            eq(updateDto), 
            eq(TEST_USER_ID), 
            eq(true),  // isGrh
            eq(false), // isManager
            eq(false)  // isSupport
        );
    }

    @Test
    void testTicketEscalationByManager() {
        // Arrange
        // Setup Manager role
        Collection<GrantedAuthority> authorities = Collections.singletonList(
            new SimpleGrantedAuthority("ROLE_MANAGER")
        );
        doReturn(authorities).when(authentication).getAuthorities();

        // Create update DTO for escalation (changing status to indicate escalation)
        TicketUpdateDto updateDto = TicketUpdateDto.builder()
            .status(TicketStatus.IN_PROGRESS)
            .priority(TicketPriority.CRITICAL)
            .build();

        // Mock service response
        TicketDto expectedResponse = TicketDto.builder()
            .id(TEST_TICKET_ID)
            .status(TicketStatus.IN_PROGRESS)
            .priority(TicketPriority.CRITICAL)
            .escalationLevel(1) // Escalated to level 1
            .build();

        when(ticketService.updateTicket(
            eq(TEST_TICKET_ID), 
            any(TicketUpdateDto.class), 
            eq(TEST_USER_ID), 
            eq(false), // isGrh
            eq(true),  // isManager
            eq(false)  // isSupport
        )).thenReturn(expectedResponse);

        // Act
        ResponseEntity<TicketDto> response = ticketController.update(TEST_TICKET_ID, updateDto, authentication);

        // Assert
        assertNotNull(response);
        assertEquals(200, response.getStatusCodeValue());
        assertNotNull(response.getBody());
        assertEquals(TEST_TICKET_ID, response.getBody().getId());
        assertEquals(TicketStatus.IN_PROGRESS.toString(), response.getBody().getStatus().toString());
        assertEquals(TicketPriority.CRITICAL.toString(), response.getBody().getPriority().toString());
        assertEquals(1, response.getBody().getEscalationLevel());

        // Verify service was called with correct parameters
        verify(ticketService).updateTicket(
            eq(TEST_TICKET_ID), 
            eq(updateDto), 
            eq(TEST_USER_ID), 
            eq(false), // isGrh
            eq(true),  // isManager
            eq(false)  // isSupport
        );
    }

    @Test
    void testTicketEscalationBySupport() {
        // Arrange
        // Setup Support role
        Collection<GrantedAuthority> authorities = Collections.singletonList(
            new SimpleGrantedAuthority("ROLE_SUPPORT")
        );
        doReturn(authorities).when(authentication).getAuthorities();

        // Create update DTO for escalation (changing status and priority)
        TicketUpdateDto updateDto = TicketUpdateDto.builder()
            .status(TicketStatus.IN_PROGRESS)
            .priority(TicketPriority.HIGH)
            .build();

        // Mock service response
        TicketDto expectedResponse = TicketDto.builder()
            .id(TEST_TICKET_ID)
            .status(TicketStatus.IN_PROGRESS)
            .priority(TicketPriority.HIGH)
            .build();

        when(ticketService.updateTicket(
            eq(TEST_TICKET_ID), 
            any(TicketUpdateDto.class), 
            eq(TEST_USER_ID), 
            eq(false), // isGrh
            eq(false), // isManager
            eq(true)   // isSupport
        )).thenReturn(expectedResponse);

        // Act
        ResponseEntity<TicketDto> response = ticketController.update(TEST_TICKET_ID, updateDto, authentication);

        // Assert
        assertNotNull(response);
        assertEquals(200, response.getStatusCodeValue());
        assertNotNull(response.getBody());
        assertEquals(TEST_TICKET_ID, response.getBody().getId());
        assertEquals(TicketStatus.IN_PROGRESS.toString(), response.getBody().getStatus().toString());
        assertEquals(TicketPriority.HIGH.toString(), response.getBody().getPriority().toString());

        // Verify service was called with correct parameters
        verify(ticketService).updateTicket(
            eq(TEST_TICKET_ID), 
            eq(updateDto), 
            eq(TEST_USER_ID), 
            eq(false), // isGrh
            eq(false), // isManager
            eq(true)   // isSupport
        );
    }
}
