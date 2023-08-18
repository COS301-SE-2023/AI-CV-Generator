package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.exception.NotIndatabaseException;
import com.revolvingSolutions.aicvgeneratorbackend.model.webscrapper.LinkedinResponseDTO;
import com.revolvingSolutions.aicvgeneratorbackend.request.webscraper.JobScrapeRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.webscraper.JobScrapeResponse;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@Service
public class JobScraperService {
    public JobScrapeResponse scrapData(
        JobScrapeRequest request
    ) {
        Set<LinkedinResponseDTO> responseDTOS = new HashSet<>();
        try {
            String keywords = request.getField().replaceAll(" ","%20");
            String location = request.getLocation().replaceAll(" ", "%20");
            Document doc = Jsoup.connect("https://za.linkedin.com/jobs/search?keywords="+keywords+"&location="+location+"&geoId=100001436&trk=public_jobs_jobs-search-bar_search-submit&position=1&pageNum=0").get();
            Element list = doc.getElementsByClass("jobs-search__results-list").first();
            Elements listelements = doc.getElementsByTag("li");
            for (Element el : listelements) {
                if (el.getElementsByClass("base-search-card__title").isEmpty() || el.getElementsByClass("base-search-card__subtitle").isEmpty() || el.getElementsByClass("job-search-card__location").isEmpty()) {
                    continue;
                }
                Element link = el.getElementsByClass("hidden-nested-link").first();

                responseDTOS.add(
                        LinkedinResponseDTO.builder()
                                .title(el.getElementsByClass("base-search-card__title").first().ownText())
                                .subTitle(link.ownText())
                                .subTitleLink(link.attr("href"))
                                .location(el.getElementsByClass("job-search-card__location").first().ownText())
                                .build()
                );
            }
            return JobScrapeResponse.builder()
                    .jobs(responseDTOS)
                    .build();
        } catch (IOException e) {
            throw new RuntimeException("Bad request with scraper");
        }
    }
}
