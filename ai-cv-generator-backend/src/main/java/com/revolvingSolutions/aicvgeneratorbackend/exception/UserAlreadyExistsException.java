package com.revolvingSolutions.aicvgeneratorbackend.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.FORBIDDEN)
public class UserAlreadyExistsException extends RuntimeException{
    private static final long serialVersionUID = 1L;

    public UserAlreadyExistsException(String message) {
        super(String.format("Failed ", message));
    }
}
