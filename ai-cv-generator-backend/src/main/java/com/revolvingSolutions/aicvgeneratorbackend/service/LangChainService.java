package com.revolvingSolutions.aicvgeneratorbackend.service;


import com.revolvingSolutions.aicvgeneratorbackend.agent.*;
import com.revolvingSolutions.aicvgeneratorbackend.constants.StaticValues;
import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.*;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.User;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.ChatRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.ExtractionRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.UrlExtractionRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.ChatResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.ExtractionResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.GenerationResponse;

import dev.langchain4j.classification.TextClassifier;
import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.data.message.SystemMessage;
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
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.Duration;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import static dev.langchain4j.data.message.SystemMessage.systemMessage;

@Service
@RequiredArgsConstructor
public class LangChainService {

    @Value("${app.api.blockAI}")
    private Boolean block;

    private final UserService userService;

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
                                    .qualifications(request.getData().getQualifications())
                                    .links(request.getData().getLinks())
                                    .references(request.getData().getReferences())
                                    .skills(request.getData().getSkills())
                                    .build()
                    )
                    .build();
        }



        String description = interact(descriptionAgent(chatLanguageModel()),createProfessionalSummaryModel(request.getData()).toString());
        if (description == null) description = "Description";
        if (request.getData().getExperience() == null) request.getData().setExperience(new ArrayList<>());
        if (request.getData().getQualifications() == null) request.getData().setQualifications(new ArrayList<>());
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
                                .qualifications(request.getData().getQualifications())
                                .links(request.getData().getLinks())
                                .skills(request.getData().getSkills())
                                .references(request.getData().getReferences())
                                .build()
                )
                .build();
    }

    private ProfessionalSummaryModel createProfessionalSummaryModel(AIInputData data) {
        return ProfessionalSummaryModel.builder()
                .firstname(data.getFirstname())
                .lastname(data.getLastname())
                .description(data.getDescription())
                .location(data.getLocation())
                .experience(data.getExperience())
                .qualifications(data.getQualifications())
                .skills(data.getSkills())
                .build();
    }

    public ExtractionResponse extractData(
            ExtractionRequest request
    )  throws Exception
    {
        if (request.getText().split(" ").length > 1000) {
            throw new Exception("Word Limit!!",null);
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

        return ExtractionResponse.builder()
                .data(
                    data
                )
                .build();
    }

    public ExtractionResponse extractUrlData(
            UrlExtractionRequest request
    ) throws IOException {
        Document doc = Jsoup.connect(request.getUrl()).get();
        AIInputData data = urlExtractionAgent(extractionChatLanguageModel()).extractPersonFrom(doc.toString());
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

        return ExtractionResponse.builder()
                .data(
                        data
                )
                .build();
    }

    public User getAISafeModel() {
        return userService.getUser().getUser();
    }

    public ChatResponse chatBotInteract(ChatRequest request) {
        List<String> messages = new ArrayList<>();
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
                .logRequests(false)
                .logResponses(false)
                .maxRetries(2)
                .maxTokens(1000)
                .topP(1.0)
                .timeout(Duration.ofMinutes(2))
                .frequencyPenalty(0.0)
                .presencePenalty(0.0)
                .build();
    }

    private ChatLanguageModel educationDescriptionChatModel() {
        return OpenAiChatModel.builder()
                .modelName(modelName)
                .apiKey(apikey)
                .temperature(0.4)
                .logRequests(false)
                .logResponses(false)
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
                .logRequests(false)
                .logResponses(false)
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
                .logRequests(false)
                .logResponses(false)
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

    public UrlExtractionAgent urlExtractionAgent(ChatLanguageModel extractionChatLanguageModel) {
        return AiServices.builder(UrlExtractionAgent.class)
                .chatLanguageModel(extractionChatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withMaxMessages(5))
                .build();
    }

    public ChatBotAgent chatBotAgent(ChatLanguageModel chatLanguageModel, List<String> messages) {
        List<ChatMessage> messagesOff = new ArrayList<ChatMessage>();
        boolean user = true;
        messagesOff.add(
                systemMessage(
                        "The user has the following information: "+getAISafeModel().toString()
                )
        );
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