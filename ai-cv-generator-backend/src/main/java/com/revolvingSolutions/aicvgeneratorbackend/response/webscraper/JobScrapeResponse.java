package com.revolvingSolutions.aicvgeneratorbackend.response.webscraper;

import com.revolvingSolutions.aicvgeneratorbackend.model.webscrapper.JobResponseDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class JobScrapeResponse {
    private Set<JobResponseDTO> jobs;
}
