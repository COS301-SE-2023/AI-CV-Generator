package com.revolvingSolutions.aicvgeneratorbackend.model.aimodels;

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
public class AIInputData {
    public String firstname;
    public String lastname;
    public String email;
    public String phoneNumber;
    public String location;
    public String description;
    @Description("Each employment must be described with the company, the job title and the start date and end date of employment")
    private List<AIEmployment> experience;
    @Description("Each qualification must be described with the qualification, the institution and the start date and end date of qualification")
    private List<AIQualification> qualifications;
    @Description("Each link must consist of a url")
    private List<AILink> links;
}
