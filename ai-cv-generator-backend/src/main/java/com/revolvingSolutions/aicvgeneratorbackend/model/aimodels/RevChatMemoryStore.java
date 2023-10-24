package com.revolvingSolutions.aicvgeneratorbackend.model.aimodels;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.ChatMemory;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.RevChatMessage;
import com.revolvingSolutions.aicvgeneratorbackend.repository.ChatMemoryRepository;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.data.message.SystemMessage;
import dev.langchain4j.data.message.UserMessage;
import dev.langchain4j.store.memory.chat.ChatMemoryStore;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RevChatMemoryStore implements ChatMemoryStore {

    private final ChatMemoryRepository repository;
    private final UserService userService;

    private int maxMessages;

    private long expirePeriod;

    @Override
    public List<ChatMessage> getMessages(Object userId) {
        ChatMemory memory = getChatMemory(userId);
        return  from(memory.getMessages());
    }

    @Override
    public void updateMessages(Object userId, List<ChatMessage> list) {
        ChatMemory memory = getChatMemory(userId);
        memory.setMessages(
                to(list,userId)
        );
        repository.save(
                memory
        );
    }

    @Override
    public void deleteMessages(Object userId) {
        ChatMemory memory = getChatMemory(userId);
        memory.setMessages(new ArrayList<>());
    }

    private List<RevChatMessage> to(List<ChatMessage> messages, Object userId) {
        List<RevChatMessage> revChatMessages = new ArrayList<>();
        for (ChatMessage message: messages) {
            revChatMessages.add(
                    toIndividual(message,userId)
            );
        }
        return revChatMessages;
    }

    private RevChatMessage toIndividual(ChatMessage message,Object userId) {
        return RevChatMessage.builder()
                .type(message.type())
                .message(message.text())
                .chatMemory(getChatMemory(userId))
                .build();
    }

    private List<ChatMessage> from(List<RevChatMessage> messages) {
        List<ChatMessage> chatMessages = new ArrayList<>();
        for (RevChatMessage message : messages) {
            chatMessages.add(
                    fromIndividual(message)
            );
        }
        return chatMessages;
    }

    private ChatMessage fromIndividual(RevChatMessage message) {
        return switch (message.getType()) {
            case SYSTEM -> new SystemMessage(message.getMessage());
            case USER -> new UserMessage(message.getMessage());
            default -> new AiMessage(message.getMessage());
        };
    }

    private ChatMemory getChatMemory(Object userId) {
        return repository.findByUserUserid((Integer) userId).orElseThrow();
    }

}
