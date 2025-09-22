package com.taplamweb.event;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.MessageSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.taplamweb.domain.User;
import com.taplamweb.service.IUserService;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

public class ResetPasswordListener implements ApplicationListener<OnResetPasswordEvent> {
    @Autowired
    private IUserService service;

    @Autowired
    private MessageSource messages;

    @Autowired
    private JavaMailSender mailSender;

    @Override
    public void onApplicationEvent(OnResetPasswordEvent event) {
        this.confirmUser(event);
    }

    private void confirmUser(OnResetPasswordEvent event) {
        User user = event.getUser();
        System.out.println("----------------------------------------");
        String token = UUID.randomUUID().toString();
        service.createVerificationToken(user, token);

        String recipientAddress = user.getEmail();
        String subject = "GetPassword Confirmation";
        String confirmationUrl = event.getAppUrl() + "/userConfirm?token=" + token;
        String message = messages.getMessage("message.valid", null, event.getLocale());
        MimeMessage mes = mailSender.createMimeMessage();
        String content = """
                    <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border-radius: 8px; background-color: #f9f9f9; text-align: center;">
                        <h2 style="color: #333;">%s</h2>
                        <p style="font-size: 16px; color: #555;">%s</p>
                        <a href="%s" style="display: inline-block; margin: 20px 0; padding: 10px 20px; font-size: 16px; color: #fff; background-color: #007bff; text-decoration: none; border-radius: 5px;">Proceed</a>
                        <p style="font-size: 14px; color: #777;">Or copy and paste this link into your browser:</p>
                        <p style="font-size: 14px; color: #007bff;">%s</p>
                        <p style="font-size: 12px; color: #aaa;">This is an automated message. Please do not reply.</p>
                    </div>
                """
                .formatted(subject, "Click bellow to confirm", confirmationUrl, confirmationUrl);
        try {
            MimeMessageHelper helper = new MimeMessageHelper(mes, true);
            helper.setTo(recipientAddress);
            helper.setSubject(message);
            helper.setText(content, true);
            mailSender.send(mes);
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
}
