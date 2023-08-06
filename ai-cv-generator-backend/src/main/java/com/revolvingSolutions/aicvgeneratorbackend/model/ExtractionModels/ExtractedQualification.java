package com.revolvingSolutions.aicvgeneratorbackend.model.ExtractionModels;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ExtractedQualification {
    private String qualification;
    private String intstitution;
    private Date date;
    private Date endo;
}
