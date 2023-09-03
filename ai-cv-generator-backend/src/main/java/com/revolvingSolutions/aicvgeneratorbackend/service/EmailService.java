package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.model.email.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender javaMailSender;
    @Value("${spring.mail.username}")
    private String revolvingSolsEmail;

    public String sendMail(Email email) {
        try {
            SimpleMailMessage mailMessage = new SimpleMailMessage();
            mailMessage.setFrom(revolvingSolsEmail);
            mailMessage.setTo(email.getRecipient());
            mailMessage.setText(email.getMessageBody());
            mailMessage.setSubject(email.getSubject());
            javaMailSender.send(mailMessage);
            return "Mail SENT";
        } catch (Exception e) {
            return "Error...";
        }
    }
}
