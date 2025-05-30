package com.rh_app.hr_app.features.chat.dto;


import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WsChatMessage {
    private String sender;
    private String content;
    private WsChatMessageType type;
}
