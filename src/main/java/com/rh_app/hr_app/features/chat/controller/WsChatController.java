package com.rh_app.hr_app.features.chat.controller;


import com.rh_app.hr_app.features.chat.dto.WsChatMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;

@Controller
public class WsChatController {

    @PreAuthorize("isAuthenticated()")
    @MessageMapping("chat.sendMessage")
    @SendTo("/topic/public")
    public WsChatMessage sendMessage(@Payload WsChatMessage msg)  {
        System.out.println("Message received: " + msg.getSender() + " : " + msg.getContent());
        return msg;
    }

    @PreAuthorize("isAuthenticated()")
    @MessageMapping("chat.addUser")
    @SendTo("/topic/chat")
    public WsChatMessage addUser(@Payload WsChatMessage msg , SimpMessageHeaderAccessor headerAccessor)  {
        // Add username in web socket session
        headerAccessor.getSessionAttributes().put("username", msg.getSender());
        System.out.println("User added: " + msg.getSender());

        return msg;

    }

}
