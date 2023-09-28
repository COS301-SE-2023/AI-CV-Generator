package com.revolvingSolutions.aicvgeneratorbackend.repository;


import com.revolvingSolutions.aicvgeneratorbackend.entitiy.QualificationEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Qualification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface QualificationRepository extends JpaRepository<QualificationEntity,Integer> {
    @Query("SELECT new com.revolvingSolutions.aicvgeneratorbackend.model.user.Qualification(f.quaid,f.qualification,f.intstitution,f.date,f.endo) FROM QualificationEntity f WHERE f.user.username = ?1")
    public List<Qualification> getQualificationsFromUser(String username);
}
