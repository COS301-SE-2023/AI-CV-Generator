package com.revolvingSolutions.aicvgeneratorbackend.converter;

import jakarta.persistence.Converter;

@Converter
public class StringConverter extends AbstractConverter<String> {

    public StringConverter() {
        this(new EncryptionUtil());
    }

    public StringConverter(EncryptionUtil util) {
        super(util);
    }
    @Override
    boolean isNotNullOrEmpty(String attribute) {
        return attribute != null && !attribute.matches("");
    }

    @Override
    String stringToEntityAttribute(String dbData) {
        return dbData;
    }

    @Override
    String entityAttributeToString(String attribute) {
        return attribute;
    }
}
