package com.revolvingSolutions.aicvgeneratorbackend.response.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GenerateUrlResponse {
    private String generatedUrl;
}
