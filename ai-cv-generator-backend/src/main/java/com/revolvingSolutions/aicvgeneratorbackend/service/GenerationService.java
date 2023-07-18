package com.revolvingSolutions.aicvgeneratorbackend.service;
import com.revolvingSolutions.aicvgeneratorbackend.model.CVData;
import com.revolvingSolutions.aicvgeneratorbackend.request.generation.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.generation.GenerationResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

//This class will query OpenAI api to build CV with generated subsections
@Service
@RequiredArgsConstructor
public class GenerationService {
    @Value("${app.openAIKey}")
    private String OpenAIKey;

    @Value("${app.api.host.baseurl}")
    private String baseurl;

    @Autowired
    private RestTemplate restTemplate;

    public GenerationResponse generateCV(GenerationRequest request) {
        return GenerationResponse.builder()
                .cvData(
                        CVData.builder()
                                .tempdata("tempdata")
                                .build()
                )
                .build();
    }

}

