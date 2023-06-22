package com.revolvingSolutions.aicvgeneratorbackend.service;

import org.springframework.stereotype.Service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.CvEntity;
import com.revolvingSolutions.aicvgeneratorbackend.repository.CvRepository;

import org.springframework.beans.factory.annotation.Autowired;



@Service
public class CvService {

    @Autowired
    CvRepository cvRepository;

    public String addCV(CvEntity cv)
    {
        cvRepository.save(cv);
        return "CV added successfully";
    }

    public String deleteCV(CvEntity cv)
    {
        try{
            if(((CvRepository) cv).existsById(cv.getUserid()))
            {
                cvRepository.delete(cv);
                return "CV deleted successfully";
            }
        }
        catch(Exception e){}
        return null;
    }

    public String updateCV(CvEntity cv)
    {
        try{
            if(((CvRepository) cv).existsById(cv.getUserid()))
            {
                cvRepository.save(cv);
                return "CV updated successfully";
            }
        }
        catch(Exception e){}
        return null;
    }

    /*public String getName() {
        return "Name";
    }

    public String getLastname() {
        return "Lastname";
    }*/
}
