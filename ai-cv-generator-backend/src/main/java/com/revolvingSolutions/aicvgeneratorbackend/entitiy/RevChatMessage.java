package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.revolvingSolutions.aicvgeneratorbackend.converter.StringConverter;
import dev.langchain4j.data.message.ChatMessageType;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity()
@Table(name = "chatMessage")
public class RevChatMessage {
    @Id
    @GeneratedValue
    private long chatMessageId;

    @ManyToOne()
    @JoinColumn(name = "chatMemId", referencedColumnName = "chatMemId")
    @JsonBackReference
    private ChatMemory chatMemory;

    @Column(nullable = false)
    private ChatMessageType type;

    @Convert(converter = StringConverter.class)
    @Column(nullable = false)
    private String message;
}
