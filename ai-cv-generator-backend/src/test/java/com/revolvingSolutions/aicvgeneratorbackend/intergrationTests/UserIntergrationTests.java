package com.revolvingSolutions.aicvgeneratorbackend.intergrationTests;

import com.revolvingSolutions.aicvgeneratorbackend.controller.UserController;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.FileEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.ProfileImageEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.file.FileModel;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.User;
import com.revolvingSolutions.aicvgeneratorbackend.repository.*;
import com.revolvingSolutions.aicvgeneratorbackend.request.file.DownloadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.profileImage.UpdateProfileImageRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.user.UpdateUserRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.user.GetUserResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.user.UpdateUserResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.mockito.exceptions.base.MockitoException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

@DataJpaTest
public class UserIntergrationTests {

    // These are essentially integration tests between the backend and the front end
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

    private UserEntity originUser;

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

        originUser = UserEntity.builder()
                .username("Nate")
                .fname("Nathan")
                .lname("Opperman")
                .email("u21553832@tuks.co.za")
                .role(Role.USER)
                .password("password")
                .build();

        Mockito.when(authentication.getName()).thenReturn("Nate");
        userRepository.saveAndFlush(originUser);
    }

    @AfterEach
    void tearDown() throws Exception {
        // close mocks
        closeable.close();
        // clear repositories that are not mocked
        userRepository.deleteAll();
        employmentRepository.deleteAll();
        qualificationRepository.deleteAll();
        linkRepository.deleteAll();
        referenceRepository.deleteAll();
        skillRepository.deleteAll();
        shareRepository.deleteAll();
    }

    @Test
    void getUserIntegrationTest() {
        // when
        ResponseEntity<GetUserResponse> response = userController.getUser();

        // then
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200)));
        User user = Objects.requireNonNull(response.getBody()).getUser();
        assertThat(user.getUsername().matches("Nate"));
        assertThat(user.getFname().matches("Nathan"));
        assertThat(user.getLname().matches("Opperman"));
        assertThat(user.getEmail().matches("u21553832@tuks.co.za"));
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
        ResponseEntity<UpdateUserResponse> response = userController.updateUser(req);

        // then
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200)));
        User user = Objects.requireNonNull(response.getBody()).getUser();

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
        assertThat(Objects.requireNonNull(userController.getUser().getBody()).getUser().equals(user));

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
    @Test
    void getProfileImageIntegrationTest() throws IOException {
        // given
        // This is because OID types are not supported by H2 database
        // So this interaction between the IN MEMORY DB is mocked
        ProfileImageEntity profileImage = ProfileImageEntity.builder()
                        .type("png")
                        .imgdata((byte[]) null)
                        .build();
        Mockito.when(profileImageRepository.findByUser(any())).thenReturn(Optional.of(profileImage));

        // when
        ResponseEntity<Resource> response = userController.getProfileImage();
        // then
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200)));

        // Is null since byte data was null
        assertThat(response.getBody() == null);
    }

    @Test
    void updateProfileImageIntegrationTest() {
        // given
        MockMultipartFile file = new MockMultipartFile("Profile Image",(byte[]) null);
        // This is because OID types are not supported by H2 database
        // So this interaction between the IN MEMORY DB is mocked
        ProfileImageEntity profileImage = ProfileImageEntity.builder()
                .type("png")
                .imgdata((byte[]) null)
                .build();
        Mockito.when(profileImageRepository.findByUser(any())).thenReturn(Optional.of(profileImage));
        // when
        ResponseEntity<Resource> response = userService.updateProfileImage(file);

        // then
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200)));
    }

    @Test
    void uploadFileIntegrationTest() {
        // given
        MockMultipartFile file = new MockMultipartFile("Filename",(byte[]) null);
        MockMultipartFile cover = new MockMultipartFile("FileCoverName",(byte[]) null);
        // when
        ResponseEntity<String> response = userController.uploadFile(file,cover);
        // then

        ArgumentCaptor<FileEntity> fileEntity = ArgumentCaptor.forClass(FileEntity.class);
        verify(fileRepository).save(fileEntity.capture());

        assertThat(fileEntity.getValue().getUser().equals(originUser));
        assertThat(fileEntity.getValue().getData() == null);
        assertThat(fileEntity.getValue().getCover() == null);
        assertThat(fileEntity.getValue().getFilename().matches(file.getName()));

        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200)));
        assertThat(Objects.requireNonNull(response.getBody()).matches("Success"));
    }

    @Test
    void downloadFileIntegrationTestFileFound() {
        // given
        DownloadFileRequest request = DownloadFileRequest.builder()
                .filename("Filename")
                .build();
        Mockito.when(fileRepository.getFileFromUser(originUser.getUsername(),"Filename")).thenReturn(
                List.of(
                        FileModel.builder()
                                .data((byte[]) null)
                                .cover((byte[]) null)
                                .filename("Filename")
                                .filetype("Pdf")
                                .build()
                )
        );
        // when
        ResponseEntity<Resource> response = userController.downloadFile(request);
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200)));
    }

    @Test
    void downloadFileIntegrationTestFileNotFound() {
        // given
        DownloadFileRequest request = DownloadFileRequest.builder()
                .filename("Filename")
                .build();
        Mockito.when(fileRepository.getFileFromUser(originUser.getUsername(),"Filename")).thenThrow(new MockitoException("Failed"));
        // when
        ResponseEntity<Resource> response = userController.downloadFile(request);
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(404)));
    }
}
