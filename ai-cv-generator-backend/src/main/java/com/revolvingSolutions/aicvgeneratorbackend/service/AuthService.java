package com.revolvingSolutions.aicvgeneratorbackend.service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.time.Instant;
import java.util.Date;
import java.util.HashMap;
import java.util.function.Function;

@Service
public class AuthService {

    @Value("${app.tokenExpire-factor}")
    private String expFactor;

    @Value("${app.key}")
    private String key;

    public String getUsername(String token) {
        return extractCl(token,Claims::getSubject);
    }

    public String getClientIP(String token) {
        return extract(token).get("ip", String.class);
    }

    private Claims extract(String token) {
        return Jwts.parserBuilder().setSigningKey(
                getKey()
        ).build().parseClaimsJws(
                token
        ).getBody();
    }

    public <T> T extractCl(String token, Function<Claims,T> resolver) {
        final Claims cl = extract(token);
        return  resolver.apply(cl);
    }

    private Key getKey() {
        byte[] bytes = Decoders.BASE64.decode(key);
        return Keys.hmacShaKeyFor(bytes);
    }

    public String genToken(
            UserDetails details,
            String ip
    ) {
        HashMap<String,Object> Claims = new HashMap<>();
        Claims.put("ip",ip);
        return Jwts
                .builder()
                .setClaims(Claims)
                .setSubject(details.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 1000L *60 *Integer.parseInt(expFactor)))
                .signWith(getKey(),SignatureAlgorithm.HS512)
                .compact();
    }

    public boolean validate(String token,UserDetails details) {
        final String name = getUsername(token);
        if (!name.equals(details.getUsername())) return false;
        return !isExpired(token);
    }

    public boolean invalidate(String token,UserDetails details) {
        final String name = getUsername(token);
        if (!name.equals(details.getUsername())) return false;
        final Claims cl = extract(token);
        cl.setExpiration(Date.from(Instant.now()));

        return true;
    }

    private boolean isExpired(String token) {
        return getExpirationDate(token).before(new Date());
    }

    private Date getExpirationDate(String token) {
        return extractCl(token, Claims::getExpiration);
    }

}
