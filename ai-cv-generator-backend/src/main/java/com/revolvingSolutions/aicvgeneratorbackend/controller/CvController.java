package com.revolvingSolutions.aicvgeneratorbackend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.CvEntity;
import com.revolvingSolutions.aicvgeneratorbackend.service.CvService;

@RestController
@CrossOrigin(origins = "*")
public class CvController {
    
    @Autowired
    CvService cvService;

    @PostMapping(value = "addCV")
    public void addCV(@RequestBody CvEntity cvEntity)
    {
        cvService.addCV(cvEntity);
    }

    @PostMapping(value = "updateCV")
    public void updateCV(@RequestBody CvEntity cvEntity)
    {
        cvService.updateCV(cvEntity);
    }

    @DeleteMapping(value = "deleteCV")
    public void deleteCV(@RequestBody CvEntity cvEntity)
    {
        cvService.deleteCV(cvEntity);
    }


}
