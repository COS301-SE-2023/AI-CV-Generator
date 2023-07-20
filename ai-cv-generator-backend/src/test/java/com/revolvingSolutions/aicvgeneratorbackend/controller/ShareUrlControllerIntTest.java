package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.service.AuthService;
import com.revolvingSolutions.aicvgeneratorbackend.service.ShareService;
import org.junit.jupiter.api.BeforeEach;
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
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.assertj.core.api.Java6Assertions.assertThat;

@ExtendWith(SpringExtension.class)
@WebMvcTest(ShareUrlController.class)
public class ShareUrlControllerIntTest {
    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private WebApplicationContext webApplicationContext;

    @MockBean
    private ShareService shareService;

    @MockBean
    private AuthService service;

    @BeforeEach
    public void setup()
    {
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    void getSharedFile() throws Exception{
        RequestBuilder request = MockMvcRequestBuilders
                .post("/share")
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

    @Test
    void testForNegativeResponse() throws Exception {
        RequestBuilder request = MockMvcRequestBuilders
                .post("/incorrect_endpoint")
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
        assertThat(result.getResponse().getStatus() == 404).isTrue();
    }
}
