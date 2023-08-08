package com.revolvingSolutions.aicvgeneratorbackend.response.extraction;

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
    AIInputData data;
}
