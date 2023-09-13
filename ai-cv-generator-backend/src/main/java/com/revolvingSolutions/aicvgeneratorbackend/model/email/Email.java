package com.revolvingSolutions.aicvgeneratorbackend.model.email;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Email {
    private String recipient;
    private String messageBody;
    private String subject;
    private String attachment;
}
