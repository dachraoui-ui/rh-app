package com.rh_app.hr_app.core.websocket.config;

import com.rh_app.hr_app.core.websocket.security.JwtHandshakeInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.*;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws-chat")          // ← handshake URL
                .setAllowedOriginPatterns("*")    // dev-mode CORS
                .addInterceptors(new JwtHandshakeInterceptor())  // see §1.3
                .withSockJS();                    // XHR fallback
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableSimpleBroker("/topic", "/queue");
        registry.setApplicationDestinationPrefixes("/app");
        registry.setUserDestinationPrefix("/user");
    }
}
