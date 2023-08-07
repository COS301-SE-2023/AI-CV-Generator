package com.revolvingSolutions.aicvgeneratorbackend.model.extraction;

import dev.langchain4j.model.output.structured.Description;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ExtractedData {
    public String firstname;
    public String lastname;
    public String email;
    public String phoneNumber;
    public String location;
    public String description;
    @Description("Each employment must be described with the company, the job title and the start date and end date of employment")
    private List<ExtractedEmployment> experience;
    @Description("Each qualification must be described with the qualification, the institution and the start date and end date of qualification")
    private List<ExtractedQualification> qualifications;
    @Description("Each link must consist of a url")
    private List<ExtractedLink> links;
}
