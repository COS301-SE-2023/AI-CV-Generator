package com.revolvingSolutions.aicvgeneratorbackend.conf;


import com.revolvingSolutions.aicvgeneratorbackend.agent.*;
import dev.langchain4j.memory.chat.MessageWindowChatMemory;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.openai.OpenAiChatModel;
import dev.langchain4j.service.AiServices;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.Duration;

@Configuration
@RequiredArgsConstructor
public class LangChainConf {

    @Value("${langchain4j.chat-model.openai.api-key}")
    private String apikey;
    @Value("${langchain4j.chat-model.openai.model-name}")
    private String modelName;

    @Value("${langchain4j.chat-model.openai.temperature}")
    private Double temperature;


    @Bean
    public ChatLanguageModel chatLanguageModel() {
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

    public ChatLanguageModel extractionChatLanguageModel() {
        return new OpenAiChatModel(
                apikey,
                modelName,
                0.0,
                1.0,
                3000,
                0.0,0.0,
                Duration.ofMinutes(3),
                2,
                true,
                true
        );
    }

    @Bean
    public DescriptionAgent descriptionAgent(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(DescriptionAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withCapacity(3))
                .build();
    }

    @Bean
    public EmploymentHistoryExpander employmentHistoryExpander(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(EmploymentHistoryExpander.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withCapacity(3))
                .build();
    }

    @Bean
    public EducationDescriptionAgent educationDescriptionAgent(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(EducationDescriptionAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withCapacity(3))
                .build();
    }

    @Bean
    public ExtractionAgent extractionAgent(ChatLanguageModel extractionChatLanguageModel) {
        return AiServices.builder(ExtractionAgent.class)
                .chatLanguageModel(extractionChatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withCapacity(5))
                .build();
    }
}
