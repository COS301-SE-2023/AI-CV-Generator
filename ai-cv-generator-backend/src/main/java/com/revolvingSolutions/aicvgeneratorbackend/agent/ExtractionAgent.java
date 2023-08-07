package com.revolvingSolutions.aicvgeneratorbackend.agent;

import com.revolvingSolutions.aicvgeneratorbackend.model.extraction.ExtractedData;
import com.revolvingSolutions.aicvgeneratorbackend.model.extraction.ExtractedEmployment;
import dev.langchain4j.service.UserMessage;
import dev.langchain4j.service.V;

import java.util.List;

public interface ExtractionAgent {
    @UserMessage("Extract information about a user from {{it}}")
    ExtractedData extractPersonFrom(String text);
}


