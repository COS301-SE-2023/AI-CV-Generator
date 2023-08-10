package com.revolvingSolutions.aicvgeneratorbackend.request.AI;

import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.AIInputData;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GenerationRequest {
    public AIInputData data;
}
