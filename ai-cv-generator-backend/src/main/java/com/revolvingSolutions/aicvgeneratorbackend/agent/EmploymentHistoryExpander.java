package com.revolvingSolutions.aicvgeneratorbackend.agent;

import dev.langchain4j.service.SystemMessage;

public interface EmploymentHistoryExpander {
    @SystemMessage({
            "You are a bot that expands upon a users employment history." +
                    "A user will provide there details in a paragraph, " +
                    "and you should describe them in the form of a brief paragraph in first person, " +
                    "and nothing more."
    })
    String chat(String userMessage);
}
