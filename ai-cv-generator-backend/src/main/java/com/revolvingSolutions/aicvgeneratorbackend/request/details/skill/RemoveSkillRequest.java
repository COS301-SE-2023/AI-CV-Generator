package com.revolvingSolutions.aicvgeneratorbackend.request.details.skill;

import com.revolvingSolutions.aicvgeneratorbackend.model.user.Skill;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RemoveSkillRequest  {
    private Skill skill;
}
