package com.revolvingSolutions.aicvgeneratorbackend.service;


import com.revolvingSolutions.aicvgeneratorbackend.agent.*;
import com.revolvingSolutions.aicvgeneratorbackend.constants.StaticValues;
import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.AIEmployment;
import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.AIInputData;
import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.CVData;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.ChatRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.ExtractionRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.ChatResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.ExtractionResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.GenerationResponse;

import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.data.message.UserMessage;
import dev.langchain4j.data.segment.TextSegment;
import dev.langchain4j.memory.chat.MessageWindowChatMemory;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.moderation.ModerationModel;
import dev.langchain4j.model.openai.OpenAiChatModel;
import dev.langchain4j.retriever.Retriever;
import dev.langchain4j.service.AiServices;
import dev.langchain4j.store.memory.chat.ChatMemoryStore;
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
                                    .references(request.getData().getReferences())
                                    .skills(request.getData().getSkills())
                                    .build()
                    )
                    .build();
        }
        List<String> mylist = new ArrayList<>();
        for (AIEmployment employment : request.getData().getExperience()) {
            mylist.add(interact(employmentHistoryExpander(chatLanguageModel()),employment.toString()));
        }

        String description = interact(descriptionAgent(chatLanguageModel()),request.getData().toString());
        if (description == null) description = "Description";
        if (request.getData().getExperience() == null) request.getData().setExperience(new ArrayList<>());
        if (request.getData().getQualifications() == null) request.getData().setQualifications(new ArrayList<>());
        String education_description = interact(educationDescriptionAgent(chatLanguageModel()),request.getData().getQualifications().toString()+request.getData().getDescription());
        if (education_description == null) education_description = "Education Description";
        return GenerationResponse.builder()
                .data(
                        CVData.builder()
                                .firstname(request.getData().getFirstname())
                                .lastname(request.getData().getLastname())
                                .phoneNumber(request.getData().getPhoneNumber())
                                .email(request.getData().getEmail())
                                .location(request.getData().getLocation())
                                .description(description)
                                .employmenthistory(request.getData().getExperience())
                                .experience(mylist)
                                .qualifications(request.getData().getQualifications())
                                .education_description(education_description)
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
        AIInputData data = extractionAgent(extractionChatLanguageModel()).extractPersonFrom(request.getText());

        if (data.getFirstname() == null) data.setFirstname("First Name");
        if (data.getLastname() == null) data.setLastname("Last Name");
        if (data.getEmail() == null) data.setEmail("Email");
        if (data.getLocation() == null) data.setLocation("Location");
        if (data.getPhoneNumber() == null) data.setPhoneNumber("Phone number");
        if (data.getDescription() == null) data.setDescription("Description");
        if (data.getExperience() == null) data.setExperience(new ArrayList<>());
        if (data.getQualifications() == null) data.setQualifications(new ArrayList<>());
        if (data.getLinks() == null) data.setLinks(new ArrayList<>());
        if (data.getSkills() == null) data.setReferences(new ArrayList<>());

        ExtractionResponse resp = ExtractionResponse.builder()
                .data(
                    data
                )
                .build();
        System.out.println(resp.toString());
        return  resp;
    }

    public ChatResponse chatBotInteract(ChatRequest request) {
        ChatBotAgent chatBot = chatBotAgent(chatBotLanguageModel(),request.getMessages());
        String response = chatBot.chat(0,request.getUserMessage());
        request.getMessages().add(request.getUserMessage());
        request.getMessages().add(response);
        return ChatResponse.builder()
                .messages(request.getMessages())
                .build();
    }

    public static String interact(DescriptionAgent agent, String userMessage) {
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

    private static String interact(ChatBotAgent agent, String userMessage) {
        System.out.println("==========================================================================================");
        System.out.println("[User]: " + userMessage);
        System.out.println("==========================================================================================");
        String agentAnswer = agent.chat(0,userMessage);
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

    private final Retriever<TextSegment> retriever;
    private final ModerationModel moderationModel;

    private ChatLanguageModel chatLanguageModel() {
        return OpenAiChatModel.builder()
                .modelName(modelName)
                .apiKey(apikey)
                .temperature(temperature)
                .logRequests(true)
                .logResponses(true)
                .maxRetries(2)
                .maxTokens(1000)
                .topP(1.0)
                .timeout(Duration.ofMinutes(2))
                .frequencyPenalty(0.0)
                .presencePenalty(0.0)
                .build();
    }

    private ChatLanguageModel extractionChatLanguageModel() {
        return OpenAiChatModel.builder()
                .modelName(modelName)
                .apiKey(apikey)
                .temperature(temperature)
                .logRequests(true)
                .logResponses(true)
                .maxRetries(2)
                .maxTokens(1000)
                .topP(1.0)
                .timeout(Duration.ofMinutes(3))
                .frequencyPenalty(0.0)
                .presencePenalty(0.0)
                .build();
    }

    private ChatLanguageModel chatBotLanguageModel() {
        return OpenAiChatModel.builder()
                .modelName("gpt-4")
                .apiKey(apikey)
                .temperature(0.0)
                .logRequests(true)
                .logResponses(true)
                .maxRetries(2)
                .maxTokens(500)
                .topP(1.0)
                .timeout(Duration.ofMinutes(3))
                .frequencyPenalty(0.0)
                .presencePenalty(0.0)
                .build();
    }
    private DescriptionAgent descriptionAgent(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(DescriptionAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withMaxMessages(3))
                .build();
    }

    private EmploymentHistoryExpander employmentHistoryExpander(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(EmploymentHistoryExpander.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withMaxMessages(3))
                .build();
    }

    private EducationDescriptionAgent educationDescriptionAgent(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(EducationDescriptionAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withMaxMessages(3))
                .build();
    }

    public ExtractionAgent extractionAgent(ChatLanguageModel extractionChatLanguageModel) {
        return AiServices.builder(ExtractionAgent.class)
                .chatLanguageModel(extractionChatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withMaxMessages(5))
                .build();
    }

    public ChatBotAgent chatBotAgent(ChatLanguageModel chatLanguageModel, List<String> messages) {
        List<ChatMessage> messagesOff = new ArrayList<ChatMessage>();
        Boolean user = true;
        for (int x=0;x<messages.size();x++) {
            if (user) {
                user = false;
                messagesOff.add(new UserMessage(messages.get(x)));
            } else {
                user = true;
                messagesOff.add(new AiMessage(messages.get(x)));
            }
        }
        PersistentChatMemoryStore store = new PersistentChatMemoryStore(messagesOff);

        return AiServices.builder(ChatBotAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemoryProvider(
                        memoryId-> MessageWindowChatMemory.builder()
                                .chatMemoryStore(store)
                                .maxMessages(100)
                                .build()
                )
                .moderationModel(moderationModel)
                .retriever(retriever)
                .build();
    }
}

class PersistentChatMemoryStore implements ChatMemoryStore {

    public PersistentChatMemoryStore(List<ChatMessage> messages) {
        this.messages = messages;
    }
    private List<ChatMessage> messages;

    @Override
    public List<ChatMessage> getMessages(Object memoryId) {
        return messages;
    }

    @Override
    public void updateMessages(Object memoryId, List<ChatMessage> messages) {
        this.messages = messages;
    }

    @Override
    public void deleteMessages(Object memoryId) {
        messages = new ArrayList<>();
    }
}