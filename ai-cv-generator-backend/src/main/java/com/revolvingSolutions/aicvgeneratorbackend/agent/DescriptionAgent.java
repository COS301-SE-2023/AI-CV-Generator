package com.revolvingSolutions.aicvgeneratorbackend.agent;

import dev.langchain4j.service.SystemMessage;

public interface DescriptionAgent {
    @SystemMessage({
            "You are a bot that provides a professional summary of a user." +
                    "A user will provide there details in a paragraph, " +
                    "and you should describe them in the form of a professional summary in first person, " +
                    "and nothing more."
    })
    String chat(String userMessage);
}
