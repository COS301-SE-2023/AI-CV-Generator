package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.repository.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Optional;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.*;

class UserServiceTest {

    private UserService userService;

    @Mock
    private UserRepository userRepository;

    @Mock
    private FileRepository fileRepository;

    @Mock
    private EmploymentRepository employmentRepository;

    @Mock
    private LinkRepository linkRepository;

    @Mock
    private QualificationRepository qualificationRepository;

    @Mock
    private ReferenceRepository referenceRepository;

    @Mock
    private ShareRepository shareRepository;

    @Mock
    private ProfileImageRepository profileImageRepository;

    @Mock
    private SkillRepository skillRepository;

    @Mock
    private PasswordEncoder passwordEncoder;

    private AutoCloseable closeable;
    @BeforeEach
    void setUp() {
        closeable = MockitoAnnotations.openMocks(this);
        userService = new UserService(
                userRepository,
                fileRepository,
                employmentRepository,
                qualificationRepository,
                linkRepository,
                referenceRepository,
                skillRepository,
                shareRepository,
                profileImageRepository,
                passwordEncoder
        );
    }

    @AfterEach
    void tearDown() throws Exception {
        closeable.close();
    }

    @Test
    void getUser() {
        // given
        Authentication authentication = mock(Authentication.class);
        // Mockito.whens() for your authorization object
        SecurityContext securityContext = mock(SecurityContext.class);
        Mockito.when(securityContext.getAuthentication()).thenReturn(authentication);
        SecurityContextHolder.setContext(securityContext);

        UserEntity user = UserEntity.builder()
                .username("Nate")
                .fname("Nathan")
                .lname("Opperman")
                .email("u21553832@tuks.co.za")
                .role(Role.USER)
                .password("password")
                .build();

        Mockito.when(authentication.getName()).thenReturn("Nate");
        Mockito.when(userRepository.findByUsername(anyString())).thenReturn(Optional.of(user));
        // when
        userService.getUser();
        // then
        assertFalse(authentication instanceof AnonymousAuthenticationToken);
    }

    @Test
    void addEmployment() {
    }

    @Test
    void addQualification() {
    }

    @Test
    void addLink() {
    }

    @Test
    void removeEmployment() {
    }

    @Test
    void removeQualification() {
    }

    @Test
    void removeLink() {
    }

    @Test
    void updateEmployment_() {
    }

    @Test
    void updateQualification_() {
    }

    @Test
    void updateLink_() {
    }

    @Test
    void getEmployments() {
    }

    @Test
    void getQualifications() {
    }

    @Test
    void getLinks() {
    }

    @Test
    void updateUser() {
    }

    @Test
    void getFile() {
    }

    @Test
    void downloadFile() {
    }

    @Test
    void uploadFile() {
    }
}