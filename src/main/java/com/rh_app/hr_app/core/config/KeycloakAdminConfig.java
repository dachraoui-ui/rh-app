package com.rh_app.hr_app.core.config;

import org.keycloak.OAuth2Constants;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class KeycloakAdminConfig {

    @Bean
    public Keycloak keycloakAdminClient() {
        return KeycloakBuilder.builder()
                .serverUrl("http://localhost:9090")
                .realm("RH-Realm") // your actual realm
                .clientId("admin-cli") // or your custom service account client
                .grantType(OAuth2Constants.PASSWORD)
                .username("ahmed")
                .password("ahmed")
                .build();
    }
}
