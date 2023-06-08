package com.revolvingSolutions.aicvgeneratorbackend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.CvEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.CV;
import com.revolvingSolutions.aicvgeneratorbackend.repository.CvRepository;

@RestController
@RequestMapping("/api/cv")
public class CvController {
    @Autowired
    private CvRepository cvRepository;
 
    @GetMapping
    public List<CvEntity> getCVs() {
        return cvRepository.findAll();
    }
 
    // other controller methods
}