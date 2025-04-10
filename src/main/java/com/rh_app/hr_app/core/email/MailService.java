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

    // These may be unused if you're no longer linking directly to Keycloak,
    // but we'll keep them if you need them for other email links:
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

            // 1) Construct a link to your Angular app's "activate" page
            // e.g. http://localhost:4200/activate?tempPw=someTempPassword
            // The Angular route can then trigger Keycloak login for the user.
            String activationUrl = "http://localhost:4200/activate?tempPw=" + tempPassword;

            // 2) Build the HTML message
            // Keycloak sees the user's password is temporary -> forces password update
            String content = """
                <p>Hello,</p>
                <p>Your account has been created successfully. Please use the following temporary password:</p>
                <p><strong>Password:</strong> %s</p>
                <p>Click the link below to activate your account and set a new password:</p>
                <p>
                  <a href="%s">Activate Your Account</a>
                </p>
                <br>
                <p>Regards,<br/>RH Team</p>
                """.formatted(tempPassword, activationUrl);

            helper.setText(content, true);
            mailSender.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException("❌ Failed to send activation email", e);
        }
    }
}
