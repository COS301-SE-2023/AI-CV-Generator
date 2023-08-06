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
    private ExtractedUser user;
    private List<ExtractedEmployment> employmentHistory;
    private List<ExtractedQualification> qualifications;
    private List<ExtractedLink> extractedLinks;
}
