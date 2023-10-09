package com.revolvingSolutions.aicvgeneratorbackend.agent;

import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.AIInputData;
import dev.langchain4j.service.UserMessage;

public interface UrlExtractionAgent {
    @UserMessage("Extract information about a user from html {{it}}")
    AIInputData extractPersonFrom(String text);
}
