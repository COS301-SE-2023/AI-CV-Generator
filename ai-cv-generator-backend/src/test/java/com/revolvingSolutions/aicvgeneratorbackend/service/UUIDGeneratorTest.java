package com.revolvingSolutions.aicvgeneratorbackend.service;

import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.UUID;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

class UUIDGeneratorTest {

    @Test
    void generateID() {
        ArrayList<String> uuids = new ArrayList<String>();
        uuids.add(UUID.randomUUID().toString());
        Boolean hasPassed = true;
        for (int n=0; n<1000;n++) {
            UUID uuid = UUID.randomUUID();
            if (uuids.contains(uuid.toString())) {
                hasPassed = false;
                break;
            }
            uuids.add(uuid.toString());
        }
        assertThat(hasPassed).isTrue();
    }
}