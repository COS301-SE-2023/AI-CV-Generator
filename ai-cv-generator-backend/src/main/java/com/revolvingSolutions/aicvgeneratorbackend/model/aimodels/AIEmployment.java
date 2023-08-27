package com.revolvingSolutions.aicvgeneratorbackend.model.aimodels;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AIEmployment {
    private String company;
    private String jobTitle;
    private String startDate;
    private String endDate;
}
