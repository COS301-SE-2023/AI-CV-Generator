package com.revolvingSolutions.aicvgeneratorbackend.model.aimodels;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CVData {
    private String firstname;
    private String lastname;
    private String email;
    private String phoneNumber;
    private String location;
    private String description;
    private List<AIEmployment> employmenthistory;
    private List<AIQualification> qualifications;
    private List<AILink> links;
    private List<AIReference> references;
    private List<AISkill> skills;
}
