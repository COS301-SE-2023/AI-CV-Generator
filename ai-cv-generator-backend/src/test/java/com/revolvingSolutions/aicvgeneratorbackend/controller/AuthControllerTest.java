package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.request.auth.AuthRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.RefreshRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.RegRequest;
import com.revolvingSolutions.aicvgeneratorbackend.service.AuthenticationService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.mock.web.MockHttpServletRequest;

import static org.mockito.Mockito.verify;

class AuthControllerTest {

    private AuthController authController;
    @Mock
    private AuthenticationService authenticationService;

    AutoCloseable closeable;

    @BeforeEach
    void setUp() {
        closeable = MockitoAnnotations.openMocks(this);
        authController = new AuthController(authenticationService);
    }

    @AfterEach
    void tearDown() throws Exception {
        closeable.close();
    }

    @Test
    void register() {
        // given
        RegRequest req = RegRequest.builder()
                .fname("Nathan")
                .lname("Lname")
                .username("Username")
                .password("Password")
                .build();
        MockHttpServletRequest request = new MockHttpServletRequest();
        // when
        authController.register(req,request);
        // then
        verify(authenticationService).register(req,request);
    }

    @Test
    void authenticate() {
        // given
        AuthRequest req = AuthRequest.builder()
                .username("Username")
                .password("Password")
                .build();
        MockHttpServletRequest request = new MockHttpServletRequest();
        // when
        authController.authenticate(req,request);
        // then
        verify(authenticationService).authenticate(req,request);
    }

    @Test
    void refresh() {
        // given
        RefreshRequest req = RefreshRequest.builder()
                .refreshToken("token")
                .build();
        MockHttpServletRequest request = new MockHttpServletRequest();
        // when
        authController.refresh(req,request);
        // then
        verify(authenticationService).refresh(req,request);
    }
}