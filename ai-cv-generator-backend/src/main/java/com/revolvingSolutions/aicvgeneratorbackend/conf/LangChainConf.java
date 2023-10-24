package com.revolvingSolutions.aicvgeneratorbackend.conf;


import com.revolvingSolutions.aicvgeneratorbackend.agent.*;
import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.JobClassification;
import dev.langchain4j.classification.EmbeddingModelTextClassifier;
import dev.langchain4j.classification.TextClassifier;
import dev.langchain4j.data.document.Document;
import dev.langchain4j.data.document.DocumentSplitter;
import dev.langchain4j.data.document.splitter.DocumentSplitters;
import dev.langchain4j.data.embedding.Embedding;
import dev.langchain4j.data.segment.TextSegment;
import dev.langchain4j.memory.chat.MessageWindowChatMemory;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.embedding.EmbeddingModel;
import dev.langchain4j.model.moderation.ModerationModel;
import dev.langchain4j.model.openai.OpenAiChatModel;
import dev.langchain4j.model.openai.OpenAiEmbeddingModel;
import dev.langchain4j.model.openai.OpenAiModerationModel;
import dev.langchain4j.model.openai.OpenAiTokenizer;
import dev.langchain4j.retriever.EmbeddingStoreRetriever;
import dev.langchain4j.retriever.Retriever;
import dev.langchain4j.service.AiServices;
import dev.langchain4j.store.embedding.EmbeddingStore;
import dev.langchain4j.store.embedding.EmbeddingStoreIngestor;
import dev.langchain4j.store.embedding.inmemory.InMemoryEmbeddingStore;
import dev.langchain4j.store.embedding.pinecone.PineconeEmbeddingStore;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;

import java.io.IOException;
import java.time.Duration;
import java.util.HashMap;
import java.util.List;

import static dev.langchain4j.data.document.FileSystemDocumentLoader.loadDocument;
import static dev.langchain4j.model.openai.OpenAiModelName.GPT_3_5_TURBO;
import static dev.langchain4j.model.openai.OpenAiModelName.TEXT_EMBEDDING_ADA_002;

@Configuration
@RequiredArgsConstructor
public class LangChainConf {

    @Value("${langchain4j.chat-model.openai.api-key}")
    private String apikey;
    @Value("${langchain4j.chat-model.openai.model-name}")
    private String modelName;

    @Value("${langchain4j.chat-model.openai.temperature}")
    private Double temperature;

    @Value("${app.api.embed.information}")
    private Boolean embed;

    @Value("${app.api.embedding.key}")
    private String embedKey;

    @Value("${app.api.embedding.environment}")
    private String environment;

    @Value("${app.api.embedding.index}")
    private String index;

    @Value("${app.api.embedding.project.id}")
    private String projectId;

    @Bean
    public ChatLanguageModel chatLanguageModel() {
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

    public ChatLanguageModel extractionChatLanguageModel() {
        return OpenAiChatModel.builder()
                .modelName(modelName)
                .apiKey(apikey)
                .temperature(temperature)
                .logRequests(true)
                .logResponses(true)
                .maxRetries(2)
                .maxTokens(3000)
                .topP(1.0)
                .timeout(Duration.ofMinutes(3))
                .frequencyPenalty(0.0)
                .presencePenalty(0.0)
                .build();
    }

    @Bean
    public DescriptionAgent descriptionAgent(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(DescriptionAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withMaxMessages(3))
                .build();
    }

    @Bean
    public EmploymentHistoryExpander employmentHistoryExpander(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(EmploymentHistoryExpander.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withMaxMessages(3))
                .build();
    }

    @Bean
    public EducationDescriptionAgent educationDescriptionAgent(ChatLanguageModel chatLanguageModel) {
        return AiServices.builder(EducationDescriptionAgent.class)
                .chatLanguageModel(chatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withMaxMessages(3))
                .build();
    }

    @Bean
    public ExtractionAgent extractionAgent(ChatLanguageModel extractionChatLanguageModel) {
        return AiServices.builder(ExtractionAgent.class)
                .chatLanguageModel(extractionChatLanguageModel)
                .chatMemory(MessageWindowChatMemory.withMaxMessages(5))
                .build();
    }

    @Bean
    public EmbeddingModel embeddingModel() {
        return OpenAiEmbeddingModel.builder()
                .apiKey(apikey)
                .logRequests(false)
                .logResponses(false)
                .modelName(TEXT_EMBEDDING_ADA_002)
                .build();
    }

    @Bean
    public Retriever<TextSegment> retriever(EmbeddingStore<TextSegment> embeddingStore, EmbeddingModel embeddingModel) {
        return EmbeddingStoreRetriever.from(embeddingStore,embeddingModel,1,0.9);
    }
    @Bean
    public EmbeddingStore<TextSegment> embeddingStore(EmbeddingModel embeddingModel, ResourceLoader resourceLoader) throws IOException {
        EmbeddingStore<TextSegment> embeddingStore = PineconeEmbeddingStore.builder()
                .apiKey(embedKey)
                .environment(environment)
                .index(index)
                .nameSpace("")
                .projectId(projectId)
                .build();
        if (embed) return embeddingStore;
        try {
            EmbeddingStoreIngestor.builder()
                    .documentSplitter(DocumentSplitters.recursive(100,new OpenAiTokenizer(GPT_3_5_TURBO)))
                    .embeddingStore(embeddingStore)
                    .embeddingModel(embeddingModel)
                    .build()
                    .ingest(loadDocument(resourceLoader.getResource("classpath:data.txt").getFile().toPath()));
        } catch (Exception e) {
            System.out.println("Warning Something has BADLY gone Wrong!");
        }
        return embeddingStore;
    }

    @Bean
    public ModerationModel moderationModel() {
        return OpenAiModerationModel.withApiKey(apikey);
    }

    @Bean
    public TextClassifier<JobClassification> jobMap(EmbeddingModel embeddingModel) {
        HashMap<JobClassification, List<String>> map = new HashMap<>();
        map.put(
                JobClassification.engineering,
                List.of(
                        "Analytical Thinker",
                        "Problem Solver",
                        "Innovative Designer",
                        "Detail-Oriented Professional",
                        "Technical Expert",
                        "Team Player",
                        "Creative Solution Provider",
                        "Continuous Learner",
                        "Critical Thinker",
                        "Precision Engineer"
                )
        );
        map.put(
                JobClassification.business,
                List.of(
                        "Strategic Thinker",
                        "Effective Communicator",
                        "Team Leader",
                        "Analytical Mindset",
                        "Financial Acumen",
                        "Negotiation Skills",
                        "Decision Maker",
                        "Adaptable to Change",
                        "Problem Solver",
                        "Customer-Centric"
                )
        );
        map.put(
                JobClassification.computer_science,
                List.of(
                        "Algorithm Expert",
                        "Coding Guru",
                        "Problem-Solving Pro",
                        "Data Science Enthusiast",
                        "Cybersecurity Whiz",
                        "AI and Machine Learning Aficionado",
                        "Software Development Maestro",
                        "Database Wizard",
                        "Web Development Prodigy",
                        "Networking Ninja"
                )
        );
        map.put(
                JobClassification.architecture,
                List.of(
                        "Creative Designer",
                        "Spatial Thinker",
                        "Detail-Oriented Planner",
                        "Innovative Problem Solver",
                        "Technically Proficient",
                        "Team Player",
                        "Sustainable Design Advocate",
                        "Continuous Learner",
                        "Critical Evaluator",
                        "Master of Form and Function"
                )
        );
        map.put(
                JobClassification.finance,
                List.of(
                        "Analytical Thinker",
                        "Risk Management Expert",
                        "Financial Strategist",
                        "Data-Driven Decision Maker",
                        "Detail-Oriented Analyst",
                        "Investment Savvy",
                        "Regulatory Compliance Specialist",
                        "Effective Communicator",
                        "Problem-Solving Guru",
                        "Economic Trend Interpreter"
                )
        );
        map.put(
                JobClassification.education,
                List.of(
                        "Passionate Educator",
                        "Innovative Curriculum Developer",
                        "Dedicated Mentor",
                        "Lifelong Learner",
                        "Student-Centered Advocate",
                        "Effective Classroom Manager",
                        "Tech-Savvy Instructor",
                        "Research-Driven Scholar",
                        "Collaborative Team Player",
                        "Compassionate Listener"
                )
        );
        map.put(
                JobClassification.law,
                List.of(
                        "Analytical Legal Mind",
                        "Expert Researcher",
                        "Effective Communicator",
                        "Detail-Oriented",
                        "Strong Advocate",
                        "Critical Thinker",
                        "Negotiation Skills",
                        "Legal Writing Proficiency",
                        "Ethical and Professional",
                        "Strategic Problem Solver"
                )
        );
        return new EmbeddingModelTextClassifier<JobClassification>(embeddingModel, map);
    }
}
