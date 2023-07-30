package com.revolvingSolutions.aicvgeneratorbackend.response.generation;

import com.revolvingSolutions.aicvgeneratorbackend.model.CVData;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GenerationResponse {
    private String temp;
}
