package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.request.generation.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.service.GenerationService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;


import static org.mockito.Mockito.verify;
class GenerationControllerTest {

    private GenerationController generationController;

    @Mock
    private GenerationService generationService;

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
                .TempData("temp")
                .build();
        // when
        generationController.generate(request);
        // then
        verify(generationService).generateCV(request);
    }
}