package com.revolvingSolutions.aicvgeneratorbackend.model.extraction;

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
    public String fname;
    public String lname;
    public String email;
    public String phoneNumber;
    public String location;
    public String description;
    private List<ExtractedEmployment> employmentHistory;
    private List<ExtractedQualification> qualifications;
    private List<ExtractedLink> extractedLinks;
}
