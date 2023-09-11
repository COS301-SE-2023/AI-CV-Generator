package com.revolvingSolutions.aicvgeneratorbackend.agent;

import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.service.MemoryId;
import dev.langchain4j.service.SystemMessage;
import dev.langchain4j.service.UserMessage;

public interface ChatBotAgent {
    @SystemMessage({
            "You are a customer support agent of a web application."
    })
    String chat(@MemoryId int memoryId,@UserMessage String userMessage);
}
