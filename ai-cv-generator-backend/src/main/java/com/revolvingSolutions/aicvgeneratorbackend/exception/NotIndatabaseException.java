package com.revolvingSolutions.aicvgeneratorbackend.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND,code = HttpStatus.NOT_FOUND,reason = "Not in database")
public class NotIndatabaseException extends RuntimeException{
    private static final long serialVersionUID = 1L;

    public NotIndatabaseException(String message) {
        super(String.format("Failed ",message));
    }
}
