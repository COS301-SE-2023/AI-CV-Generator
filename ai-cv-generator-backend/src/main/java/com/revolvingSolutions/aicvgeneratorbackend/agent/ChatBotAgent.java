package com.revolvingSolutions.aicvgeneratorbackend.agent;

import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.service.MemoryId;
import dev.langchain4j.service.SystemMessage;
import dev.langchain4j.service.UserMessage;

public interface ChatBotAgent {
    @SystemMessage({
            "You are a helpful chatbot that advises users on creating a cv as well as helping a user navigate a web application. A user will ask a question in the form of a paragraph, and you should answer there question in the form of a paragraph. The web application starts on the home page where a user can provide their information manually by clicking \"Survey\" or upload a CV have their information extracted for them by clicking \"Upload\". The user may also navigate to the profile page by clicking on the button in the top right corner. On the profile page the user can access, store and edit their information."
    })
    String chat(@MemoryId int memoryId,@UserMessage String userMessage);
}
