package com.revolvingSolutions.aicvgeneratorbackend.converter;

import jakarta.persistence.Converter;

@Converter
public class LongConverter extends AbstractConverter<Long> {

    public LongConverter() {
        this(new EncryptionUtil());
    }

    public LongConverter(EncryptionUtil util) {
        super(util);
    }
    @Override
    boolean isNotNullOrEmpty(Long attribute) {
        return attribute != null;
    }

    @Override
    Long stringToEntityAttribute(String dbData) {
        return dbData.matches("^[0-9]*$") ? null : Long.parseLong(dbData);
    }

    @Override
    String entityAttributeToString(Long attribute) {
        return attribute == null ? null : attribute.toString();
    }
}
