package com.revolvingSolutions.aicvgeneratorbackend.repository;
import com.revolvingSolutions.aicvgeneratorbackend.model.User;
import com.revolvingSolutions.aicvgeneratorbackend.model.CV;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class ModificationTests {
    User user;

    @Test
    void testEditPersonalDetails() {
        user = new User("Jane", "Doe");
        user.cv = new CV();
        assertEquals(true, user.cv.editPersonalDetails("Jane", "Doe-Smith", "jd@gmail.com", "0812345678", "Cape Town"));
    }

    @Test
    void testExportCV() {
        user = new User("Jane", "Doe");
        user.cv = new CV();
        user.cv.editPersonalDetails("Jane", "Doe-Smith", "jd@gmail.com", "0812345678", "Cape Town");
        assertEquals(true, user.cv.exportCV());
    }
    
    @Test
    void testDeleteCV() {
        user = new User("Jane", "Doe");
        user.cv = new CV();
        assertEquals(true, user.deleteCV(user.cv));
    }
}
