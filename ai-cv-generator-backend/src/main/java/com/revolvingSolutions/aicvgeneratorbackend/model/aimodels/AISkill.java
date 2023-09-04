package com.revolvingSolutions.aicvgeneratorbackend.model.aimodels;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AISkill {
    public String skill;
    public String level;
    public String reason;
}
