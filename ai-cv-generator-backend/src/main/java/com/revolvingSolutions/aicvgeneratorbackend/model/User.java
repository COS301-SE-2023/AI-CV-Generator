package com.revolvingSolutions.aicvgeneratorbackend.model;

public class User {
    public String name;
    public String userid;

    public User() {
        userid = "";
        name = "";
    }

    public User(String na,String uid) {
        userid = uid;
        name = na;
    }
}
