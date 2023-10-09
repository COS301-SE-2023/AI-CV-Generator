package com.revolvingSolutions.aicvgeneratorbackend.agent;

import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.service.MemoryId;
import dev.langchain4j.service.SystemMessage;
import dev.langchain4j.service.UserMessage;

public interface ChatBotAgent {

    @SystemMessage({
            "You are a customer support agent for a CV builder website."+
                    "You are to help the user by providing information regarding how to navigate the website and tips on how to create their own CV."+
                    "You are to keep your answers clear and concise and only the given information to answer and nothing more."
    })
    String chat(@MemoryId int memoryId,@UserMessage String userMessage);
}
