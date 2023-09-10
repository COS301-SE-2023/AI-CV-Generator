package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.SkillEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Skill;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.List;

import static org.assertj.core.api.Java6Assertions.assertThat;

@DataJpaTest
class SkillRepositoryTest {

    @Autowired
    private SkillRepository skillRepository;
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
        skillRepository.deleteAll();
    }

    @Test
    void getSkillsFromUser() {
        // given
        UserEntity user = userRepository.findByUsername("Nate").orElseThrow();
        SkillEntity skill = SkillEntity.builder()
                        .skill("Skill")
                        .user(user)
                        .level(2)
                        .reason("Reason")
                        .build();

        skillRepository.save(skill);
        // when
        List<Skill> skills = skillRepository.getSkillsFromUser(user.getUsername());
        // then
        assertThat(skills.size()==1&&skills.get(0).getReason() == skill.getReason()).isTrue();
    }
}