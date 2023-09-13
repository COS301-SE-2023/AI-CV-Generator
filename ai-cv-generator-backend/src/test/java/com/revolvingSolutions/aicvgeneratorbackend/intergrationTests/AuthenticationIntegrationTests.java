package com.revolvingSolutions.aicvgeneratorbackend.intergrationTests;

import com.revolvingSolutions.aicvgeneratorbackend.controller.AuthController;
import com.revolvingSolutions.aicvgeneratorbackend.repository.PasswordTokenRepository;
import com.revolvingSolutions.aicvgeneratorbackend.repository.RefreshTokenRepository;
import com.revolvingSolutions.aicvgeneratorbackend.repository.RegistrationTokenRepository;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.service.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@DataJpaTest
public class AuthenticationIntegrationTests {

    private AuthController controller;
    private AuthenticationService service;
    private AuthService authService;
    private RegistrationTokenService registrationTokenService;
    private RefreshTokenService refreshTokenService;
    private PasswordTokenService passwordTokenService;
    private PasswordEncoder passwordEncoder;
    private EmailService emailService;
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RefreshTokenRepository refreshTokenRepository;
    @Autowired
    private RegistrationTokenRepository registrationTokenRepository;
    @Autowired
    private PasswordTokenRepository passwordTokenRepository;

    @BeforeEach
    void setUp() {
        // Not our actual signing key
        authService = new AuthService();
        passwordEncoder = new BCryptPasswordEncoder();
        refreshTokenService = new RefreshTokenService(
                refreshTokenRepository,
                userRepository
        );
        authenticationManager = new AuthenticationManager() {
            @Override
            public Authentication authenticate(Authentication authentication) throws AuthenticationException {
                return authentication;
            }
        };
        emailService = new EmailService();
        registrationTokenService = new RegistrationTokenService();
        passwordTokenService = new PasswordTokenService();
        service = new AuthenticationService(
                userRepository,
                passwordEncoder,
                authService,
                refreshTokenService,
                authenticationManager,
                emailService,
                registrationTokenService,
                passwordTokenService
        );
        controller = new AuthController(service);
    }

    @AfterEach
    void tearDown() {
        userRepository.deleteAll();
        refreshTokenRepository.deleteAll();;
        registrationTokenRepository.deleteAll();
        passwordTokenRepository.deleteAll();
    }

}
