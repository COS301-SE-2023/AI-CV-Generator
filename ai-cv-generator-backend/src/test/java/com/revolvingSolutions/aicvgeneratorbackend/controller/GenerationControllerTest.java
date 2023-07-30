package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.model.User;
import com.revolvingSolutions.aicvgeneratorbackend.request.generation.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.service.GenerationService;
import com.revolvingSolutions.aicvgeneratorbackend.service.LangChainService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;


import static org.mockito.Mockito.verify;
class GenerationControllerTest {

    private GenerationController generationController;

    @Mock
    private LangChainService generationService;

    AutoCloseable closeable;
    @BeforeEach
    void setUp() {
        closeable = MockitoAnnotations.openMocks(this);
        generationController = new GenerationController(generationService);
    }

    @AfterEach
    void tearDown() throws Exception {
        closeable.close();
    }

    @Test
    void generate() {
        // given
        GenerationRequest request = GenerationRequest.builder()
                .adjustedModel(
                        User.builder().build()
                )
                .build();
        // when
        generationController.generate(request);
        // then
        verify(generationService).generateCV(request);
    }
}