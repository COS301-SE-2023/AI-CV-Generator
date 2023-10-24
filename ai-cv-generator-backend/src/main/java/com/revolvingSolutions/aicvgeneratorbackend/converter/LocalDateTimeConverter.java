package com.revolvingSolutions.aicvgeneratorbackend.converter;

import jakarta.persistence.Converter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Converter
public class LocalDateTimeConverter extends AbstractConverter<LocalDateTime> {

    public LocalDateTimeConverter() {
        this(new EncryptionUtil());
    }

    public LocalDateTimeConverter(EncryptionUtil util) {
        super(util);
    }

    @Override
    boolean isNotNullOrEmpty(LocalDateTime attribute) {
        return attribute != null;
    }

    @Override
    LocalDateTime stringToEntityAttribute(String dbData) {
        return dbData.matches("") ? null : LocalDateTime.parse(dbData, DateTimeFormatter.ISO_DATE);
    }

    @Override
    String entityAttributeToString(LocalDateTime attribute) {
        return attribute == null ? null : attribute.format(DateTimeFormatter.ISO_DATE);
    }
}
