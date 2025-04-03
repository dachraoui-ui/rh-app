package com.rh_app.hr_app.core.security;

import org.keycloak.adapters.springboot.KeycloakSpringBootConfigResolver;
import org.keycloak.adapters.springsecurity.KeycloakConfiguration;
import org.keycloak.adapters.springsecurity.authentication.KeycloakAuthenticationProvider;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.authority.mapping.SimpleAuthorityMapper;
import org.springframework.security.web.authentication.session.NullAuthenticatedSessionStrategy;
import org.springframework.security.web.authentication.session.SessionAuthenticationStrategy;

@Configuration
@KeycloakConfiguration
public class KeycloakConfig {

    /**
     * Configures Keycloak to use Spring Boot configuration properties.
     */
    @Bean
    public KeycloakSpringBootConfigResolver keycloakConfigResolver() {
        return new KeycloakSpringBootConfigResolver();
    }

    /**
     * Configures the Keycloak authentication provider.
     * Maps Keycloak roles to Spring Security roles.
     */
    @Bean
    public KeycloakAuthenticationProvider keycloakAuthenticationProvider() {
        KeycloakAuthenticationProvider keycloakAuthenticationProvider = new KeycloakAuthenticationProvider();
        SimpleAuthorityMapper authorityMapper = new SimpleAuthorityMapper();
        authorityMapper.setPrefix("ROLE_");
        authorityMapper.setConvertToUpperCase(true);
        keycloakAuthenticationProvider.setGrantedAuthoritiesMapper(authorityMapper);
        return keycloakAuthenticationProvider;
    }

    /**
     * Disables session management as Keycloak handles sessions.
     */
    @Bean
    protected SessionAuthenticationStrategy sessionAuthenticationStrategy() {
        return new NullAuthenticatedSessionStrategy();
    }

}
