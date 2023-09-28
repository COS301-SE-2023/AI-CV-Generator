package com.revolvingSolutions.aicvgeneratorbackend.agent;

import dev.langchain4j.service.SystemMessage;

public interface FieldClassifierAgent {
    @SystemMessage(
            "You are a bot that decides a users career field based on their profile."+
                    "A user will provide their details in a paragraph,"+
                    "and you should decide what their field of interest is. " +
                    "If you cannot determine their field respond with nothing"+
                    "and nothing more."
    )
    String chat(String userMessage);
}
