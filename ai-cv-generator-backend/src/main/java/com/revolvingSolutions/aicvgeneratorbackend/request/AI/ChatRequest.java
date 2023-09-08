package com.revolvingSolutions.aicvgeneratorbackend.request.AI;


import dev.langchain4j.data.message.ChatMessage;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ChatRequest {
    private List<String> messages;
    private String userMessage;
}
