package com.rh_app.hr_app.core.security;

import jakarta.annotation.Nonnull;

import org.springframework.core.convert.converter.Converter;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

import java.util.*;
import java.util.stream.Collectors;

public class KeycloakJwtAuthenticationConverter implements Converter<Jwt, AbstractAuthenticationToken> {

    private static final Set<String> ALLOWED_ROLES = Set.of("DRH", "GRH", "EMPLOYEE","INTERN");

    @Override
    public AbstractAuthenticationToken convert(@Nonnull Jwt jwt) {
        Collection<GrantedAuthority> authorities = extractRealmRoles(jwt);
        return new JwtAuthenticationToken(jwt, authorities);
    }

    private Collection<GrantedAuthority> extractRealmRoles(Jwt jwt) {
        Map<String, Object> realmAccess = jwt.getClaim("realm_access");
        if (realmAccess == null || realmAccess.get("roles") == null) return Collections.emptySet();

        List<String> roles = (List<String>) realmAccess.get("roles");

        return roles.stream()
                .filter(role -> ALLOWED_ROLES.contains(role.toUpperCase()))
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role.toUpperCase()))
                .collect(Collectors.toSet());
    }
}
