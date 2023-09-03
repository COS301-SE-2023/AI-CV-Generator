package com.revolvingSolutions.aicvgeneratorbackend.service;


import com.revolvingSolutions.aicvgeneratorbackend.agent.*;
import com.revolvingSolutions.aicvgeneratorbackend.constants.StaticValues;
import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.AIEmployment;
import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.CVData;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.ExtractionRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.ExtractionResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.GenerationResponse;

import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.memory.chat.MessageWindowChatMemory;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.openai.OpenAiChatModel;
import dev.langchain4j.service.AiServices;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class LangChainService {

    @Value("${app.api.blockAI}")
    private Boolean block;

    public GenerationResponse GenerateCV(
            GenerationRequest request
    ) {
        if (block) {
            List<String> mylist = new ArrayList<>();
            for (AIEmployment employment : request.getData().getExperience()) {
                mylist.add(StaticValues.employment_description);
            }

            return GenerationResponse.builder()
                    .data(
                            CVData.builder()
                                    .firstname(request.getData().getFirstname())
                                    .lastname(request.getData().getLastname())
                                    .phoneNumber(request.getData().getPhoneNumber())
                                    .email(request.getData().getEmail())
                                    .location(request.getData().getLocation())
                                    .description(StaticValues.description)
                                    .employmenthistory(request.getData().getExperience())
                                    .experience(mylist)
                                    .qualifications(request.getData().getQualifications())
                                    .education_description(StaticValues.education_description)
                                    .links(request.getData().getLinks())
                                    .build()
                    )
                    .build();
        }
        List<String> mylist = new ArrayList<>();
        for (AIEmployment employment : request.getData().getExperience()) {
            mylist.add(interact(employmentHistoryExpander(chatLanguageModel()),employment.toString()));
        }

        return GenerationResponse.builder()
                .data(
                        CVData.builder()
                                .firstname(request.getData().getFirstname())
                                .lastname(request.getData().getLastname())
                                .phoneNumber(request.getData().getPhoneNumber())
                                .email(request.getData().getEmail())
                                .location(request.getData().getLocation())
                                .description(interact(descriptionAgent(chatLanguageModel()),request.getData().toString()))
                                .employmenthistory(request.getData().getExperience())
                                .experience(mylist)
                                .qualifications(request.getData().getQualifications())
                                .education_description(interact(educationDescriptionAgent(chatLanguageModel()),request.getData().getQualifications().toString()+request.getData().getDescription()))
                                .links(request.getData().getLinks())
                                .build()
                )
                .build();
    }

    public ExtractionResponse extractData(
            ExtractionRequest request
    )  throws Exception
    {
        if (request.getText().split(" ").length > 1000) {
            throw new Exception("Word Limit!!",null);
        }
        if (block) {
            // implement mock later
        }
        ExtractionResponse resp = ExtractionResponse.builder()
                .data(
                        extractionAgent(extractionChatLanguageModel()).extractPersonFrom(request.getText())
                )
                .build();
        System.out.println(resp.toString());
        return  resp;
    }

    private void chatBotInteract() {
    }

    private static String interact(DescriptionAgent agent, String userMessage) {
        System.out.println("==========================================================================================");
        System.out.println("[User]: " + userMessage);
        System.out.println("==========================================================================================");
        String agentAnswer = agent.chat(userMessage);
        System.out.println("==========================================================================================");
        System.out.println("[DescriptionAgent]: " + agentAnswer);
        System.out.println("==========================================================================================");
        return agentAnswer;
    }

    private static String interact(EmploymentHistoryExpander agent, String userMessage) {
        System.out.println("==========================================================================================");
        System.out.println("[User]: " + userMessage);
        System.out.println("==========================================================================================");
        String agentAnswer = agent.chat(userMessage);
        System.out.println("==========================================================================================");
        System.out.println("[EmploymentHistoryExpander]: " + agentAnswer);
        System.out.println("==========================================================================================");
        return agentAnswer;
    }

    private static String interact(EducationDescriptionAgent agent, String userMessage) {
        System.out.println("==========================================================================================");
        System.out.println("[User]: " + userMessage);
        System.out.println("==========================================================================================");
        String agentAnswer = agent.chat(userMessage);
        System.out.println("==========================================================================================");
        System.out.println("[EducationDescriptionAgent]: " + agentAnswer);
        System.out.println("==========================================================================================");
        return agentAnswer;
    }

    @Value("${langchain4j.chat-model.openai.api-key}")
    private String apikey;
    @Value("${langchain4j.chat-model.openai.model-name}")
    private String modelName;

    @Value("${langchain4j.chat-model.openai.temperature}")
    private Double temperature;

    private ChatLanguageModel chatLanguageModel() {
        return new OpenAiChatModel(
            apikey,
            modelName,
            temperature,
            1.0,
            1000,
            0.0,0.0,
            Duration.ofMinutes(2),
            2,
            true,
            true
        );
    }

    private ChatLanguageModel extractionChatLanguageModel() {
        return new OpenAiChatModel(
            apikey,
            modelName,
            0.0,
            1.0,
            6000,
            0.0,0.0,
            Duration.ofMinutes(3),
            2,
            true,
            true
        );
    }

    private ChatLanguageModel chatBotLanguageModel(List<ChatMessage> messages) {
        OpenAiChatModel model =  new OpenAiChatModel(
            apikey,
            modelName,
            temperature,
            1.0,
            500,
            0.0,
            0.0,
            Duration.ofMinutes(2),
            2,
            true,
            true
        );
        model.sendMessages(messages);
        return model;
    }

    private DescriptionAgent descriptionAgent(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(DescriptionAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withCapacity(3))
                .build();
    }

    private EmploymentHistoryExpander employmentHistoryExpander(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(EmploymentHistoryExpander.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withCapacity(3))
                .build();
    }

    private EducationDescriptionAgent educationDescriptionAgent(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(EducationDescriptionAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withCapacity(3))
                .build();
    }

    public ExtractionAgent extractionAgent(ChatLanguageModel extractionChatLanguageModel) {
        return AiServices.builder(ExtractionAgent.class)
                .chatLanguageModel(extractionChatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withCapacity(5))
                .build();
    }
}
