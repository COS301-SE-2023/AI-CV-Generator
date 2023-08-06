package com.revolvingSolutions.aicvgeneratorbackend.service;
import com.revolvingSolutions.aicvgeneratorbackend.request.generation.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.generation.GenerationResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
@RequiredArgsConstructor
public class GenerationService {

    @Autowired
    private RestTemplate restTemplate;

    public GenerationResponse generateCV(GenerationRequest request) {
        return GenerationResponse.builder()
                .temp(
                        ""
                )
                .build();
    }

}

