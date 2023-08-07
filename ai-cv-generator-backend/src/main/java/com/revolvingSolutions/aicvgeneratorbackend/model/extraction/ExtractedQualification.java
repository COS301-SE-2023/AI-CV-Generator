package com.revolvingSolutions.aicvgeneratorbackend.model.extraction;

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
    private String institution;
    private String startDate;
    private String endDate;
}
