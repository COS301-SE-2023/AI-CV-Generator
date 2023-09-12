package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.email.Email;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;

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

    public void sendVerificationEmail(String userEmail,String name, String siteURL, String verificationCode) throws MessagingException, UnsupportedEncodingException {
        String fromAddress = "solutionsrevolving@gmail.com";
        String senderName = "Revolving Solutions";
        String subject = "Please verify your registration";
        String content =
                "Dear [[name]],<br>"
                + "Please click the link below to verify your registration:<br>"
                + "<h3><a href=\"[[URL]]\" target=\"_self\">VERIFY</a></h3>"
                + "Thank you,<br>"
                + "Revolving Solutions.";

        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);

        helper.setFrom(fromAddress, senderName);
        helper.setTo(userEmail);
        helper.setSubject(subject);

        content = content.replace("[[name]]", (name));
        String verifyURL = siteURL + "/verify?code=" + verificationCode;

        content = content.replace("[[URL]]", verifyURL);

        helper.setText(content, true);

        javaMailSender.send(message);
    }

    public void sendPasswordResetEmail(String userEmail,String name, String siteURL, String passwordResetCode) throws MessagingException, UnsupportedEncodingException {
        String fromAddress = "solutionsrevolving@gmail.com";
        String senderName = "Revolving Solutions";
        String subject = "Reset Password";
        String content =
                "Dear [[name]],<br>"
                        + "Please click the link below to reset your password:<br>"
                        + "<h3><a href=\"[[URL]]\" target=\"_self\">RESET</a></h3>"
                        + "Thank you,<br>"
                        + "Revolving Solutions.";

        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);

        helper.setFrom(fromAddress, senderName);
        helper.setTo(userEmail);
        helper.setSubject(subject);

        content = content.replace("[[name]]", (name));
        String verifyURL = siteURL + "/reset?code=" + passwordResetCode;

        content = content.replace("[[URL]]", verifyURL);

        helper.setText(content, true);

        javaMailSender.send(message);
    }
}
