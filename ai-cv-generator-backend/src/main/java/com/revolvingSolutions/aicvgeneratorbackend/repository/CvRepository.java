package com.revolvingSolutions.aicvgeneratorbackend.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.CvEntity;

public interface CvRepository extends JpaRepository<CvEntity, String> {
    
}