package com.revolvingSolutions.aicvgeneratorbackend.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

//Will have to do with actual generation of the CV
@RestController
@CrossOrigin(value="*")
@RequestMapping(path = "/generate")
@RequiredArgsConstructor
public class GenerationController {

}
