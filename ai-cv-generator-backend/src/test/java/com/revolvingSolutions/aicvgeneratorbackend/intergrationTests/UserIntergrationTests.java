package com.revolvingSolutions.aicvgeneratorbackend.intergrationTests;

import com.revolvingSolutions.aicvgeneratorbackend.controller.UserController;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.User;
import com.revolvingSolutions.aicvgeneratorbackend.repository.*;
import com.revolvingSolutions.aicvgeneratorbackend.request.user.UpdateUserRequest;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Objects;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

@DataJpaTest
public class UserIntergrationTests {
    private UserController userController;
    private UserService userService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private EmploymentRepository employmentRepository;
    @Autowired
    private QualificationRepository qualificationRepository;
    @Autowired
    private LinkRepository linkRepository;
    @Autowired
    private ReferenceRepository referenceRepository;
    @Autowired
    private SkillRepository skillRepository;

    @Mock
    private FileRepository fileRepository;

    @Mock
    private ShareRepository shareRepository;

    @Mock
    private ProfileImageRepository profileImageRepository;

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
        userController = new UserController(
                userService
        );
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
        userRepository.saveAndFlush(user);
    }

    @AfterEach
    void tearDown() throws Exception {
        closeable.close();
    }

    @Test
    void getUserIntegrationTest() {
        // when
        User user_ = Objects.requireNonNull(userController.getUser().getBody()).getUser();
        assertThat(user_.getUsername().matches("Nate"));
        assertThat(user_.getFname().matches("Nathan"));
        assertThat(user_.getLname().matches("Opperman"));
        assertThat(user_.getEmail().matches("u21553832@tuks.co.za"));
    }

    @Test
    void updateUserIntegrationTest() {
        // given
        UpdateUserRequest req = UpdateUserRequest.builder()
                .user(
                        User.builder()
                            .username("Nate")
                            .fname("Nathan")
                            .lname("Opperman")
                            .email("u21553832@tuks.co.za")
                            .description("Added Description Change 1") //Change Number 1
                            .phoneNumber("0762268391")                 //Change Number 2
                            .location("My General Location")           //Change Number 3
                            .build()
                )
                .build();
        // when
        User user = Objects.requireNonNull(userController.updateUser(req).getBody()).getUser();

        // Check to see if unchanged fields are the same
        assertThat(user.getUsername().matches("Nate"));
        assertThat(user.getFname().matches("Nathan"));
        assertThat(user.getLname().matches("Opperman"));
        assertThat(user.getEmail().matches("u21553832@tuks.co.za"));

        // Check if changed fields are correct
        assertThat(user.getDescription().matches("Added Description Change 1"));
        assertThat(user.getPhoneNumber().matches("0762268391"));
        assertThat(user.getLocation().matches("My General Location"));

        // Check if database is correct

        // Through getUser
        assertThat(userController.getUser().equals(user));

        // Through direct
        UserEntity userEntity = userRepository.findByUsername("Nate").orElseThrow();

        assertThat(userEntity.getUsername().matches(user.getUsername()));
        assertThat(userEntity.getFname().matches(user.getFname()));
        assertThat(userEntity.getLname().matches(user.getLname()));
        assertThat(userEntity.getEmail().matches(user.getEmail()));

        assertThat(userEntity.getDescription().matches(user.getDescription()));
        assertThat(userEntity.getLocation().matches(user.getLocation()));
        assertThat(userEntity.getPhoneNumber().matches(user.getPhoneNumber()));
    }

}
