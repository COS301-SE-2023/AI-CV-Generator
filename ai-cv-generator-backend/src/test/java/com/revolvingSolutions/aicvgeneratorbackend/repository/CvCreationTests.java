package com.revolvingSolutions.aicvgeneratorbackend.repository;
import com.revolvingSolutions.aicvgeneratorbackend.model.User;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;


//import org.springframework.boot.test.context.SpringBootTest;

//@SpringBootTest
class CvCreationTests {
    User user;
    
    @Test
    void testGenerateCV() { 
        user = new User(null, null);
        assertEquals(true, user.generateCV("Jane", "Doe", "jd@gmail.com", "0812345678", "Pretoria"));
    }

    @Test
    void testImportCV() {
        user = new User(null, null);
        assertEquals(true, user.importCV(".../MyCV.pdf"));
    }
}
