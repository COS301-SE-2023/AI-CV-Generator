package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.agent.DescriptionAgent;
import com.revolvingSolutions.aicvgeneratorbackend.agent.FieldClassifierAgent;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.exception.UnknownErrorException;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.User;
import com.revolvingSolutions.aicvgeneratorbackend.model.webscrapper.JobResponseDTO;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.webscraper.JobScrapeRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.webscraper.JobScrapeResponse;
import dev.langchain4j.memory.chat.MessageWindowChatMemory;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.openai.OpenAiChatModel;
import dev.langchain4j.service.AiServices;
import lombok.RequiredArgsConstructor;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.Duration;
import java.util.HashSet;
import java.util.Set;


@Service
@RequiredArgsConstructor
public class JobScraperService {

    private final UserRepository userRepository;
    private final UserService userService;

    private UserEntity getAuthenticatedUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof AnonymousAuthenticationToken)) {
            String currentUserName = authentication.getName();
            var user_ = userRepository.findByUsername(currentUserName).orElseThrow();
            return user_;
        }
        throw new UnknownErrorException("This should not be possible");
    }

    public User getAISafeModel() {
        return userService.getUser().getUser();
    }
    public JobScrapeResponse getRecommended() {
        User user = getAISafeModel();
        String field = fieldClassifier(fieldClassifierchatLanguageModel()).chat(descriptionAgent(chatLanguageModel()).chat(user.toString()));
        String location = "";
        if (user.getLocation()!=null) location = user.getLocation();
        return scrapData(
          JobScrapeRequest.builder()
                  .field("")
                  .location(location)
                  .build()
        );
    }
    public JobScrapeResponse scrapData(
        JobScrapeRequest request
    ) {
        Set<JobResponseDTO> responseDTOS = new HashSet<>();
        try {
            responseDTOS.addAll(linkedIn(request));
        } catch (IOException e) {
            System.out.println("LinkedIn failed");
        }

        try {
            responseDTOS.addAll(CBRE(request));
        } catch (IOException e) {
            System.out.println("CBRE failed");
        }

        try {
            responseDTOS.addAll(careerJunction(request));
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("CareerJunction failed");
        }

        return JobScrapeResponse.builder()
                .jobs(responseDTOS)
                .build();
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
                            .imgLink("https://static.vecteezy.com/system/resources/previews/018/930/587/original/linkedin-logo-linkedin-icon-transparent-free-png.png")
                            .location(el.getElementsByClass("job-search-card__location").first().ownText())
                            .build()
            );
        }
        return responseDTOS;
    }

    private Set<JobResponseDTO> CBRE(JobScrapeRequest request) throws IOException {
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
                if (subtitle!= null) continue;
                Elements spans = subtitle.getElementsByTag("span");
                String subTitle = "";
                for (Element ell: spans) {
                    subTitle+= ell.ownText();
                }
                String location = "Location";
                if (spans.size() >= 2) {
                    location = spans.get(2).ownText();
                }
                responseDTOS.add(
                        JobResponseDTO.builder()
                                .title(link.ownText())
                                .subTitle(subTitle)
                                .location(location)
                                .imgLink("https://careers.cbre.com/portal/4/images/socialShare.jpg")
                                .link(link.attr("href"))
                                .build()
                );
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("Response DTOs failed");
            }

        }
        return responseDTOS;
    }

    private Set<JobResponseDTO> careerJunction(JobScrapeRequest request) throws IOException {
        Set<JobResponseDTO> responseDTOS = new HashSet<>();
        Document doc = Jsoup.connect("https://www.careerjunction.co.za/jobs/results?keywords="+request.getField().replaceAll(" ","%20")+"&location="+request.getLocation().replaceAll(" ", "%20")).get();
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
                if (titleA.size() == 2) {
                    subtitle = titleA.get(1).ownText();
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
                                .title(titleA.first().ownText())
                                .link("/")
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
        return  responseDTOS;
    }

    private String getLogoImage(String link) {
        try {
            Document doc = Jsoup.connect(link).get();
            Elements elements = doc.getElementsByClass("cjun-logo-company");
            if (elements.isEmpty()) return "/";
            return elements.first().attr("src");
        } catch (IOException e) {
            return "/";
        }
    }

    private Set<JobResponseDTO> snagAJob(JobScrapeRequest request) throws IOException {
        Set<JobResponseDTO> responseDTOS = new HashSet<>();
        return  responseDTOS;
    }

    @Value("${langchain4j.chat-model.openai.api-key}")
    private String apikey;
    @Value("${langchain4j.chat-model.openai.model-name}")
    private String modelName;

    @Value("${langchain4j.chat-model.openai.temperature}")
    private Double temperature;

    private ChatLanguageModel fieldClassifierchatLanguageModel() {
        return OpenAiChatModel.builder()
                .modelName(modelName)
                .apiKey(apikey)
                .temperature(temperature)
                .logRequests(true)
                .logResponses(true)
                .maxRetries(2)
                .maxTokens(1000)
                .topP(1.0)
                .timeout(Duration.ofMinutes(3))
                .frequencyPenalty(0.0)
                .presencePenalty(0.0)
                .build();
    }

    private ChatLanguageModel chatLanguageModel() {
        return OpenAiChatModel.builder()
                .modelName(modelName)
                .apiKey(apikey)
                .temperature(temperature)
                .logRequests(true)
                .logResponses(true)
                .maxRetries(2)
                .maxTokens(1000)
                .topP(1.0)
                .timeout(Duration.ofMinutes(2))
                .frequencyPenalty(0.0)
                .presencePenalty(0.0)
                .build();
    }

    private FieldClassifierAgent fieldClassifier(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(FieldClassifierAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withMaxMessages(3))
                .build();
    }

    private DescriptionAgent descriptionAgent(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(DescriptionAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withMaxMessages(3))
                .build();
    }

}
