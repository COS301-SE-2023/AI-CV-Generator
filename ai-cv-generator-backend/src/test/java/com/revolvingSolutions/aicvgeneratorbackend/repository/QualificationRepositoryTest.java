package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.QualificationEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Qualification;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.time.Instant;
import java.util.Date;
import java.util.List;

import static org.assertj.core.api.Java6Assertions.assertThat;

@DataJpaTest
class QualificationRepositoryTest {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private QualificationRepository qualificationRepository;

    @AfterEach
    void TearDown() {
        qualificationRepository.deleteAll();
        userRepository.deleteAll();
    }

    @BeforeEach
    void SetUp() {
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

    @Test
    void ItShouldGetQualificationsFromUser() {
        // given
        UserEntity user = userRepository.findByUsername("Nate").orElseThrow();
        QualificationEntity qualification = QualificationEntity.builder()
                .user(user)
                .qualification("Bsc CS")
                .intstitution("tuks")
                .date(Date.from(Instant.now()))
                .build();
        qualificationRepository.save(qualification);
        // when
        List<Qualification> qualification1 = qualificationRepository.getQualificationsFromUser(user.getUsername());
        // then
        assertThat(qualification1.get(0).getQualification() == qualification.getQualification()).isTrue();
    }

    @Test
    void ItShouldNotGetQualificationsFromUser() {
        // given
        UserEntity user = userRepository.findByUsername("Nate").orElseThrow();
        QualificationEntity qualification = QualificationEntity.builder()
                .user(user)
                .qualification("Bsc CS")
                .intstitution("tuks")
                .date(Date.from(Instant.now()))
                .build();
        // when
        List<Qualification> qualification1 = qualificationRepository.getQualificationsFromUser(user.getUsername());
        // then
        assertThat(qualification1.isEmpty()).isTrue();
    }
}