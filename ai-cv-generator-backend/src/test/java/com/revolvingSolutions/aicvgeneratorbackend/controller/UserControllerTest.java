package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.model.user.*;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.AddEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.RemoveEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.UpdateEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.AddLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.RemoveLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.UpdateLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.AddQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.RemoveQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.UpdateQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.reference.AddReferenceRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.reference.RemoveReferenceRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.reference.UpdateReferenceRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.skill.AddSkillRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.skill.RemoveSkillRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.skill.UpdateSkillRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.file.DownloadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.user.UpdateUserRequest;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import java.time.Instant;
import java.util.Date;

import static org.mockito.Mockito.verify;

class UserControllerTest {

    private UserController userController;

    @Mock
    private UserService userService;
    AutoCloseable closeable;

    @BeforeEach
    void setUp() {
        closeable = MockitoAnnotations.openMocks(this);
        userController = new UserController(userService);
    }

    @AfterEach
    void tearDown() throws Exception {
        closeable.close();
    }

    @Test
    void getUser() {
        // when
        userController.getUser();
        // then
        verify(userService).getUser();
    }

    @Test
    void updateUser() {
        // given
        UpdateUserRequest req = UpdateUserRequest.builder()
                .user(
                        User.builder()
                                .username("Username")
                                .phoneNumber("0765554488")
                                .email("myemail@St")
                                .fname("Nate")
                                .lname("Opp")
                                .build()
                )
                .build();
        // when
        userController.updateUser(
                req
        );
        // then
        verify(userService).updateUser(req);
    }

    @Test
    void getProfileImage() {
        // when
        userController.getProfileImage();
        // then
        verify(userService).getProfileImage();
    }

    @Test
    void updateProfileImage() {
        // given
        MultipartFile img = new MockMultipartFile("img", (byte[]) null);
        // when
        userController.updateProfileImage(img);
        // then
        verify(userService).updateProfileImage(img);
    }

    @Test
    void uploadFile() {
        // given
        MultipartFile file = new MockMultipartFile("File", (byte[]) null);
        MultipartFile cover = new MockMultipartFile("File", (byte[]) null);
        // when
        userController.uploadFile(file,cover);
        // then
        verify(userService).uploadFile(file,cover);
    }

    @Test
    void downloadFile() {
        // given
        DownloadFileRequest req = DownloadFileRequest.builder()
                .filename("File")
                .build();
        // when
        userController.downloadFile(req);
        // then
        verify(userService).downloadFile(req);
    }

    @Test
    void getFiles() {
        // when
        userController.getFiles();
        // then
        verify(userService).getFiles();
    }

    @Test
    void addEmp() {
        // given
        AddEmploymentRequest req = AddEmploymentRequest.builder()
                .employment(
                        Employment.builder()
                                .title("title")
                                .company("company")
                                .startdate(Date.from(Instant.now()))
                                .enddate(Date.from(Instant.now()))
                                .build()
                )
                .build();
        // when
        userController.addEmp(req);
        // then
        verify(userService).addEmployment(req);
    }

    @Test
    void removeEmp() {
        // given
        RemoveEmploymentRequest req = RemoveEmploymentRequest.builder()
                .employment(
                        Employment.builder()
                                .title("title")
                                .company("company")
                                .startdate(Date.from(Instant.now()))
                                .enddate(Date.from(Instant.now()))
                                .build()
                )
                .build();
        // when
        userController.removeEmp(req);
        // then
        verify(userService).removeEmployment(req);
    }

    @Test
    void updateEmployment() {
        // given
        UpdateEmploymentRequest req = UpdateEmploymentRequest.builder()
                .employment(
                        Employment.builder()
                                .title("title")
                                .company("company")
                                .startdate(Date.from(Instant.now()))
                                .enddate(Date.from(Instant.now()))
                                .build()
                )
                .build();
        // when
        userController.updateEmployment(req);
        // then
        verify(userService).updateEmployment_(req);
    }

    @Test
    void addQualification() {
        // given
        AddQualificationRequest req = AddQualificationRequest.builder()
                .qualification(
                        Qualification.builder()
                                .qualification("qualification")
                                .intstitution("intitution")
                                .date(Date.from(Instant.now()))
                                .build()
                )
                .build();
        // when
        userController.addQualification(req);
        // then
        verify(userService).addQualification(req);
    }

    @Test
    void removeQualification() {
        // given
        RemoveQualificationRequest req = RemoveQualificationRequest.builder()
                .qualification(
                        Qualification.builder()
                                .qualification("qualification")
                                .intstitution("intitution")
                                .date(Date.from(Instant.now()))
                                .build()
                )
                .build();
        // when
        userController.removeQualification(req);
        // then
        verify(userService).removeQualification(req);
    }

    @Test
    void updateQualification() {
        // given
        UpdateQualificationRequest req = UpdateQualificationRequest.builder()
                .qualification(
                        Qualification.builder()
                                .qualification("qualification")
                                .intstitution("intitution")
                                .date(Date.from(Instant.now()))
                                .build()
                )
                .build();
        // when
        userController.updateQualification(req);
        // then
        verify(userService).updateQualification_(req);
    }

    @Test
    void addLink() {
        // given
        AddLinkRequest req = AddLinkRequest.builder()
                .link(
                        Link.builder()
                                .url("url")
                                .build()
                )
                .build();
        // when
        userController.addLink(req);
        // then
        verify(userService).addLink(req);
    }

    @Test
    void removeLink() {
        // given
        RemoveLinkRequest req = RemoveLinkRequest.builder()
                .link(
                        Link.builder()
                                .url("url")
                                .build()
                )
                .build();
        // when
        userController.removeLink(req);
        // then
        verify(userService).removeLink(req);
    }

    @Test
    void updateLink() {
        // given
        UpdateLinkRequest req = UpdateLinkRequest.builder()
                .link(
                        Link.builder()
                                .url("url")
                                .build()
                )
                .build();
        // when
        userController.updateLink(req);
        // then
        verify(userService).updateLink_(req);
    }

    @Test
    void addReference() {
        // given
        AddReferenceRequest req = AddReferenceRequest.builder()
                .reference(
                        Reference.builder()
                                .description("Reference Description!")
                                .contact("Contact Details!")
                                .build()
                )
                .build();
        // when
        userController.addReference(req);
        // then
        verify(userService).addReference(req);
    }

    @Test
    void removeReference() {
        // given
        RemoveReferenceRequest req = RemoveReferenceRequest.builder()
                .reference(
                        Reference.builder()
                                .description("Reference Description!")
                                .contact("Contact Details!")
                                .build()
                )
                .build();
        // when
        userController.removeReference(req);
        // then
        verify(userService).removeReference(req);
    }

    @Test
    void updateReference() {
        // given
        UpdateReferenceRequest req = UpdateReferenceRequest.builder()
                .reference(
                        Reference.builder()
                                .description("Reference Description!")
                                .contact("Contact Details!")
                                .build()
                )
                .build();
        // when
        userController.updateReference(req);
        // then
        verify(userService).updateReference_(req);
    }

    @Test
    void addSkill() {
        // given
        AddSkillRequest req = AddSkillRequest.builder()
                .skill(
                        Skill.builder()
                                .skill("This is the Skill description")
                                .level(2)
                                .reason("This is the reason")
                                .build()
                )
                .build();
        // when
        userController.addSkill(req);
        // then
        verify(userService).addSkill(req);
    }

    @Test
    void removeSkill() {
        // given
        RemoveSkillRequest req = RemoveSkillRequest.builder()
                .skill(
                        Skill.builder()
                                .skill("This is the Skill description")
                                .level(2)
                                .reason("This is the reason")
                                .build()
                )
                .build();
        // when
        userController.removeSkill(req);
        // then
        verify(userService).removeSkill(req);
    }

    @Test
    void updateSkill() {
        // given
        UpdateSkillRequest req = UpdateSkillRequest.builder()
                .skill(
                        Skill.builder()
                                .skill("This is the Skill description")
                                .level(2)
                                .reason("This is the reason")
                                .build()
                )
                .build();
        // when
        userController.updateSkill(req);
        // then
        verify(userService).updateSkill_(req);
    }
}