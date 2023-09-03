package com.revolvingSolutions.aicvgeneratorbackend.model.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Skill {
    public Integer skillid;
    public String skill;
    public Integer level;
    public String reason;
}
