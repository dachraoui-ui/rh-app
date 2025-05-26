package com.rh_app.hr_app.core.websocket.security;



import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.security.oauth2.jwt.*;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.*;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.Map;

@Component
@RequiredArgsConstructor
public class JwtHandshakeInterceptor implements HandshakeInterceptor {

    private final JwtDecoder jwtDecoder;

    @Override
    public boolean beforeHandshake(ServerHttpRequest req,
                                   ServerHttpResponse res,
                                   WebSocketHandler wsHandler,
                                   Map<String, Object> attrs) {

        String token = UriComponentsBuilder.fromUri(req.getURI())
                .build()
                .getQueryParams()
                .getFirst("access_token");
        try {
            Jwt jwt = jwtDecoder.decode(token);   // validates signature/exp/issuer
            attrs.put("SPRING.AUTH", new JwtAuthenticationToken(jwt));
            return true;
        } catch (JwtException ex) {
            res.setStatusCode(HttpStatus.UNAUTHORIZED);
            return false;
        }
    }
    @Override public void afterHandshake(ServerHttpRequest r, ServerHttpResponse s,
                                         WebSocketHandler h, Exception e) {}
}
