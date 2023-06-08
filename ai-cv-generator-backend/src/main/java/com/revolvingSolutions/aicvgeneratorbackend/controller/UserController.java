package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path = "/api/User")
public class UserController {
    @Autowired
    UserService service;

    @GetMapping(value="/user")
    public String getUser() {
        return "";
    }

    @PostMapping(value="/user")
    public String updateUser() {
        return "";
    }
    @PostMapping(value="/file")
    public String uploadFile() {
        return "";
    }

    @GetMapping(value="/file")
    public String getFile() {
        return "";
    }

    @GetMapping(value = "test")
    public ResponseEntity<String> test() {
        return ResponseEntity.ok("Hello auth is working");
    }

}
