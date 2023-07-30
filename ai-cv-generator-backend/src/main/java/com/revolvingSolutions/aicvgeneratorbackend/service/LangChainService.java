package com.revolvingSolutions.aicvgeneratorbackend.service;


import com.revolvingSolutions.aicvgeneratorbackend.agent.DescriptionAgent;
import com.revolvingSolutions.aicvgeneratorbackend.agent.EducationDescriptionAgent;
import com.revolvingSolutions.aicvgeneratorbackend.agent.EmploymentHistoryExpander;
import com.revolvingSolutions.aicvgeneratorbackend.agent.GenerationAgent;
import com.revolvingSolutions.aicvgeneratorbackend.model.CVData;
import com.revolvingSolutions.aicvgeneratorbackend.model.Employment;
import com.revolvingSolutions.aicvgeneratorbackend.request.generation.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.generation.GenerationResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.generation.MockGenerationResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class LangChainService {

    private final GenerationAgent generationAgent;
    private final DescriptionAgent descriptionAgent;
    private final EmploymentHistoryExpander employmentHistoryExpander;
    private final EducationDescriptionAgent educationDescriptionAgent;
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
        List<String> mylist = new ArrayList<>();
        for (Employment employment : request.getAdjustedModel().getEmploymenthistory()) {
            mylist.add(interact(employmentHistoryExpander,employment.toString()));
        }

        return MockGenerationResponse.builder()
                .mockgeneratedUser(
                        request.getAdjustedModel()
                )
                .data(
                        CVData.builder()
                                .description(interact(descriptionAgent,request.getAdjustedModel().toString()))
                                .employmenthis(mylist)
                                .education_description(interact(educationDescriptionAgent,request.getAdjustedModel().getQualifications().toString()+request.getAdjustedModel().getDescription()))
                                .build()
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

    private static String interact(DescriptionAgent agent, String userMessage) {
        System.out.println("==========================================================================================");
        System.out.println("[User]: " + userMessage);
        System.out.println("==========================================================================================");
        String agentAnswer = agent.chat(userMessage);
        System.out.println("==========================================================================================");
        System.out.println("[Agent]: " + agentAnswer);
        System.out.println("==========================================================================================");
        return agentAnswer;
    }

    private static String interact(EmploymentHistoryExpander agent, String userMessage) {
        System.out.println("==========================================================================================");
        System.out.println("[User]: " + userMessage);
        System.out.println("==========================================================================================");
        String agentAnswer = agent.chat(userMessage);
        System.out.println("==========================================================================================");
        System.out.println("[Agent]: " + agentAnswer);
        System.out.println("==========================================================================================");
        return agentAnswer;
    }

    private static String interact(EducationDescriptionAgent agent, String userMessage) {
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
