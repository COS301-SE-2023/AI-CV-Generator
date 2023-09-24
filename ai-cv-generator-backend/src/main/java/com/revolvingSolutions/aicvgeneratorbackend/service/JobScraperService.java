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
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.Duration;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.atomic.AtomicInteger;


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
    public JobScrapeResponse getRecommended() throws ExecutionException, InterruptedException {
        User user = getAISafeModel();
        String field = fieldClassifier(fieldClassifierchatLanguageModel()).chat(descriptionAgent(chatLanguageModel()).chat(user.toString()));
        String location = "";
        if (user.getLocation()!=null) location = user.getLocation();
        return scrapData(
          JobScrapeRequest.builder()
                  .field("")
                  .location(location)
                  .amount(10)
                  .build()
        ).get();
    }

    private AtomicInteger amount;

    @Async
    public CompletableFuture<JobScrapeResponse> scrapData(
        JobScrapeRequest request
    ) {
        AtomicInteger amount = new AtomicInteger(request.getAmount());
        CareerJunctionService careerJunctionService = new CareerJunctionService();
        LinkedinService linkedinService = new LinkedinService();
        CareerBuildersService careerBuildersService = new CareerBuildersService();
        careerJunctionService.setJobCareerJunction(amount);
        linkedinService.setLinkedIn(amount);
        careerBuildersService.setCareerBuilders(amount);
        CompletableFuture<Set<JobResponseDTO>> linkedIn = null;
        CompletableFuture<Set<JobResponseDTO>> careerBuilders = null;
        CompletableFuture<Set<JobResponseDTO>> careerJunction = null;
        try {
            linkedIn = linkedinService.linkedIn(request);
        } catch (IOException e) {
            //throw new RuntimeException(e);
        }

        try {
            careerBuilders = careerBuildersService.CBRE(request);
        } catch (IOException e) {
            //throw new RuntimeException(e);
        }

        try {
            careerJunction = careerJunctionService.careerJunction(request);
        } catch (IOException e) {
            //throw new RuntimeException(e);
        }
        try {
            CompletableFuture.allOf(linkedIn,careerBuilders,careerJunction).join();
            Set<JobResponseDTO> responseDTOS = new HashSet<>();
            responseDTOS.addAll(linkedIn.get());
            responseDTOS.addAll(careerBuilders.get());
            responseDTOS.addAll(careerJunction.get());
            return CompletableFuture.completedFuture(
                    JobScrapeResponse.builder()
                            .jobs(responseDTOS)
                            .build()
            );
        } catch (ExecutionException | InterruptedException e) {
            return CompletableFuture.completedFuture(
                    JobScrapeResponse.builder()
                            .jobs(new HashSet<>())
                            .build()
            );
        }
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


