package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity()
@Table(name="chatMemory")
public class ChatMemory {

    @Id
    @GeneratedValue
    private long chatMemId;

    @OneToOne()
    @JoinColumn(name = "uid", referencedColumnName = "userid")
    @JsonBackReference
    private UserEntity user;

    @Column(nullable = false)
    @Basic(optional = false)
    private LocalDateTime expireAt;

    @OneToMany(mappedBy = "chatMemory", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<RevChatMessage> messages;
}
