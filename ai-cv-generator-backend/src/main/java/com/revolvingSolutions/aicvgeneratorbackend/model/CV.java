package com.revolvingSolutions.aicvgeneratorbackend.model;
import java.util.ArrayList;

public class CV {
    //Idea: Each section of the CV (personal, educational etc) is a collection of information items
    public ArrayList<String> personalInformation;

    public CV() {
        personalInformation = new ArrayList<String>();
    }
}
