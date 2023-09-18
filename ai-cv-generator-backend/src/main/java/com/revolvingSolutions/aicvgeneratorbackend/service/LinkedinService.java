package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.model.webscrapper.JobResponseDTO;
import com.revolvingSolutions.aicvgeneratorbackend.request.webscraper.JobScrapeRequest;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class LinkedinService {

    public void setLinkedIn(AtomicInteger amount) {
        this.amount = amount;
    }

    private AtomicInteger amount = new AtomicInteger(0);
    @Async
    public CompletableFuture<Set<JobResponseDTO>> linkedIn(JobScrapeRequest request) throws IOException {
        System.out.println("LinkedIn start");
        Set<JobResponseDTO> responseDTOS = new HashSet<>();
        Document doc = Jsoup.connect("https://za.linkedin.com/jobs/search?keywords="+request.getField().replaceAll(" ","%20")+"&location="+request.getLocation().replaceAll(" ", "%20")+"&geoId=100001436&trk=public_jobs_jobs-search-bar_search-submit&position=1&pageNum=0").get();
        Element list = doc.getElementsByClass("jobs-search__results-list").first();
        Elements listelements = doc.getElementsByTag("li");
        for (Element el : listelements) {
            if (amount.get()==0) {
                return CompletableFuture.completedFuture(
                        responseDTOS
                );
            }
            if (el.getElementsByClass("base-search-card__title").isEmpty() || el.getElementsByClass("base-search-card__subtitle").isEmpty() || el.getElementsByClass("job-search-card__location").isEmpty()) {
                continue;
            }
            Element link = el.getElementsByClass("hidden-nested-link").first();
            if (
                    responseDTOS.add(
                            JobResponseDTO.builder()
                                    .title(el.getElementsByClass("base-search-card__title").first().ownText())
                                    .subTitle(link.ownText())
                                    .link(link.attr("href"))
                                    .imgLink("https://static.vecteezy.com/system/resources/previews/018/930/587/original/linkedin-logo-linkedin-icon-transparent-free-png.png")
                                    .location(el.getElementsByClass("job-search-card__location").first().ownText())
                                    .build()
                    )
            ) {
                amount.decrementAndGet();
            }
        }
        return CompletableFuture.completedFuture(
                responseDTOS
        );
    }
}