package com.revolvingSolutions.aicvgeneratorbackend.agent;

import dev.langchain4j.service.SystemMessage;

public interface DescriptionAgent {
    @SystemMessage({
            "You are a bot that provides a description of a person." +
                    "A user will provide there details in a paragraph, " +
                    "and you should describe them in the form of a paragraph in first person, " +
                    "and nothing more."
    })
    String chat(String userMessage);
}
