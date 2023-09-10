package com.revolvingSolutions.aicvgeneratorbackend.agent;

import dev.langchain4j.service.SystemMessage;

public interface FieldClassifierAgent {
    @SystemMessage(
            "You are a bot that decides a users career field based on their profile."+
                    "A user will provide their details in a paragraph,"+
                    "and you should decide what their field of interest is, " +
                    "and nothing more." +
                    "If you cannot determine the users field simply respond with an empty string"
    )
    String chat(String userMessage);
}
