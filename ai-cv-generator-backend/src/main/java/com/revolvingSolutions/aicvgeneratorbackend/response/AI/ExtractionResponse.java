package com.revolvingSolutions.aicvgeneratorbackend.response.AI;

import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.AIInputData;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ExtractionResponse {
    private AIInputData data;
}
