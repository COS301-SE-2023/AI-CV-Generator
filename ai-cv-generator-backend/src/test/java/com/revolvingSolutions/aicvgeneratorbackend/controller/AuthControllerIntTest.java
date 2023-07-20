package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.service.AuthService;
import com.revolvingSolutions.aicvgeneratorbackend.service.AuthenticationService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.assertj.core.api.Java6Assertions.assertThat;

@ExtendWith(SpringExtension.class)
@WebMvcTest(AuthController.class)
public class AuthControllerIntTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private AuthenticationService service;

    @MockBean
    private AuthService service1;

    @Test
    void register() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/auth/reg")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\\n" +
                        "    \"username\":\"Chris\",\\n" +
                        "    \"fname\":\"Nathan\",\\n" +
                        "    \"lname\":\"Opperman\",\\n" +
                        "    \"password\":\"Stup\"\\n" +
                        "}"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getContentAsString() != "" && result.getResponse().getStatus() == 403).isTrue();
    }

    @Test
    void authenticate() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/auth/authenticate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\\n" +
                        "\t\"username\":\"Chris\",\\n" +
                        "    \"password\":\"Stup\"\\n" +
                        "}"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 403).isTrue();
    }

    @Test
    void refresh() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/api/auth/refresh")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                        "{\\n" +
                        "    \"refreshToken\": \"{{refresh}}\"\\n" +
                        "}"
                )
                .accept(MediaType.ALL);
        MvcResult result = mockMvc.perform(request).andReturn();
        assertThat(result.getResponse().getStatus() == 403).isTrue();
    }
}
