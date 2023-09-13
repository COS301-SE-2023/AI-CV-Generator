package com.revolvingSolutions.aicvgeneratorbackend.intergrationTests;

import com.revolvingSolutions.aicvgeneratorbackend.controller.WebScraperController;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.webscraper.JobScrapeRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.webscraper.JobScrapeResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.JobScraperService;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Objects;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.mockito.Mockito.mock;

@DataJpaTest
public class WebScraperIntegrationTest {
    private WebScraperController controller;
    private JobScraperService service;

    @Autowired
    private UserRepository repository;

    @Mock
    private UserService userService;

    private AutoCloseable closeable;

    private UserEntity originUser;

    @BeforeEach
    void setUp() {
        closeable = MockitoAnnotations.openMocks(this);
        service = new JobScraperService(repository,userService);
        controller = new WebScraperController(service);
        // given
        Authentication authentication = mock(Authentication.class);
        // Mockito.whens() for your authorization object
        SecurityContext securityContext = mock(SecurityContext.class);
        Mockito.when(securityContext.getAuthentication()).thenReturn(authentication);
        SecurityContextHolder.setContext(securityContext);

        originUser = UserEntity.builder()
                .username("Nate")
                .fname("Nathan")
                .lname("Opperman")
                .email("u21553832@tuks.co.za")
                .role(Role.USER)
                .password("password")
                .build();

        Mockito.when(authentication.getName()).thenReturn("Nate");
        repository.saveAndFlush(originUser);
    }
    @AfterEach
    void tearDown() throws Exception {
        closeable.close();
        repository.deleteAll();
    }

    @Test
    void scrapeJobs() {
        // given
        JobScrapeRequest req = JobScrapeRequest.builder()
                .field("Computer Science")
                .location("South Africa")
                .build();
        // when
        ResponseEntity<JobScrapeResponse> response = controller.jobScrape(req);
        // then
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
        assertThat(Objects.requireNonNull(response.getBody()).getJobs().isEmpty()).isFalse();
    }
}
