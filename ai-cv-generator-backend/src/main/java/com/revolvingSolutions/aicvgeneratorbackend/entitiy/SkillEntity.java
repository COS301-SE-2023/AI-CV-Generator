package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

import com.fasterxml.jackson.annotation.JsonBackReference;
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
@Table(name="skill")
public class SkillEntity {
    @Id
    @GeneratedValue
    public Integer skillid;

    @ManyToOne()
    @JoinColumn(name = "uid", referencedColumnName = "userid")
    @JsonBackReference
    public UserEntity user;

    public String skill;

    public Integer level;

    public String reason;
}
