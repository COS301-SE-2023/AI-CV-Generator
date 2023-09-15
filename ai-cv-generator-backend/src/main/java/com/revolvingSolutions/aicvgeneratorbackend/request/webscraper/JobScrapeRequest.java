package com.revolvingSolutions.aicvgeneratorbackend.request.webscraper;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class JobScrapeRequest {
    String field;
    String location;
    Integer amount;
}
