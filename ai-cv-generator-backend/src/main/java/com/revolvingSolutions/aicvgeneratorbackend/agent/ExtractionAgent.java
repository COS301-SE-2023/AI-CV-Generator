package com.revolvingSolutions.aicvgeneratorbackend.agent;

import com.revolvingSolutions.aicvgeneratorbackend.model.extraction.ExtractedData;
import dev.langchain4j.service.UserMessage;
import dev.langchain4j.service.V;

public interface ExtractionAgent {
    @UserMessage("Extract information about a user from {{text}}")
    ExtractedData extractPersonFrom(@V("text")String text);
}


