package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.ReferenceEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Reference;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.List;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
class ReferenceRepositoryTest {

    @Autowired
    private ReferenceRepository referenceRepository;
    @Autowired
    private UserRepository userRepository;
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
        referenceRepository.deleteAll();
    }

    @Test
    void getReferencesFromUser() {
        // given
        UserEntity user = userRepository.findByUsername("Nate").orElseThrow();
        ReferenceEntity reference = ReferenceEntity.builder()
                .user(user)
                .contact("Contact")
                .description("description")
                .build();
        referenceRepository.save(reference);
        // when
        List<Reference> references = referenceRepository.getReferencesFromUser(user.getUsername());
        // then
        assertThat(references.size()==1&&references.get(0).getDescription() == reference.getDescription()).isTrue();
    }
}