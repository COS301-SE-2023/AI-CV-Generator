package com.revolvingSolutions.aicvgeneratorbackend.response.details.skill;

import com.revolvingSolutions.aicvgeneratorbackend.model.user.Skill;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UpdateSkillResponse {
    List<Skill> skills;
}
