package com.revolvingSolutions.aicvgeneratorbackend.repository;
import com.revolvingSolutions.aicvgeneratorbackend.model.User;
import com.revolvingSolutions.aicvgeneratorbackend.model.CV;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class ProfileModificationTests {
    User user;

    @Test
    void testDeleteCV() {
        user = new User("Jane", "Doe");
        user.cv = new CV();
        assertEquals(true, user.deleteCV(user.cv));
    }
}
