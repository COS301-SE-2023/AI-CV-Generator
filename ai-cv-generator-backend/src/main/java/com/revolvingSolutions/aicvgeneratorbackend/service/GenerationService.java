package com.revolvingSolutions.aicvgeneratorbackend.service;


import com.revolvingSolutions.aicvgeneratorbackend.model.CVData;
import com.revolvingSolutions.aicvgeneratorbackend.request.generation.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.generation.GenerationResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

//This class will query OpenAI api to build CV with generated subsections
@Service
@RequiredArgsConstructor
public class GenerationService {
    @Value("${app.openAIKey}")
    private String OpenAIKey;

    public GenerationResponse generateCV(GenerationRequest request) {
        return GenerationResponse.builder()
                .cvData(
                        CVData.builder()
                                .build()
                )
                .build();
    }

}
