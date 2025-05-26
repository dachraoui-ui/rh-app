package com.rh_app.hr_app.core.websocket.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.messaging.*;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.stomp.*;
import org.springframework.messaging.support.*;
import org.springframework.web.socket.config.annotation.*;

import org.springframework.security.core.Authentication;

@Configuration
public class WsSecurityChannels implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureClientInboundChannel(ChannelRegistration reg) {
        reg.interceptors(new ChannelInterceptor() {
            @Override
            public Message<?> preSend(Message<?> message, @NonNull MessageChannel channel) {

                StompHeaderAccessor acc =
                        MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);

                // ↙ avoid potential NPE
                if (acc != null && StompCommand.CONNECT.equals(acc.getCommand())) {
                    Authentication auth =
                            (Authentication) acc.getSessionAttributes().get("SPRING.AUTH");
                    acc.setUser(auth);
                }
                return message;
            }
        });
    }
}

