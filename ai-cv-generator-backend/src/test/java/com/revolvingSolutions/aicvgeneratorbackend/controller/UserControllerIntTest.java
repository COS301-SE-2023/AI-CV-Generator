package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.conf.AuthFilter;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import java.time.Instant;
import java.util.Date;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.multipart;

@ExtendWith(SpringExtension.class)
@WebMvcTest(UserController.class)
public class UserControllerIntTest {
    @Autowired
    private MockMvc mockMvc;
    @Autowired
    private WebApplicationContext webApplicationContext;
    @MockBean
    private UserService service;

    @MockBean
    private AuthFilter authFilter;

    @BeforeEach
    public void setup()
    {
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    void getUser() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .get("/api/User/user")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus()==200).isTrue();
    }

    @Test
    void updateUser() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/User/user")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n" +
                        "    \"user\": {\n" +
                        "        \"fname\": \"Nathan\",\n" +
                        "        \"lname\": \"Opperman\",\n" +
                        "        \"username\": \"Chris\",\n" +
                        "        \"email\": null,\n" +
                        "        \"phoneNumber\": \"0762268391\",\n" +
                        "        \"location\": null,\n" +
                        "        \"description\": \"HelloWorld\",\n" +
                        "        \"cvfilePath\": null,\n" +
                        "        \"cv\": null,\n" +
                        "        \"success\": false\n" +
                        "    }\n" +
                        "}"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus()==200).isTrue();
    }

    @Test
    void getProfileImg() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .get("/api/User/profimg")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void updateProfileImg() throws Exception {
        MockMultipartFile img = new MockMultipartFile("img",(byte[])null);
        MvcResult result = mockMvc.perform(multipart("/api/User/updateprofimg").file(img)).andReturn();
        assertThat(result.getResponse().getStatus()==200).isTrue();
    }

    @Test
    void uploadFile() throws Exception {
        MockMultipartFile file = new MockMultipartFile("file",(byte[]) null);
        MockMultipartFile cover = new MockMultipartFile("cover",(byte[]) null);
        MvcResult result = mockMvc.perform(multipart("/api/User/file").file(file).file(cover)).andReturn();
        assertThat(result.getResponse().getStatus()==200).isTrue();
    }

    @Test
    @Disabled
    void uploadFileAndShare() throws Exception {
        MockMultipartFile file = new MockMultipartFile("file",(byte[]) null);
        Date date = Date.from(Instant.now());
        String base = "base";
        MvcResult result = mockMvc.perform(multipart("/api/User/shareFile").file(file).content(base).content(date.toString())).andReturn();
        assertThat(result.getResponse().getStatus()==200).isTrue();
    }

    @Test
    void downloadfile() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/User/retfile")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n" +
                        "    \"filename\":\"344ex.pdf\"\n" +
                        "}"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void getFiles() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .get("/api/User/files")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200);
    }

    @Test
    void addEmp() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/User/addEmp")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n" +
                        "    \"employment\":{\n" +
                        "        \"title\":\"System Designer\",\n" +
                        "        \"company\":\"Telcom\",\n" +
                        "        \"startdate\":\"2012-04-23T18:25:43.511Z\",\n" +
                        "        \"enddate\":\"2012-04-23T18:25:43.511Z\"\n" +
                        "    }\n" +
                        "}"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void removeEmp() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/User/remEmp")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n" +
                        "    \"employment\":{\n" +
                        "        \"title\":\"System Designer\",\n" +
                        "        \"company\":\"Telcom\",\n" +
                        "        \"startdate\":\"2012-04-23T18:25:43.511Z\",\n" +
                        "        \"enddate\":\"2012-04-23T18:25:43.511Z\"\n" +
                        "    }\n" +
                        "}"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void updateEmployment() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/User/updateEmp")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n" +
                        "    \"employment\":{\n" +
                        "        \"title\":\"System Designer\",\n" +
                        "        \"company\":\"Telcom\",\n" +
                        "        \"startdate\":\"2012-04-23T18:25:43.511Z\",\n" +
                        "        \"enddate\":\"2012-04-23T18:25:43.511Z\"\n" +
                        "    }\n" +
                        "}"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void addQualification() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/User/addQua")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n" +
                        "    \"qualification\":{\n" +
                        "        \"quaid\":1,\n" +
                        "        \"qualification\":\"kkkk\",\n" +
                        "        \"intstitution\":\"int\",\n" +
                        "        \"date\":\"2012-04-23T18:25:43.511Z\",\n" +
                        "        \"endo\":\"2012-04-23T18:25:43.511Z\"\n" +
                        "    }\n" +
                        "}"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void removeQualification() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/User/remQua")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n" +
                        "    \"qualification\":{\n" +
                        "        \"quaid\":1,\n" +
                        "        \"qualification\":\"kkkk\",\n" +
                        "        \"intstitution\":\"int\",\n" +
                        "        \"date\":\"2012-04-23T18:25:43.511Z\",\n" +
                        "        \"endo\":\"2012-04-23T18:25:43.511Z\"\n" +
                        "    }\n" +
                        "}"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void updateQualification() throws Exception {
        RequestBuilder request =MockMvcRequestBuilders
                .post("/api/User/updateQua")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n" +
                        "    \"qualification\":{\n" +
                        "        \"quaid\":1,\n" +
                        "        \"qualification\":\"kkkk\",\n" +
                        "        \"intstitution\":\"int\",\n" +
                        "        \"date\":\"2012-04-23T18:25:43.511Z\",\n" +
                        "        \"endo\":\"2012-04-23T18:25:43.511Z\"\n" +
                        "    }\n" +
                        "}"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void addLink() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/User/addLink")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n"+
                        "       \"link\":{\n" +
                        "           \"linkid\":1,\n" +
                        "           \"url\":\"url\"\n" +
                        "       }\n" +
                        "}\n"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void removeLink() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/User/remLink")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n"+
                        "       \"link\":{\n" +
                        "           \"linkid\":1,\n" +
                        "           \"url\":\"url\"\n" +
                        "       }\n" +
                        "}\n"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void updateLink() throws Exception {
        RequestBuilder request =MockMvcRequestBuilders
                .post("/api/User/updateLink")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n"+
                        "       \"link\":{\n" +
                        "           \"linkid\":1,\n" +
                        "           \"url\":\"url\"\n" +
                        "       }\n" +
                        "}\n"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void addReference() throws Exception {
        RequestBuilder request =MockMvcRequestBuilders
                .post("/api/User/addRef")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n"+
                        "       \"reference\":{\n" +
                        "           \"refid\":1,\n" +
                        "           \"description\":\"This is the description\"\n," +
                        "           \"contact\":\"This is the contact\"\n" +
                        "       }\n" +
                        "}\n"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void removeReference() throws Exception {
        RequestBuilder request =MockMvcRequestBuilders
                .post("/api/User/remRef")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n"+
                                "       \"reference\":{\n" +
                                "           \"refid\":1,\n" +
                                "           \"description\":\"This is the description\"\n," +
                                "           \"contact\":\"This is the contact\"\n" +
                                "       }\n" +
                                "}\n"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void updateReference() throws Exception {
        RequestBuilder request =MockMvcRequestBuilders
                .post("/api/User/updateRef")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n"+
                                "       \"reference\":{\n" +
                                "           \"refid\":1,\n" +
                                "           \"description\":\"This is the description\"\n," +
                                "           \"contact\":\"This is the contact\"\n" +
                                "       }\n" +
                                "}\n"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void addSkill() throws Exception {
        RequestBuilder request =MockMvcRequestBuilders
                .post("/api/User/addSkill")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n"+
                                "       \"skill\":{\n" +
                                "           \"skillid\":1,\n" +
                                "           \"skill\":\"This is the skill description\"\n," +
                                "           \"level\": 3,\n" +
                                "           \"reason\":\"This is the reason description\"\n" +
                                "       }\n" +
                                "}\n"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void removeSkill() throws Exception {
        RequestBuilder request =MockMvcRequestBuilders
                .post("/api/User/remSkill")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n"+
                                "       \"skill\":{\n" +
                                "           \"skillid\":1,\n" +
                                "           \"skill\":\"This is the skill description\"\n," +
                                "           \"level\": 3,\n" +
                                "           \"reason\":\"This is the reason description\"\n" +
                                "       }\n" +
                                "}\n"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void updateSkill() throws Exception {
        RequestBuilder request =MockMvcRequestBuilders
                .post("/api/User/updateSkill")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n"+
                                "       \"skill\":{\n" +
                                "           \"skillid\":1,\n" +
                                "           \"skill\":\"This is the skill description\"\n," +
                                "           \"level\": 3,\n" +
                                "           \"reason\":\"This is the reason description\"\n" +
                                "       }\n" +
                                "}\n"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }

    @Test
    void generateUrl() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/User/share")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\n" +
                        "    \"filename\":\"DocumentTest.pdf\",\n" +
                        "    \"base\":\"http://localhost:8080/\",\n" +
                        "    \"duration\":\"PT0H2M30S\"\n" +
                        "}"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 200).isTrue();
    }
}
