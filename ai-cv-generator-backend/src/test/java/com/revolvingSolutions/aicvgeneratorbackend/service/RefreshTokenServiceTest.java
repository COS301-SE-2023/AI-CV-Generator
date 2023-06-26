package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.RefreshToken;
import com.revolvingSolutions.aicvgeneratorbackend.repository.RefreshTokenRepository;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.time.Instant;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.mockito.Mockito.verify;

class RefreshTokenServiceTest {

    private RefreshTokenService refreshTokenService;

    @Mock
    private RefreshTokenRepository refreshTokenRepository;

    @Mock
    private UserRepository userRepository;



    private AutoCloseable closeable;

    @BeforeEach
    void setUp() {
        closeable = MockitoAnnotations.openMocks(this);
        refreshTokenService = new RefreshTokenService(refreshTokenRepository,userRepository);
    }

    @AfterEach
    void tearDown() throws Exception {
        closeable.close();
    }

    @Test
    void findByToken() {
        // given
        String token = "000000000111111111";
        // when
        refreshTokenService.findByToken(token);
        // then
        verify(refreshTokenRepository).findByToken(token);
    }

    @Test
    @Disabled
    void createRefreshToken() {
        // given
        int id = 1234;
        // when
        refreshTokenService.createRefreshToken(id);
        // then
        verify(userRepository).findById(1234).orElseThrow();
        ArgumentCaptor<RefreshToken> refreshTokenArgumentCaptor = ArgumentCaptor.forClass(RefreshToken.class);
        verify(refreshTokenRepository).save(refreshTokenArgumentCaptor.capture());
        assertThat(refreshTokenArgumentCaptor.getValue() != null).isTrue();
    }

    @Test
    void verifyExpiration() {
        // given
        RefreshToken refreshToken = RefreshToken.builder()
                .token("token")
                .expiryDate(Instant.now())
                .build();
        // when
        refreshTokenService.verifyExpiration(refreshToken);
        // then
    }

    @Test
    @Disabled
    void deleteByUserId() {
    }
}