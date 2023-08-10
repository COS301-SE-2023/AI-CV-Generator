package com.revolvingSolutions.aicvgeneratorbackend.model.aimodels;


import com.revolvingSolutions.aicvgeneratorbackend.model.user.Qualification;
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
    private List<String> experience;
    private List<AIQualification> qualifications;
    private String education_description;
}
