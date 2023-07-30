package com.revolvingSolutions.aicvgeneratorbackend.service;


import com.revolvingSolutions.aicvgeneratorbackend.agent.GenerationAgent;
import com.revolvingSolutions.aicvgeneratorbackend.model.CVData;
import com.revolvingSolutions.aicvgeneratorbackend.request.generation.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.generation.GenerationResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.generation.MockGenerationResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LangChainService {

    private final GenerationAgent generationAgent;
    public GenerationResponse generateCV(
            GenerationRequest request
    ) {
        return  GenerationResponse.builder()
                .temp(interact(generationAgent, request.getAdjustedModel().toString()))
                .build();
    }

    public GenerationResponse jythonGenerateCV(
            GenerationRequest request
    ) {
        return  GenerationResponse.builder()
                .temp(interact(generationAgent, request.getAdjustedModel().toString()))
                .build();
    }

    public MockGenerationResponse mockGenerateCV(
            GenerationRequest request
    ) {
        return MockGenerationResponse.builder()
                .mockgeneratedUser(
                        request.getAdjustedModel()
                )
                .extradata(
                    "Any additions?"
                )
                .build();
    }

    private static String interact(GenerationAgent agent, String userMessage) {
        System.out.println("==========================================================================================");
        System.out.println("[User]: " + userMessage);
        System.out.println("==========================================================================================");
        String agentAnswer = agent.chat(userMessage);
        System.out.println("==========================================================================================");
        System.out.println("[Agent]: " + agentAnswer);
        System.out.println("==========================================================================================");
        return agentAnswer;
    }
}
