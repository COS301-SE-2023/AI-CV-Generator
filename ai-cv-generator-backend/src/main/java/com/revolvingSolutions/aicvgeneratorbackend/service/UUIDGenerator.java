package com.revolvingSolutions.aicvgeneratorbackend.service;

import org.springframework.stereotype.Service;

import java.util.UUID;

//Might just get rid of this
@Service
public class UUIDGenerator {
    public UUID generateID(){
        return UUID.randomUUID();
    }
}
