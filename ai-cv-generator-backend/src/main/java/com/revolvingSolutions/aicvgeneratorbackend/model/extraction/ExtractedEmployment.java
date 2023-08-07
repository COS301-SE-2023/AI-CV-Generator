package com.revolvingSolutions.aicvgeneratorbackend.model.extraction;

import dev.langchain4j.model.output.structured.Description;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ExtractedEmployment {
    private String company;
    private String jobTitle;
    private String startDate;
    private String endDate;
}
