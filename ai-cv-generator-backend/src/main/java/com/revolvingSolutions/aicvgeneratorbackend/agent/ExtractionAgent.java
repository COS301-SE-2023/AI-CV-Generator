package com.revolvingSolutions.aicvgeneratorbackend.agent;

import com.revolvingSolutions.aicvgeneratorbackend.model.extraction.ExtractedData;
import dev.langchain4j.service.UserMessage;

public interface ExtractionAgent {
    @UserMessage("Extract information about a user from {{it}}")
    ExtractedData extractPersonFrom(String text);
}


