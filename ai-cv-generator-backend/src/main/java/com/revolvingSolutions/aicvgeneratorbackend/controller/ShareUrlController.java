package com.revolvingSolutions.aicvgeneratorbackend.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(value="*")
@RequestMapping(path = "/api/Share")
@RequiredArgsConstructor
public class ShareUrlController {
}
