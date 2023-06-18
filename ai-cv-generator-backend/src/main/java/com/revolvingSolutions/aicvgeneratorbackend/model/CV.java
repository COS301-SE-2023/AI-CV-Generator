package com.revolvingSolutions.aicvgeneratorbackend.model;
import java.util.ArrayList;

public class CV {
    //Idea: Each section of the CV (personal, educational etc) is a collection of information items
    
    public String name;
    public String sname;
    public String email;
    public String cell;
    public String region;

    public boolean success = false;

    public CV() {
        name = "";
        sname = "";
        email = "";
        cell = "";
        region = "";
    }

    public boolean editPersonalDetails(String n, String sn, String em, String c, String city) {
        name = n;
        sname = sn;
        email = em;
        cell = c;
        region = city;

        success = true;
        return success;
    }

    public boolean exportCV () {
        //Some operation to convert the CV to pdf format if it iasn't already
        //Some operations to save the CV to the device or share it via email (and on linkedin)         
        success = true;
        return success;
    }
}
