package com.revolvingSolutions.aicvgeneratorbackend.agent;

import dev.langchain4j.service.SystemMessage;

public interface EducationDescriptionAgent {
    @SystemMessage({
            "You are a bot that provides a summary of the educational background of a user." +
                    "A user will provide all there qualifications in a paragraph, " +
                    "and you should describe them in the form of a paragraph in first person, " +
                    "and nothing more."
    })
    String chat(String userMessage);
}
