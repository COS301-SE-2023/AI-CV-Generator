package com.revolvingSolutions.aicvgeneratorbackend.request.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Duration;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GenerateUrlRequest {
    String filename;
    String base;
    Duration duration;
}
