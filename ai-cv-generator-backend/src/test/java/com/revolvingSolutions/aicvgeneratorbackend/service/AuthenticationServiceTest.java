package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.RegRequest;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.verify;

class AuthenticationServiceTest {

    private AuthenticationService authenticationService;

    @Mock
    private UserRepository userRepository;
    @Mock
    private PasswordEncoder passwordEncoder;
    @Mock
    private AuthService authService;
    @Mock
    private RefreshTokenService refreshTokenService;
    @Mock
    private AuthenticationManager authenticationManager;

    private AutoCloseable closeable;
    @BeforeEach
    void setUp() {
        closeable = MockitoAnnotations.openMocks(this);
        authenticationService = new AuthenticationService(
                userRepository,
                passwordEncoder,
                authService,
                refreshTokenService,
                authenticationManager
        );
    }

    @AfterEach
    void tearDown() throws Exception {
        closeable.close();
    }

    @Test
    void register() {
        // given
        RegRequest req = RegRequest.builder()
                .fname("fname")
                .lname("lname")
                .username("username")
                .password("password")
                .build();
        // when
        authenticationService.register(req);
        // then
        ArgumentCaptor<String> usernameArgCapture = ArgumentCaptor.forClass(String.class);
        ArgumentCaptor<UserEntity> userEntityArgumentCaptor = ArgumentCaptor.forClass(UserEntity.class);
        ArgumentCaptor<String> passwordArgumentCaptor = ArgumentCaptor.forClass(String.class);
        ArgumentCaptor<Integer> idArgumentCaptor = ArgumentCaptor.forClass(Integer.class);
        verify(userRepository).findByUsername(usernameArgCapture.capture());
        String username = usernameArgCapture.getValue();
        assertThat(username == "username").isTrue();
        verify(passwordEncoder).encode(passwordArgumentCaptor.capture());
        String password = passwordArgumentCaptor.getValue();
        assertThat(password == "password");
        verify(userRepository).save(userEntityArgumentCaptor.capture());
        UserEntity user = userEntityArgumentCaptor.getValue();
        assertThat(
                user.getUsername() == "username"&&
                        user.fname == "fname" &&
                        user.lname == "lname" &&
                        user.password != "password"
                ).isTrue();
        verify(authService).genToken(user);
        verify(userRepository).findByUsername("username");
    }

    @Test
    void authenticate() {
    }

    @Test
    void refresh() {
    }

    @Test
    void testRegister() {
    }

    @Test
    void testAuthenticate() {
    }

    @Test
    void testRefresh() {
    }
}