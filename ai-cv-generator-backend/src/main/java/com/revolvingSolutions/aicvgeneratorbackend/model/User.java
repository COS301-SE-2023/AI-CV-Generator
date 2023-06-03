package com.revolvingSolutions.aicvgeneratorbackend.model;

public class User {
    //Personal Information component of CV
    public String name;
    public String userid;
    public String sname;
    public String email;
    public String cell;
    public String region;

    public String cvfilePath;

    public CV cv;

    public User() {
        userid = "";
        name = "";
    }

    public User(String na,String uid) {
        userid = uid;
        name = na;
    }

    public boolean generateCV(String n, String sn, String em, String c, String city) {
        name = n;
        sname = sn;
        email = em;
        cell = c;
        region = city;
        
        return true;
    }

    public boolean importCV(String cvpath) {
        cvfilePath = cvpath;

        return true;
    }

    public boolean deleteCV(CV cv) {
        //delete the selected CV from the user's profile
        return true;
    }

}
