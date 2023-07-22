package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.conf.AuthFilter;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import org.junit.jupiter.api.BeforeEach;
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

import static org.assertj.core.api.Java6Assertions.assertThat;

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
        MultipartFile img = new MockMultipartFile("File",(byte[])null);
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/User/updateprofimg")
                .contentType(MediaType.MULTIPART_FORM_DATA)
                .content(img.getBytes())
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus()==200).isTrue();
    }

}
