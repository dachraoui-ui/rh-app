package com.rh_app.hr_app.core.WebSocket.config;


import com.rh_app.hr_app.features.chat.dto.WsChatMessage;
import com.rh_app.hr_app.features.chat.dto.WsChatMessageType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

@Component
@RequiredArgsConstructor
@Slf4j
public class WsEventListener {
    private final SimpMessageSendingOperations messageSendingOperations;

    @EventListener
    public void handleWsDisconnectListener(SessionDisconnectEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        String username = (String) headerAccessor.getSessionAttributes().get("username");
       if (username != null) {
           log.info("User Disconnected : {} " , username);
           var message = WsChatMessage.builder()
                   .type(WsChatMessageType.LEAVE)
                     .sender(username)
                   .build();
           // pass the message to the broker
           messageSendingOperations.convertAndSend("/topic/public", message);
       }


    }
}
