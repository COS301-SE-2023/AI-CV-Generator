package com.revolvingSolutions.aicvgeneratorbackend.service;

import org.springframework.stereotype.Service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.CvEntity;
import com.revolvingSolutions.aicvgeneratorbackend.repository.CvRepository;

import org.springframework.beans.factory.annotation.Autowired;



@Service
public class CvService {

    @Autowired
    CvRepository cvRepository;

    public void addCV(CvEntity cv)
    {
        cvRepository.save(cv);
    }

    public void deleteCV(CvEntity cv)
    {
        cvRepository.delete(cv);
    }

    public void updateCV(CvEntity cv)
    {
        try{
            if(((CvRepository) cv).existsById(cv.getUserid()))
            {
                cvRepository.save(cv);
            }
        }
        catch(Exception e){}
    }

    /*public String getName() {
        return "Name";
    }

    public String getLastname() {
        return "Lastname";
    }*/
}
