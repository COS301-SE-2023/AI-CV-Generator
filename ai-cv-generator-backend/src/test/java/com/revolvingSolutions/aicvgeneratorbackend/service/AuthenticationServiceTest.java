package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.RegistrationTokenEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.AuthRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.RegRequest;
import jakarta.servlet.http.HttpServletRequest;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
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

    @Mock
    private EmailService emailService;

    @Mock
    private RegistrationTokenService registrationTokenService;

    @Mock
    private PasswordTokenService passwordTokenService;

    private AutoCloseable closeable;
    @BeforeEach
    void setUp() {
        closeable = MockitoAnnotations.openMocks(this);
        authenticationService = new AuthenticationService(
                userRepository,
                passwordEncoder,
                authService,
                refreshTokenService,
                authenticationManager,
                emailService,
                registrationTokenService,
                passwordTokenService
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
                .email("email")
                .username("username")
                .password("password")
                .build();
        MockHttpServletRequest actualRequest = new MockHttpServletRequest();
        Mockito.when(registrationTokenService.generateToken(any())).thenReturn(
                RegistrationTokenEntity.builder()
                        .registrationToken("Token")
                        .build()
        );
        // when
        authenticationService.register(req,actualRequest);
        // then
        ArgumentCaptor<String> usernameArgCapture = ArgumentCaptor.forClass(String.class);
        ArgumentCaptor<UserEntity> userEntityArgumentCaptor = ArgumentCaptor.forClass(UserEntity.class);
        ArgumentCaptor<String> passwordArgumentCaptor = ArgumentCaptor.forClass(String.class);
        verify(passwordEncoder).encode(passwordArgumentCaptor.capture());
        String password = passwordArgumentCaptor.getValue();
        assertThat(password.equals("password"));
        verify(userRepository).save(userEntityArgumentCaptor.capture());
        UserEntity user = userEntityArgumentCaptor.getValue();
        assertThat(
                user.getUsername().equals("username")&&
                        user.fname.equals("fname") &&
                        user.lname.equals("lname") &&
                        user.password != "password"
                ).isTrue();
    }

    @Test
    @Disabled
    void authenticate() {
        // given
        AuthRequest req = AuthRequest.builder()
                .username("username")
                .password("password")
                .build();
        MockHttpServletRequest actualRequest = new MockHttpServletRequest();
        // when
        ArgumentCaptor<String> usernameArgumentCaptor = ArgumentCaptor.forClass(String.class);
        ArgumentCaptor<UserEntity> userEntityArgumentCaptor = ArgumentCaptor.forClass(UserEntity.class);
        ArgumentCaptor<HttpServletRequest> httpServletRequestArgumentCaptor = ArgumentCaptor.forClass(HttpServletRequest.class);
        ArgumentCaptor<Integer> useridArgumentCaptor = ArgumentCaptor.forClass(Integer.class);
        verify(userRepository).findByUsername(usernameArgumentCaptor.capture());
        assertThat(useridArgumentCaptor.getValue().equals("username")).isTrue();
        verify(authenticationService).getClientIp(httpServletRequestArgumentCaptor.capture());
        assertThat(httpServletRequestArgumentCaptor.getValue().equals(actualRequest)).isTrue();
        verify(refreshTokenService).deleteByUserId(useridArgumentCaptor.capture());

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