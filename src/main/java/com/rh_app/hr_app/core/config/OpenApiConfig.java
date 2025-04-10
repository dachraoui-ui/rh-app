package com.rh_app.hr_app.core.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeIn;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import io.swagger.v3.oas.annotations.servers.Server;

@OpenAPIDefinition(
        info = @Info(
                contact = @Contact(
                        name = "Rayen Ben Othman / Ahmed dachraoui",
                        email = "rayen.benothman07@gmail.com ; dachraouia193@gmail.com",
                        url = "https://www.linkedin.com/in/benothman-rayen"

                ),
                description = "OpenAPI documentation for RH_APP using Keycloak",
                title = "MYNDS_HR Documentation",
                version = "1.0",
                license = @License(
                        name = "Apache 2.0",
                        url = "https://www.apache.org/licenses/LICENSE-2.0"
                ),
                termsOfService = "https://your-company.com/terms"
        ),
        servers = {
                @Server(
                        description = "Local Environment",
                        url = "http://localhost:8083/api"
                ),
                @Server(
                        description = "Production Environment",
                        url = "https://mynds-team.com"
                )
        },
        security = {
                @SecurityRequirement(
                        name = "KeycloakAuth"
                )
        }
)
@SecurityScheme(
        name = "KeycloakAuth",
        description = "Keycloak Authentication with JWT",
        scheme = "bearer",
        type = SecuritySchemeType.HTTP,
        bearerFormat = "JWT",
        in = SecuritySchemeIn.HEADER
)
public class OpenApiConfig {

}