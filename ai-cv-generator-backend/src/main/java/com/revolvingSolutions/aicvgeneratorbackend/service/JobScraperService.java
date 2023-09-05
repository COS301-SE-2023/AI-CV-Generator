package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.exception.UnknownErrorException;
import com.revolvingSolutions.aicvgeneratorbackend.model.webscrapper.JobResponseDTO;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.webscraper.JobScrapeRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.webscraper.JobScrapeResponse;
import lombok.RequiredArgsConstructor;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class JobScraperService {

    private final UserRepository userRepository;

    private UserEntity getAuthenticatedUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof AnonymousAuthenticationToken)) {
            String currentUserName = authentication.getName();
            var user_ = userRepository.findByUsername(currentUserName).orElseThrow();
            return user_;
        }
        throw new UnknownErrorException("This should not be possible");
    }
    public JobScrapeResponse getRecommended() {
        return scrapData(
          JobScrapeRequest.builder()
                  .field(getAuthenticatedUser().getDescription())
                  .location(getAuthenticatedUser().getLocation())
                  .build()
        );
    }
    public JobScrapeResponse scrapData(
        JobScrapeRequest request
    ) {
        Set<JobResponseDTO> responseDTOS = new HashSet<>();
        try {
            responseDTOS.addAll(linkedIn(request));
            //responseDTOS.addAll(indeed(request));
            //responseDTOS.addAll(simplyHired(request));
            responseDTOS.addAll(careerBuilder(request));
            responseDTOS.addAll(snagAJob(request));
            return JobScrapeResponse.builder()
                    .jobs(responseDTOS)
                    .build();
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Bad request with scraper");
        }
    }

    private Set<JobResponseDTO> linkedIn(JobScrapeRequest request) throws IOException {
        Set<JobResponseDTO> responseDTOS = new HashSet<>();
        Document doc = Jsoup.connect("https://za.linkedin.com/jobs/search?keywords="+request.getField().replaceAll(" ","%20")+"&location="+request.getLocation().replaceAll(" ", "%20")+"&geoId=100001436&trk=public_jobs_jobs-search-bar_search-submit&position=1&pageNum=0").get();
        Element list = doc.getElementsByClass("jobs-search__results-list").first();
        Elements listelements = doc.getElementsByTag("li");
        for (Element el : listelements) {
            if (el.getElementsByClass("base-search-card__title").isEmpty() || el.getElementsByClass("base-search-card__subtitle").isEmpty() || el.getElementsByClass("job-search-card__location").isEmpty()) {
                continue;
            }
            Element link = el.getElementsByClass("hidden-nested-link").first();
            responseDTOS.add(
                    JobResponseDTO.builder()
                            .title(el.getElementsByClass("base-search-card__title").first().ownText())
                            .subTitle(link.ownText())
                            .link(link.attr("href"))
                            .location(el.getElementsByClass("job-search-card__location").first().ownText())
                            .build()
            );
        }
        return responseDTOS;
    }

    private Set<JobResponseDTO> indeed(JobScrapeRequest request) throws IOException {
        Set<JobResponseDTO> responseDTOS = new HashSet<>();
        String keywords = request.getField().replaceAll(" ","+");
        String location = request.getLocation().replaceAll(" ","+");
        Connection.Response res = Jsoup.connect("https://za.indeed.com/jobs?q="+keywords+"&l="+location)
                .followRedirects(false)
                .timeout(0)
                .method(Connection.Method.GET)
                .header("User-Agent", "Mozilla/5.0")
                .execute();

        String loc = res.header("Location");
        res = Jsoup.connect("https://za.indeed.com/jobs?q="+keywords+"&l="+location)
                .timeout(0)
                .data("is_check", "1")
                .method(Connection.Method.POST)
                .header("User-Agent", "Mozilla/5.0")
                .header("Referer", loc)
                .execute();

        Document doc = res.parse();
        Element list = doc.getElementById("mosaic-provider-jobcards");
        Elements els = list.getElementsByTag("li");
        for (Element el : els) {
            Element tag = el.getElementsByTag("a").first();
            Element title = el.getElementsByTag("span").first();
            responseDTOS.add(
                    JobResponseDTO.builder()
                            .title(title.ownText())
                            .link(tag.attr("href"))
                            .subTitle(el.getElementsByClass("companyName").first().ownText()+" "+el.getElementsByClass("companyLocation").first().ownText())
                            .build()
            );
        }
        return  responseDTOS;
    }

    private Set<JobResponseDTO> simplyHired(JobScrapeRequest request) throws IOException {
        Set<JobResponseDTO> responseDTOS = new HashSet<>();
        Document doc = Jsoup.connect("https://www.simplyhired.com/search?q="+request.getField().replaceAll(" ","+")+"&l="+request.getLocation().replaceAll(" ","+")).get();
        Element list = doc.getElementById("job-list");
        if (list == null) {
            return null;
        }
        Elements els = list.getElementsByTag("li");
        for (Element el : els) {
            Element titleLink = el.getElementsByTag("a").first();

            responseDTOS.add(
                    JobResponseDTO.builder()
                            .title(titleLink.ownText())
                            .link(titleLink.attr("href"))
                            .subTitle(el.getElementsByAttributeValue("data-testid","companyName").first().ownText())
                            .build()
            );
        }

        return  responseDTOS;
    }

    private Set<JobResponseDTO> careerBuilder(JobScrapeRequest request) throws IOException {
        Set<JobResponseDTO> responseDTOS = new HashSet<>();
        return  responseDTOS;
    }

    private Set<JobResponseDTO> snagAJob(JobScrapeRequest request) throws IOException {
        Set<JobResponseDTO> responseDTOS = new HashSet<>();
        return  responseDTOS;
    }

}
