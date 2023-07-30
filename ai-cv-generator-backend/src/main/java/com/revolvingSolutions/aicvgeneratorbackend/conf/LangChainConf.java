package com.revolvingSolutions.aicvgeneratorbackend.conf;


import com.revolvingSolutions.aicvgeneratorbackend.agent.DescriptionAgent;
import com.revolvingSolutions.aicvgeneratorbackend.agent.EducationDescriptionAgent;
import com.revolvingSolutions.aicvgeneratorbackend.agent.EmploymentHistoryExpander;
import com.revolvingSolutions.aicvgeneratorbackend.agent.GenerationAgent;
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
                100,
                0.0,0.0,
                Duration.ofMinutes(2),
                2,
                true,
                true
        );
    }
    @Bean
    public GenerationAgent generationAgent(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(GenerationAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withCapacity(40))
                .build();
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
}
