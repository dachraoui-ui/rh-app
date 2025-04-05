package com.rh_app.hr_app.core.email;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MailService {

    private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromEmail;

    @Value("${keycloak.admin.server-url}")
    private String keycloakBaseUrl;

    @Value("${keycloak.admin.realm}")
    private String realm;

    public void sendAccountActivationEmail(String toEmail, String tempPassword) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            helper.setFrom(fromEmail);
            helper.setTo(toEmail);
            helper.setSubject("🔐 Activate Your Account");

            // 👇 The redirect link to update credentials (directs to Keycloak login with forced password update)
            String content = """
                    <p>Hello,</p>
                    <p>Your account has been created successfully. Please use the following temporary password:</p>
                    <p><strong>Password:</strong> %s</p>
                    <p>Click the link below to log in and change your password:</p>
                    <p>
                      <a href="%s/realms/%s/account">Update Password</a>
                    </p>
                    <br>
                    <p>Regards,<br/>RH Team</p>
                    """.formatted(tempPassword, keycloakBaseUrl, realm);

            helper.setText(content, true);
            mailSender.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException("❌ Failed to send activation email", e);
        }
    }
}
