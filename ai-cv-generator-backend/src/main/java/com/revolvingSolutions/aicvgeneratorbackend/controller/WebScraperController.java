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
        try {
            return ResponseEntity.ok(service.scrapData(request));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping(value = "/recommended")
    public  ResponseEntity<JobScrapeResponse> recommend() {
        return ResponseEntity.ok(service.getRecommended());
    }
}
