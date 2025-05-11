package com.rh_app.hr_app.core.email;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import com.rh_app.hr_app.features.calendar.event.model.Event;
import net.fortuna.ical4j.model.Calendar;
import net.fortuna.ical4j.model.component.VEvent;
import net.fortuna.ical4j.model.property.*;
import net.fortuna.ical4j.data.CalendarOutputter;
import org.springframework.core.io.ByteArrayResource;

import net.fortuna.ical4j.model.DateTime;

import java.io.ByteArrayOutputStream;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.Date;

@Service
@RequiredArgsConstructor
public class MailService {

    private final JavaMailSender mailSender;
    private static final Logger log = LoggerFactory.getLogger(MailService.class);


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
            log.debug("Activation URL created: {}", activationUrl);


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
            log.debug("Sending activation email");
            mailSender.send(message);
            log.info("Activation email sent successfully to: {}", toEmail);


        } catch (MessagingException e) {
            log.error("Failed to send activation email to {}: {}", toEmail, e.getMessage(), e);
            throw new RuntimeException("❌ Failed to send activation email", e);
        }

    }

    // method to your existing MailService class for event notifications
    public void sendEventNotification(Event event, String recipientEmail) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            helper.setFrom(fromEmail);
            helper.setTo(recipientEmail);

            String importanceFlag = "";
            if ("high".equalsIgnoreCase(event.getImportance())) {
                importanceFlag = "🔴 ";
                message.setHeader("X-Priority", "1"); // High priority
            }

            helper.setSubject(importanceFlag + event.getTitle());

            String timeInfo = event.isAllDay() ? "All day" :
                    event.getStartTime() + " - " + event.getEndTime();

            // Build HTML content
            String content = """
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #ddd; padding: 20px; border-radius: 5px;">
                <h2 style="color: #333;">%s</h2>
                <p><strong>Date:</strong> %s</p>
                <p><strong>Time:</strong> %s</p>
                %s
                %s
                <p><strong>Importance:</strong> <span style="color: %s;">%s</span></p>
                <hr style="border: 0; border-top: 1px solid #eee;">
                <p style="font-size: 12px; color: #777;">This is an automated notification from the HR Application Calendar.</p>
            </div>
        """.formatted(
                    event.getTitle(),
                    event.getDate(),
                    timeInfo,
                    event.getLocation() != null && !event.getLocation().isEmpty() ? "<p><strong>Location:</strong> " + event.getLocation() + "</p>" : "",
                    event.getDescription() != null && !event.getDescription().isEmpty() ? "<p><strong>Description:</strong> " + event.getDescription() + "</p>" : "",
                    "high".equals(event.getImportance()) ? "red" : "medium".equals(event.getImportance()) ? "orange" : "green",
                    event.getImportance()
            );

            helper.setText(content, true);

            // Attach ICS calendar file
            ByteArrayResource icsAttachment = generateICalendar(event);
            helper.addAttachment("event.ics", icsAttachment);

            mailSender.send(message);
            log.info("Event notification email sent to: {}", recipientEmail);

        } catch (Exception e) {
            log.error("Failed to send event notification email to {}: {}", recipientEmail, e.getMessage(), e);
            throw new RuntimeException("Failed to send event notification email", e);
        }
    }

    private ByteArrayResource generateICalendar(Event event) {
        try {
            Calendar calendar = new Calendar();
            calendar.getProperties().add(new ProdId("-//HR Application//Calendar//EN"));
            calendar.getProperties().add(Version.VERSION_2_0);
            calendar.getProperties().add(CalScale.GREGORIAN);

            // Convert local date/time to ical4j DateTime objects
            Date startDate = convertToDate(event.getDate(),
                    event.isAllDay() ? LocalTime.MIN : event.getStartTime());
            Date endDate = convertToDate(event.getDate(),
                    event.isAllDay() ? LocalTime.MAX : event.getEndTime());

            // Create DateTime objects for ical4j
            net.fortuna.ical4j.model.DateTime start = new net.fortuna.ical4j.model.DateTime(startDate);
            net.fortuna.ical4j.model.DateTime end = new net.fortuna.ical4j.model.DateTime(endDate);

            // Create the event with proper start/end times
            VEvent vEvent = new VEvent();
            vEvent.getProperties().add(new DtStart(start));
            vEvent.getProperties().add(new DtEnd(end));
            vEvent.getProperties().add(new Summary(event.getTitle()));
            vEvent.getProperties().add(new Uid(event.getId().toString()));

            if (event.getDescription() != null) {
                vEvent.getProperties().add(new Description(event.getDescription()));
            }

            if (event.getLocation() != null) {
                vEvent.getProperties().add(new Location(event.getLocation()));
            }

            calendar.getComponents().add(vEvent);

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            CalendarOutputter outputter = new CalendarOutputter();
            outputter.output(calendar, baos);

            return new ByteArrayResource(baos.toByteArray());
        } catch (Exception e) {
            log.error("Failed to generate ICS file: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to generate calendar invitation", e);
        }
    }

    private Date convertToDate(LocalDate date, LocalTime time) {
        return Date.from(date.atTime(time)
                .atZone(ZoneId.systemDefault())
                .toInstant());
    }
}
