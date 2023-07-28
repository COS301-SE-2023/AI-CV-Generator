package com.revolvingSolutions.aicvgeneratorbackend.conf;


import com.revolvingSolutions.aicvgeneratorbackend.agent.GenerationAgent;
import dev.langchain4j.data.segment.TextSegment;
import dev.langchain4j.memory.chat.MessageWindowChatMemory;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.openai.OpenAiChatModel;
import dev.langchain4j.retriever.Retriever;
import dev.langchain4j.service.AiServices;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@RequiredArgsConstructor
public class LangChainConf {

    @Value("${langchain4j.chat-model.openai.api-key}")
    private String apikey;
    @Bean
    public ChatLanguageModel chatLanguageModel() {
        return OpenAiChatModel.withApiKey(apikey);
    }
    @Bean
    public GenerationAgent generationAgent(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(GenerationAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withCapacity(20))
                .build();
    }
}
