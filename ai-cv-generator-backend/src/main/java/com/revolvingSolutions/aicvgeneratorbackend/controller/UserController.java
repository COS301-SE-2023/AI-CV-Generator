package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path = "api/User")
public class UserController {
    @Autowired
    UserService service;

    @RequestMapping(value="user",method = RequestMethod.GET)
    public String getUser() {
        return "";
    }

    @RequestMapping(value="user",method = RequestMethod.POST)
    public String updateUser() {
        return "";
    }
    @RequestMapping(value="file",method = RequestMethod.POST)
    public String uploadFile() {
        return "";
    }

    @RequestMapping(value="file",method = RequestMethod.GET)
    public String getFile() {
        return "";
    }

}
