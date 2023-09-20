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
public class ProfessionalSummaryModel {
    private String firstname;
    private String lastname;
    private String location;
    private String description;
    @Description("Each employment must be described with the company, the job title and the start date and end date of employment")
    private List<AIEmployment> experience;
    @Description("Each qualification must be described with the qualification, the institution and the start date and end date of qualification")
    private List<AIQualification> qualifications;
    @Description("Each skill must be described with the skill name and a value indicating it's proficiency and a reason for the skill")
    private List<AISkill> skills;
}
