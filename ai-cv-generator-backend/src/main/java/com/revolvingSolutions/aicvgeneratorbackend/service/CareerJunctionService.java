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
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class CareerJunctionService {

    @Async("task3")
    public CompletableFuture<Set<JobResponseDTO>> careerJunction(JobScrapeRequest request) throws IOException {
        System.out.println("Career Junction start" + Thread.currentThread().getName());
        Set<JobResponseDTO> responseDTOS = new HashSet<>();
        String url = "https://www.careerjunction.co.za/jobs/results?keywords="+request.getField().replaceAll(" ","%20")+"&location="+request.getLocation().replaceAll(" ", "%20");
        Document doc = Jsoup.connect(url).get();
        Elements elements = doc.getElementsByClass("module job-result  ");
        for (Element el: elements) {
            try {
                Elements title = el.getElementsByClass("job-result-title");
                Elements logo = el.getElementsByClass("job-result-logo-title");
                Elements overview = el.getElementsByClass("job-overview");
                if (title.isEmpty()) continue;
                Elements titleA = title.get(0).getElementsByTag("a");
                if (titleA.isEmpty()) continue;
                String subtitle = null;
                String link = null;
                if (titleA.size() == 2) {
                    subtitle = titleA.get(1).ownText();
                    link = titleA.get(1).attr("href");
                }
                String location = null;
                String salary = null;
                String imgLink = null;

                if (!overview.isEmpty()) {
                    Elements locationEl = overview.get(0).getElementsByClass("location");
                    if (!locationEl.isEmpty()) {
                        location = locationEl.get(0).getElementsByTag("a").get(0).ownText();
                    }
                    Elements salaryEl = overview.get(0).getElementsByClass("salary");
                    if (!salaryEl.isEmpty()) {
                        salary = salaryEl.get(0).ownText();
                    }
                }

                Elements imgEl = el.getElementsByTag("img");
                if (!imgEl.isEmpty()) {
                    imgLink = "https://www.careerjunction.co.za"+ imgEl.get(0).attr("src");
                } else {
                    imgLink = "https://mir-s3-cdn-cf.behance.net/projects/404/8f446a164156565.Y3JvcCwxMzgwLDEwODAsMjcwLDA.jpg";
                }
                responseDTOS.add(
                        JobResponseDTO.builder()
                                .title(Objects.requireNonNull(titleA.first()).ownText())
                                .link(url+link)
                                .location(location)
                                .subTitle(subtitle)
                                .salary(salary)
                                .imgLink("https://www.iitpsa.org.za/wp-content/uploads/2012/07/CJ_Logo_Master.jpg")
                                .build()
                );

            } catch (Exception e) {
                System.out.println("Invalid Response");
            }

        }
        return CompletableFuture.completedFuture(
                responseDTOS
        );
    }
}
