package com.revolvingSolutions.aicvgeneratorbackend.conf;

import jakarta.servlet.Filter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.*;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecureConf {
    private final AuthFilter authentificationFilter;
    private final AuthenticationProvider authProvider;

    @Bean
    public SecurityFilterChain secureFilterChain(HttpSecurity httpSecure) throws Exception{
        httpSecure
                .csrf(
                        new Customizer<CsrfConfigurer<HttpSecurity>>() {
                            @Override
                            public void customize(CsrfConfigurer<HttpSecurity> httpSecurityCsrfConfigurer) {
                                httpSecurityCsrfConfigurer.disable();
                            }
                        }
                )
                .cors(new Customizer<CorsConfigurer<HttpSecurity>>() {
                    @Override
                    public void customize(CorsConfigurer<HttpSecurity> httpSecurityCorsConfigurer) {
                        
                    }
                })
                .authorizeHttpRequests(
                        new Customizer<AuthorizeHttpRequestsConfigurer<org.springframework.security.config.annotation.web.builders.HttpSecurity>.AuthorizationManagerRequestMatcherRegistry>() {
                            @Override
                            public void customize(AuthorizeHttpRequestsConfigurer<HttpSecurity>.AuthorizationManagerRequestMatcherRegistry authorizationManagerRequestMatcherRegistry) {
                                authorizationManagerRequestMatcherRegistry
                                        .requestMatchers("/api/auth/**","/share/**")
                                        .permitAll()
                                        .anyRequest()
                                        .authenticated();
                            }
                        }
                )
                .sessionManagement(new Customizer<SessionManagementConfigurer<HttpSecurity>>() {
                    @Override
                    public void customize(SessionManagementConfigurer<HttpSecurity> httpSecuritySessionManagementConfigurer) {
                        httpSecuritySessionManagementConfigurer
                                .sessionCreationPolicy(
                                        SessionCreationPolicy.STATELESS
                                );
                    }
                })
                .authenticationProvider(
                    authProvider
                )
                .addFilterBefore(
                        authentificationFilter, UsernamePasswordAuthenticationFilter.class
                );


        return httpSecure.build();
    }
}
