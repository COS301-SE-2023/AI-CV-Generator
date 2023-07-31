package com.revolvingSolutions.aicvgeneratorbackend.agent;

import dev.langchain4j.service.SystemMessage;

public interface GenerationAgent {
    @SystemMessage({
            "You are a CV generator that creates cvs from the provided imformation."
    })
    String chat(String userMessage);
}