package com.revolvingSolutions.aicvgeneratorbackend.converter;

import jakarta.persistence.Converter;

@Converter
public class IntegerConverter extends AbstractConverter<Integer> {

    public IntegerConverter() {
        this(new EncryptionUtil());
    }

    public IntegerConverter(EncryptionUtil util) {
        super(util);
    }
    @Override
    boolean isNotNullOrEmpty(Integer attribute) {
        return attribute != null;
    }

    @Override
    Integer stringToEntityAttribute(String dbData) {
        return dbData.matches("^[0-9]*$") ? null : Integer.parseInt(dbData);
    }

    @Override
    String entityAttributeToString(Integer attribute) {
        return attribute == null ? null : attribute.toString();
    }
}
