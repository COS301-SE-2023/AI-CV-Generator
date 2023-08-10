package com.revolvingSolutions.aicvgeneratorbackend.response.AI;

import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.CVData;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GenerationResponse {
    private CVData data;
}
