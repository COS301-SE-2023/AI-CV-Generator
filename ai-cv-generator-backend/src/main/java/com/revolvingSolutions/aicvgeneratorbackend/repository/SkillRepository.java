package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.SkillEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Skill;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface SkillRepository extends JpaRepository<SkillEntity,Integer> {
    @Query("SELECT new com.revolvingSolutions.aicvgeneratorbackend.model.user.Skill(f.skillid,f.skill,f.level,f.reason) FROM SkillEntity f WHERE f.user.username = ?1")
    public List<Skill> getSkillsFromUser(String username);
}
