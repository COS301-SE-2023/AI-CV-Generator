package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.request.webscraper.JobScrapeRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.webscraper.JobScrapeResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.JobScraperService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping(path = "/api/scrape")
@RequiredArgsConstructor
public class WebScraperController {

    private final JobScraperService service;
    @PostMapping(value = "/jobs")
    public ResponseEntity<JobScrapeResponse> jobScrape(
            @RequestBody JobScrapeRequest request
            ) {
        return ResponseEntity.ok(service.scrapData(request));
    }
}
