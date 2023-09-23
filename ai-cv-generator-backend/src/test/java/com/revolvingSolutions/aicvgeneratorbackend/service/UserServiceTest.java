package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.*;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Employment;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Link;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Qualification;
import com.revolvingSolutions.aicvgeneratorbackend.repository.*;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.AddEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.AddLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.AddQualificationRequest;
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

import java.time.Instant;
import java.util.Date;
import java.util.Optional;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.mockito.Mockito.*;

class UserServiceTest {

    private UserService userService;

    private UUIDGenerator generator;

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
        generator = new UUIDGenerator();
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
                generator,
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
        // given
        AddEmploymentRequest req = AddEmploymentRequest.builder()
                .employment(
                        Employment.builder()
                                .title("Title")
                                .startdate(Date.from(Instant.now()))
                                .enddate(Date.from(Instant.now()))
                                .company("Company")
                                .build()
                )
                .build();
        Authentication authentication = mock(Authentication.class);
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
        userService.addEmployment(req);
        // then
        ArgumentCaptor<EmploymentEntity> employmentEntity = ArgumentCaptor.forClass(EmploymentEntity.class);
        verify(employmentRepository).saveAndFlush(employmentEntity.capture());
        assertThat(employmentEntity.getValue().getUser() == user);
        assertThat(employmentEntity.getValue().getCompany().matches(req.getEmployment().getCompany()));
        assertThat(employmentEntity.getValue().getTitle().matches(req.getEmployment().getTitle()));
        assertThat(employmentEntity.getValue().getStartdate().equals(req.getEmployment().getStartdate()));
        assertThat(employmentEntity.getValue().getEnddate().equals(req.getEmployment().getEnddate()));
    }

    @Test
    void addQualification() {
        // given
        AddQualificationRequest req = AddQualificationRequest.builder()
                .qualification(
                        Qualification.builder()
                                .qualification("Qualification")
                                .intstitution("Institution")
                                .endo(Date.from(Instant.now()))
                                .date(Date.from(Instant.now()))
                                .build()
                )
                .build();
        Authentication authentication = mock(Authentication.class);
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
        userService.addQualification(req);
        // then
        ArgumentCaptor<QualificationEntity> qualificationEntity = ArgumentCaptor.forClass(QualificationEntity.class);
        verify(qualificationRepository).saveAndFlush(qualificationEntity.capture());
        assertThat(qualificationEntity.getValue().getQualification().matches(req.getQualification().getQualification()));
        assertThat(qualificationEntity.getValue().getUser().equals(user));
        assertThat(qualificationEntity.getValue().getIntstitution().matches(req.getQualification().getIntstitution()));
        assertThat(qualificationEntity.getValue().getEndo().equals(req.getQualification().getEndo()));
        assertThat(qualificationEntity.getValue().getDate().equals(req.getQualification().getEndo()));
    }

    @Test
    void addLink() {
        // given
        AddLinkRequest req = AddLinkRequest.builder()
                .link(
                        Link.builder()
                                .url("Url")
                                .build()
                )
                .build();
        Authentication authentication = mock(Authentication.class);
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
        userService.addLink(req);
        // then
        ArgumentCaptor<LinkEntity> linkEntity = ArgumentCaptor.forClass(LinkEntity.class);
        verify(linkRepository).saveAndFlush(linkEntity.capture());
        assertThat(linkEntity.getValue().getUser().equals(user));
        assertThat(linkEntity.getValue().getUrl().matches(req.getLink().getUrl()));
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