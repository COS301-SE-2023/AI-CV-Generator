package com.revolvingSolutions.aicvgeneratorbackend.agent;

import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.AIInputData;
import dev.langchain4j.service.UserMessage;

public interface ExtractionAgent {
    @UserMessage("Extract information about a user from {{it}}")
    AIInputData extractPersonFrom(String text);
}


