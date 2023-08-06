package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.EmploymentEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Employment;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.sql.Date;
import java.time.Instant;
import java.util.List;

import static org.assertj.core.api.Java6Assertions.assertThat;

@DataJpaTest
class EmploymentRepositoryTest {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private EmploymentRepository employmentRepository;

    @AfterEach
    void TearDown() {
        employmentRepository.deleteAll();
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
    void getEmploymentHistoryFromUser() {
        // given
        UserEntity user = userRepository.findByUsername("Nate").orElseThrow();
        EmploymentEntity emp = EmploymentEntity.builder()
                .user(user)
                .title("Manager")
                .company("Donuts")
                .startdate(Date.from(Instant.now()))
                .enddate(Date.from(Instant.now()))
                .build();
        employmentRepository.save(emp);
        // when
        List<Employment> employmentList = employmentRepository.getEmploymentHistoryFromUser(user.getUsername());
        // then
        Boolean check = true;
        if (employmentList.size() != 1) {
            check = false;
            assertThat(check).isTrue();
        }
        Employment employ = employmentList.get(0);
        if (emp.getCompany() != employ.getCompany()||emp.getTitle() != employ.getTitle()) {
            check = false;
        }
        assertThat(check).isTrue();
    }
}