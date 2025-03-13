package com.rh_app.hr_app.core.config;



import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

import java.util.Arrays;
import java.util.List;

@Configuration
@RequiredArgsConstructor
public class BeanConfig {

    private final UserDetailsService userDetailsService;
    @Value("${application.cors.origins:*}")
    private List<String> allowedOrigins;


    @Bean
    public CorsFilter corsFilter() {
        final UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        final CorsConfiguration config = new CorsConfiguration();

        //config.setAllowCredentials(true);
        config.setAllowedOrigins(allowedOrigins); // Your Angular app URL and backend
        config.setAllowedHeaders(Arrays.asList("*")); // not recommended for production
        config.setAllowedMethods(Arrays.asList("*"));   // not recommended for production

        source.registerCorsConfiguration("/**", config);
        return new CorsFilter(source);
    }


}