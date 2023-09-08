package com.revolvingSolutions.aicvgeneratorbackend.response.AI;

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
public class ChatResponse {
    private List<String> messages;
}
