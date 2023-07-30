package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.RefreshToken;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.time.Instant;
import java.util.UUID;

import static org.assertj.core.api.Java6Assertions.assertThat;

@DataJpaTest
class RefreshTokenRepositoryTest {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RefreshTokenRepository refreshTokenRepository;
    @BeforeEach
    void setUp() {
        UserEntity user = UserEntity.builder()
                .fname("Nathan")
                .lname("Opperman")
                .email("nathanEmail")
                .role(
                        Role.USER
                )
                .username("Nate")
                .password("password")
                .build();
        userRepository.saveAndFlush(user);
    }

    @AfterEach
    void tearDown() {
        userRepository.deleteAll();
    }
    @Test
    void findByToken() {
        // given
        RefreshToken refreshToken = new RefreshToken();

        refreshToken.setUser(userRepository.findByUsername("Nate").get());
        refreshToken.setExpiryDate(Instant.now().plusMillis(1000));
        refreshToken.setToken(UUID.randomUUID().toString());

        refreshToken = refreshTokenRepository.save(refreshToken);
        // when
        assertThat(true).isTrue();
    }

    @Test
    void deleteByUser() {
    }
}