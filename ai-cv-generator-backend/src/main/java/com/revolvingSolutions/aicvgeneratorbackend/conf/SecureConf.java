package com.revolvingSolutions.aicvgeneratorbackend.conf;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.CorsConfigurer;
import org.springframework.security.config.annotation.web.configurers.CsrfConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.csrf.CsrfTokenRequestAttributeHandler;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

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
                        }
//                        (csrf) ->
//                                csrf.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
//                                        .csrfTokenRequestHandler(new CsrfTokenRequestAttributeHandler())
                )
                .cors(
                        new Customizer<CorsConfigurer<HttpSecurity>>() {
                            @Override
                            public void customize(CorsConfigurer<HttpSecurity> httpSecurityCorsConfigurer) {
//                                UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
//                                CorsConfiguration configuration = new CorsConfiguration();
//                                configuration.setMaxAge(3600L);
//                                configuration.setAllowedMethods(
//                                        Arrays.asList(
//                                                HttpMethod.GET.name(),
//                                                HttpMethod.POST.name(),
//                                                HttpMethod.PUT.name(),
//                                                HttpMethod.OPTIONS.name()
//                                        )
//                                );
//                                configuration.addAllowedOriginPattern("http://localhost:**");
//                                source.registerCorsConfiguration("/**", configuration);
//                                httpSecurityCorsConfigurer.configurationSource(source);
                            }
                        }
//                        (cors) ->
//                                cors.configurationSource(configurationSource())
                )
                .authorizeHttpRequests(
                        (authorizationManagerRequestMatcherRegistry) ->
                                authorizationManagerRequestMatcherRegistry
                                        .requestMatchers("/api/auth/**","/share/**","/csrf")
                                        .permitAll()
                                        .anyRequest()
                                        .authenticated()
                )
                .sessionManagement(
                        (sessionManagement) ->
                            sessionManagement.sessionCreationPolicy(
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
                        (logout) ->
                                logout.addLogoutHandler(
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

    @Bean
    public CorsConfigurationSource configurationSource() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setMaxAge(3600L);
        configuration.setAllowedMethods(
                Arrays.asList(
                        HttpMethod.GET.name(),
                        HttpMethod.POST.name(),
                        HttpMethod.PUT.name(),
                        HttpMethod.OPTIONS.name()
                )
        );
        configuration.addAllowedOriginPattern("http://localhost:**");
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
