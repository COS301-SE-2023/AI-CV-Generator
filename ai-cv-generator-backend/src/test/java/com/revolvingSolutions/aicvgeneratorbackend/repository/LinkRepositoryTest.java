package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.LinkEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Link;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.List;

import static org.assertj.core.api.Java6Assertions.assertThat;

@DataJpaTest
class LinkRepositoryTest {

    @Autowired
    private LinkRepository linkRepository;
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
        linkRepository.deleteAll();
    }

    @Test
    void getLinksFromUser() {
        // given
        UserEntity user = userRepository.findByUsername("Nate").orElseThrow();
        LinkEntity link = LinkEntity.builder()
                .user(user)
                .url("this is the url")
                .build();
        linkRepository.save(link);
        // when
        List<Link> links = linkRepository.getLinksFromUser(user.getUsername());
        // then
        assertThat(links.size()==1&&links.get(0).getUrl() == link.getUrl()).isTrue();
    }
}