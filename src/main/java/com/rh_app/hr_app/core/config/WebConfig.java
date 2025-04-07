package com.rh_app.hr_app.core.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")  // all endpoints
                .allowedOrigins("http://localhost:4200") // frontend
                .allowedMethods("*")
                .allowedHeaders("*");
    }
}
