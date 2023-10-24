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
public class CareerBuildersService {

    @Async("task2")
    public CompletableFuture<Set<JobResponseDTO>> CBRE(JobScrapeRequest request) throws IOException {
        System.out.println("CareerBuilders" + Thread.currentThread().getName());
        Set<JobResponseDTO> responseDTOS = new HashSet<>();
        Document doc = Jsoup.connect("https://careers.cbre.com/en_US/careers/SearchJobs/"+request.getField().replaceAll(" ","%20")+"%20="+request.getLocation().replaceAll(" ", "%20")+"?listFilterMode=1&jobSort=relevancy&jobRecordsPerPage=25&").get();
        Element main = doc.getElementsByTag("main").first();
        Element list = main.getElementsByClass("section__content__results").first();
        Elements listelements = doc.getElementsByClass("article article--result ");
        for (Element el : listelements) {
            try {
                if (el.getElementsByClass("article__header__text__title article__header__text__title--4 ").isEmpty()) {
                    continue;
                }
                Element link = el.getElementsByClass("article__header__text__title article__header__text__title--4 ").first().getElementsByTag("a").first();
                Element subtitle = el.getElementsByClass("article__header__text__subtitle").first();
                if (subtitle == null) continue;
                Elements spans = subtitle.getElementsByTag("span");
                StringBuilder subTitle = new StringBuilder();
                for (Element ell: spans) {
                    subTitle.append(ell.ownText());
                }
                String location = "Location";
                if (spans.size() >= 2) {
                    location = spans.get(2).ownText();
                }
                assert link != null;
                responseDTOS.add(
                        JobResponseDTO.builder()
                                .title(link.ownText())
                                .subTitle(subTitle.toString())
                                .location(location)
                                .imgLink("https://careers.cbre.com/portal/4/images/socialShare.jpg")
                                .link(link.attr("href"))
                                .build()
                );
            } catch (Exception e) {
                System.out.println("Response DTOs failed");
            }

        }
        return CompletableFuture.completedFuture(
                responseDTOS
        );
    }
}
