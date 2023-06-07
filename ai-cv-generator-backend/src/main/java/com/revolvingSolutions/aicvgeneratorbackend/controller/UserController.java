package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.CrossOrigin;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping(path = "api/User")
public class UserController {

    @Autowired
    UserService service;

    @RequestMapping(value = "/retrieve",method = RequestMethod.GET)
    public String getUserName() {
        return service.getUsername();
    }

    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public String get() {
        return service.getUsername();
    }
}
