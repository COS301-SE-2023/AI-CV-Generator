package com.revolvingSolutions.aicvgeneratorbackend.request.AI;

import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.AIInputData;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GenerationRequest {
    private AIInputData data;
}
