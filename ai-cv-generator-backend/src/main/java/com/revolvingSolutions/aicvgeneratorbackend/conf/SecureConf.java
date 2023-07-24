package com.revolvingSolutions.aicvgeneratorbackend.conf;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.*;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.csrf.CsrfTokenRequestAttributeHandler;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecureConf {
    private final AuthFilter authentificationFilter;
    private final AuthenticationProvider authProvider;
    private final LogoutHandler logoutHandler;

    @Bean
    public SecurityFilterChain secureFilterChain(HttpSecurity httpSecure) throws Exception{
        httpSecure
                .csrf(
                        new Customizer<CsrfConfigurer<HttpSecurity>>() {
                            @Override
                            public void customize(CsrfConfigurer<HttpSecurity> httpSecurityCsrfConfigurer) {
                                if (false) {
                                    httpSecurityCsrfConfigurer.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse());
                                    httpSecurityCsrfConfigurer.csrfTokenRequestHandler(new CsrfTokenRequestAttributeHandler());
                                } else {
                                    httpSecurityCsrfConfigurer.disable();
                                }
                            }
                        }                )
                .cors(new Customizer<CorsConfigurer<HttpSecurity>>() {
                    @Override
                    public void customize(CorsConfigurer<HttpSecurity> httpSecurityCorsConfigurer) {

                    }
                })
                .authorizeHttpRequests(
                        (authorizationManagerRequestMatcherRegistry) ->
                                authorizationManagerRequestMatcherRegistry
                                        .requestMatchers("/api/auth/**","/share/**","/csrf")
                                        .permitAll()
                                        .anyRequest()
                                        .authenticated()
                )
                .sessionManagement(
                        (httpSecuritySessionManagementConfigurer) ->
                            httpSecuritySessionManagementConfigurer.sessionCreationPolicy(
                                    SessionCreationPolicy.STATELESS
                            )
                )
                .authenticationProvider(
                    authProvider
                )
                .addFilterBefore(
                        authentificationFilter, UsernamePasswordAuthenticationFilter.class
                )
                .logout(
                        (httpSecurityLogoutConfigurer) ->
                                httpSecurityLogoutConfigurer.addLogoutHandler(
                                        logoutHandler
                                )
                                        .logoutSuccessHandler(
                                                (
                                                        (request, response, authentication) ->
                                                                SecurityContextHolder.clearContext()
                                                )
                                        )
                                        .logoutUrl("/api/auth/logout")
                );

        return httpSecure.build();
    }
}
