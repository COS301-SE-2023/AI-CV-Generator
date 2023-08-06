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
public class ExtractedEmployment {
    private String company;
    private String title;
    private Date startdate;
    private Date enddate;
}
