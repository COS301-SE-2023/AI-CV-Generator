package com.revolvingSolutions.aicvgeneratorbackend.intergrationTests;

import com.revolvingSolutions.aicvgeneratorbackend.controller.UserController;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.FileEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.ProfileImageEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.file.FileModel;
import com.revolvingSolutions.aicvgeneratorbackend.model.file.FileModelForList;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Employment;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Qualification;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.User;
import com.revolvingSolutions.aicvgeneratorbackend.repository.*;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.AddEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.RemoveEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.UpdateEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.AddQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.file.DownloadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.user.UpdateUserRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.Code;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.employment.AddEmploymentResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.employment.RemoveEmploymentResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.employment.UpdateEmploymentResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.qualification.AddQualificationResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.file.GetFilesResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.file.UploadFileResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.user.GetUserResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.user.UpdateUserResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.UUIDGenerator;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import jakarta.activation.MimeType;
import jdk.jfr.ContentType;
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
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import java.io.IOException;
import java.time.Instant;
import java.util.*;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

@DataJpaTest
public class UserIntergrationTests {

    // These are essentially integration tests between the backend and the front end
    private UserController userController;
    private UserService userService;

    private UUIDGenerator generator;
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
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
        User user = Objects.requireNonNull(response.getBody()).getUser();
        assertThat(user.getUsername().matches("Nate")).isTrue();
        assertThat(user.getFname().matches("Nathan")).isTrue();
        assertThat(user.getLname().matches("Opperman")).isTrue();
        assertThat(user.getEmail().matches("u21553832@tuks.co.za")).isTrue();
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
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
        User user = Objects.requireNonNull(response.getBody()).getUser();

        // Check to see if unchanged fields are the same
        assertThat(user.getUsername().matches("Nate")).isTrue();
        assertThat(user.getFname().matches("Nathan")).isTrue();
        assertThat(user.getLname().matches("Opperman")).isTrue();
        assertThat(user.getEmail().matches("u21553832@tuks.co.za")).isTrue();

        // Check if changed fields are correct
        assertThat(user.getDescription().matches("Added Description Change 1")).isTrue();
        assertThat(user.getPhoneNumber().matches("0762268391")).isTrue();
        assertThat(user.getLocation().matches("My General Location")).isTrue();

        // Check if database is correct

        // Through getUser
        User user2 = Objects.requireNonNull(userController.getUser().getBody()).getUser();
        assertThat(user2.getFname().matches(user.getFname())).isTrue();
        assertThat(user2.getLname().matches(user.getLname())).isTrue();
        assertThat(user2.getEmail().matches(user.getEmail())).isTrue();
        assertThat(user2.getDescription().matches(user.getDescription())).isTrue();
        assertThat(user2.getLocation().matches(user.getLocation())).isTrue();
        assertThat(user2.getPhoneNumber().matches(user.getPhoneNumber())).isTrue();

        // Through direct
        UserEntity userEntity = userRepository.findByUsername("Nate").orElseThrow();

        assertThat(userEntity.getUsername().matches(user.getUsername())).isTrue();
        assertThat(userEntity.getFname().matches(user.getFname())).isTrue();
        assertThat(userEntity.getLname().matches(user.getLname())).isTrue();
        assertThat(userEntity.getEmail().matches(user.getEmail())).isTrue();

        assertThat(userEntity.getDescription().matches(user.getDescription())).isTrue();
        assertThat(userEntity.getLocation().matches(user.getLocation())).isTrue();
        assertThat(userEntity.getPhoneNumber().matches(user.getPhoneNumber())).isTrue();
    }
    @Test
    void getProfileImageIntegrationTest() throws IOException {
        // given
        // This is because OID types are not supported by H2 database
        // So this interaction between the IN MEMORY DB is mocked
        ProfileImageEntity profileImage = ProfileImageEntity.builder()
                        .type("image/png")
                        .imgdata((byte[]) null)
                        .build();
        Mockito.when(profileImageRepository.findByUser(originUser)).thenReturn(Optional.of(profileImage));

        // when
        ResponseEntity<Resource> response = userController.getProfileImage();
        // then
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(404))).isTrue();

        // Is null since byte data was null
        assertThat(response.getBody() == null).isTrue();
    }

    @Test
    void updateProfileImageIntegrationTest() {
        // given
        MockMultipartFile file = new MockMultipartFile("Profile Image","Filename","image/png",(byte[]) null);
        // This is because OID types are not supported by H2 database
        // So this interaction between the IN MEMORY DB is mocked
        ProfileImageEntity profileImage = ProfileImageEntity.builder()
                .type(".png")
                .imgdata((byte[]) null)
                .build();
        Mockito.when(profileImageRepository.findByUser(originUser)).thenReturn(Optional.of(profileImage));
        // when
        ResponseEntity<Resource> response = userService.updateProfileImage(file);

        // then
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
    }

    @Test
    void uploadFileIntegrationTest() {
        // given
        MockMultipartFile file = new MockMultipartFile("Filename",(byte[]) null);
        MockMultipartFile cover = new MockMultipartFile("FileCoverName",(byte[]) null);
        // when
        ResponseEntity<UploadFileResponse> response = userController.uploadFile(file,cover);
        // then

        ArgumentCaptor<FileEntity> fileEntity = ArgumentCaptor.forClass(FileEntity.class);
        verify(fileRepository).save(fileEntity.capture());

        assertThat(fileEntity.getValue().getUser().getUsername().matches(originUser.getUsername())).isTrue();
        assertThat(fileEntity.getValue().getData() != null).isTrue();
        assertThat(fileEntity.getValue().getCover() != null).isTrue();
        assertThat(fileEntity.getValue().getFilename() != null).isTrue();

        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
        assertThat(Objects.requireNonNull(Objects.requireNonNull(response.getBody()).getCode()) ==Code.success ).isTrue();
    }

    @Test
    void downloadFileIntegrationTestFileFound() {
        // given
        byte[] fakes = HexFormat.of().parseHex("e04fd020ea3a6910a2d808002b30309d");
        DownloadFileRequest request = DownloadFileRequest.builder()
                .filename("Filename")
                .build();
        Mockito.when(fileRepository.getFileFromUser(originUser.getUsername(),"Filename")).thenReturn(
                List.of(
                        FileModel.builder()
                                .data(fakes)
                                .cover(fakes)
                                .filename("Filename")
                                .filetype("application/pdf")
                                .build()
                )
        );
        // when
        ResponseEntity<Resource> response = userController.downloadFile(request);
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
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

    @Test
    void getFilesIntegrationTest() {
        // given
        byte[] fakes = HexFormat.of().parseHex("e04fd020ea3a6910a2d808002b30309d");
        Mockito.when(fileRepository.getFilesFromUser(originUser.getUsername())).thenReturn(
                List.of(
                        FileModelForList.builder()
                                .filename("Filename1")
                                .cover(fakes)
                                .build(),
                        FileModelForList.builder()
                                .filename("Filename2")
                                .cover(fakes)
                                .build()
                )
        );
        // when
        ResponseEntity<GetFilesResponse> response = userController.getFiles();
        // then
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
        assertThat(Objects.requireNonNull(response.getBody()).getFiles().size() == 2).isTrue();
        assertThat(response.getBody().getFiles().get(0).getFilename().matches("Filename1")).isTrue();
        assertThat(response.getBody().getFiles().get(0).getCover().matches(Base64.getEncoder().encodeToString(fakes))).isTrue();
        assertThat(response.getBody().getFiles().get(1).getFilename().matches("Filename2")).isTrue();
        assertThat(response.getBody().getFiles().get(1).getCover().matches(Base64.getEncoder().encodeToString(fakes))).isTrue();
    }

    @Test
    void addEmploymentIntegrationTest() {
        // given
        Date date1 = Date.from(Instant.now());
        AddEmploymentRequest req = AddEmploymentRequest.builder()
                .employment(
                        Employment.builder()
                                .title("Job Title")
                                .company("Company")
                                .startdate(date1)
                                .enddate(date1)
                                .build()
                )
                .build();
        // when
        ResponseEntity<AddEmploymentResponse> response = userController.addEmp(req);

        // verify that it is in the database
        List<Employment> emplList = employmentRepository.getEmploymentHistoryFromUser(originUser.getUsername());
        assertThat(response.getBody().getEmployees().equals(emplList)).isTrue();

        Date date2 = Date.from(Instant.now());
        req = AddEmploymentRequest.builder()
                .employment(
                        Employment.builder()
                                .title("Job Title2")
                                .company("Company2")
                                .startdate(date1)
                                .enddate(date1)
                                .build()
                )
                .build();
        // confirm addition of the second
        // when
        response = userController.addEmp(req);
        // then
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
        assertThat(Objects.requireNonNull(response.getBody()).getEmployees().size() == 2).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getTitle().matches("Job Title")).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getCompany().matches("Company")).isTrue();
        assertThat(response.getBody().getEmployees().get(1).getTitle().matches("Job Title2")).isTrue();
        assertThat(response.getBody().getEmployees().get(1).getCompany().matches("Company2")).isTrue();
    }

    @Test
    void removeEmploymentIntegrationTest() {
        // given
        // First Add Employment 1 and 2
        Date date1 = Date.from(Instant.now());
        AddEmploymentRequest req = AddEmploymentRequest.builder()
                .employment(
                        Employment.builder()
                                .title("Job Title")
                                .company("Company")
                                .startdate(date1)
                                .enddate(date1)
                                .build()
                )
                .build();
        ResponseEntity<AddEmploymentResponse> response = userController.addEmp(req);
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
        assertThat(Objects.requireNonNull(response.getBody()).getEmployees().size() == 1).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getTitle().matches("Job Title")).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getCompany().matches("Company")).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getStartdate() != null).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getEnddate() != null).isTrue();

        // verify that it is in the database
        List<Employment> emplList = employmentRepository.getEmploymentHistoryFromUser(originUser.getUsername());
        assertThat(response.getBody().getEmployees().equals(emplList)).isTrue();

        Date date2 = Date.from(Instant.now());
        req = AddEmploymentRequest.builder()
                .employment(
                        Employment.builder()
                                .title("Job Title2")
                                .company("Company2")
                                .startdate(date1)
                                .enddate(date1)
                                .build()
                )
                .build();
        // confirm addition of the second
        response = userController.addEmp(req);
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
        assertThat(Objects.requireNonNull(response.getBody()).getEmployees().size() == 2).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getTitle().matches("Job Title")).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getCompany().matches("Company")).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getStartdate() != null).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getEnddate() != null).isTrue();
        assertThat(response.getBody().getEmployees().get(1).getTitle().matches("Job Title2")).isTrue();
        assertThat(response.getBody().getEmployees().get(1).getCompany().matches("Company2")).isTrue();
        assertThat(response.getBody().getEmployees().get(1).getStartdate() != null).isTrue();
        assertThat(response.getBody().getEmployees().get(1).getEnddate() != null).isTrue();

        RemoveEmploymentRequest remReq = RemoveEmploymentRequest.builder()
                .employment(
                        emplList.get(0)
                )
                .build();
        // when
        ResponseEntity<RemoveEmploymentResponse> remResponse = userController.removeEmp(remReq);
        // then
        assertThat(remResponse.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
        assertThat(Objects.requireNonNull(remResponse.getBody()).getEmployees().size() == 1).isTrue();
        assertThat(remResponse.getBody().getEmployees().get(0).equals(response.getBody().getEmployees().get(1))).isTrue();

        // verify database contains only the one employee
        emplList = employmentRepository.getEmploymentHistoryFromUser(originUser.getUsername());
        assertThat(emplList.size() == 1).isTrue();
        assertThat(emplList.get(0).equals(remResponse.getBody().getEmployees().get(0))).isTrue();
    }

    @Test
    void updateEmploymentIntegrationTest() {
        // given
        // First Add Employment 1 and 2
        Date date1 = Date.from(Instant.now());
        AddEmploymentRequest req = AddEmploymentRequest.builder()
                .employment(
                        Employment.builder()
                                .title("Job Title")
                                .company("Company")
                                .startdate(date1)
                                .enddate(date1)
                                .build()
                )
                .build();
        ResponseEntity<AddEmploymentResponse> response = userController.addEmp(req);
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
        assertThat(Objects.requireNonNull(response.getBody()).getEmployees().size() == 1).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getTitle().matches("Job Title")).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getCompany().matches("Company")).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getStartdate() != null).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getEnddate() != null).isTrue();

        // verify that it is in the database
        List<Employment> emplList = employmentRepository.getEmploymentHistoryFromUser(originUser.getUsername());
        assertThat(response.getBody().getEmployees().equals(emplList)).isTrue();

        Date date2 = Date.from(Instant.now());
        req = AddEmploymentRequest.builder()
                .employment(
                        Employment.builder()
                                .title("Job Title2")
                                .company("Company2")
                                .startdate(date1)
                                .enddate(date1)
                                .build()
                )
                .build();
        // confirm addition of the second
        response = userController.addEmp(req);
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
        assertThat(Objects.requireNonNull(response.getBody()).getEmployees().size() == 2).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getTitle().matches("Job Title")).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getCompany().matches("Company")).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getStartdate()!= null).isTrue();
        assertThat(response.getBody().getEmployees().get(0).getEnddate() != null).isTrue();
        assertThat(response.getBody().getEmployees().get(1).getTitle().matches("Job Title2")).isTrue();
        assertThat(response.getBody().getEmployees().get(1).getCompany().matches("Company2")).isTrue();
        assertThat(response.getBody().getEmployees().get(1).getStartdate() != null).isTrue();
        assertThat(response.getBody().getEmployees().get(1).getEnddate() != null).isTrue();

        Employment tobeChanged = response.getBody().getEmployees().get(0);
        tobeChanged.setCompany("Updated Company");
        tobeChanged.setTitle("Updated Title");
        Date updatedDate = Date.from(Instant.now());
        tobeChanged.setStartdate(updatedDate);
        UpdateEmploymentRequest updateReq = UpdateEmploymentRequest.builder()
                .employment(
                        tobeChanged
                )
                .build();
        // when
        ResponseEntity<UpdateEmploymentResponse> updateResponse = userController.updateEmployment(updateReq);

        // then
        assertThat(updateResponse.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200)));

        // check that it is reflected in the database
        List<Employment> employments = employmentRepository.getEmploymentHistoryFromUser(originUser.getUsername());

        assertThat(employments.size() == 2).isTrue();
    }

    @Test
    void addQualificationIntegrationTest() {
        // given
        Date date1 = Date.from(Instant.now());
        AddQualificationRequest req = AddQualificationRequest.builder()
                .qualification(
                        Qualification.builder()
                                .date(date1)
                                .endo(date1)
                                .qualification("Qualification")
                                .intstitution("Instatution")
                                .build()
                )
                .build();
        // when
        ResponseEntity<AddQualificationResponse> response = userController.addQualification(req);

        // then
        assertThat(response.getStatusCode().isSameCodeAs(HttpStatusCode.valueOf(200))).isTrue();
        assertThat(Objects.requireNonNull(response.getBody()).getQualifications().size() == 1).isTrue();
        assertThat(response.getBody().getQualifications().get(0).getQualification().matches("Qualification")).isTrue();
        assertThat(response.getBody().getQualifications().get(0).getIntstitution().matches("Instatution")).isTrue();
    }


}
