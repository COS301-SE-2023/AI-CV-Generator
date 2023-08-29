package com.revolvingSolutions.aicvgeneratorbackend.model.user;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Reference {
    public Integer refid;
    public String description;
    public String contact;
}
