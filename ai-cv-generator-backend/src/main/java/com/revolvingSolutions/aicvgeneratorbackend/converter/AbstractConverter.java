package com.revolvingSolutions.aicvgeneratorbackend.converter;

import jakarta.persistence.AttributeConverter;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import static io.micrometer.common.util.StringUtils.isNotEmpty;

public abstract class AbstractConverter<T> implements AttributeConverter<T,String> {

    private EncryptionUtil util;

    public AbstractConverter() {
        this(new EncryptionUtil());
    }

    public AbstractConverter(EncryptionUtil util) {
        this.util = util;
    }

    @Override
    public String convertToDatabaseColumn(T attribute) {
        if (isNotNullOrEmpty(attribute)) {
            try {
                Cipher cipher =  util.prepareAndInitCipher(Cipher.ENCRYPT_MODE);
                return encrypt(cipher, attribute);
            } catch (NoSuchAlgorithmException | InvalidKeyException | InvalidAlgorithmParameterException | BadPaddingException | NoSuchPaddingException | IllegalBlockSizeException e) {
                throw new RuntimeException(e);
            }
        }
        return entityAttributeToString(attribute);
    }

    @Override
    public T convertToEntityAttribute(String dbData) {
        if (isNotEmpty(dbData)) {
            try {
                Cipher cipher = util.prepareAndInitCipher(Cipher.DECRYPT_MODE);
                return decrypt(cipher, dbData);
            } catch (NoSuchAlgorithmException | InvalidKeyException | InvalidAlgorithmParameterException | BadPaddingException | NoSuchPaddingException | IllegalBlockSizeException e) {
                throw new RuntimeException(e);
            }
        }
        return stringToEntityAttribute(dbData);
    }
    abstract boolean isNotNullOrEmpty(T attribute);

    abstract T stringToEntityAttribute(String dbData);

    abstract String entityAttributeToString(T attribute);

    byte[] callCipherDoFinal(Cipher cipher, byte[] bytes) throws IllegalBlockSizeException, BadPaddingException {
        return cipher.doFinal(bytes);
    }

    private String encrypt(Cipher cipher, T attribute) throws IllegalBlockSizeException, BadPaddingException {
        byte[] bytesToEncrypt = entityAttributeToString(attribute).getBytes();
        byte[] encryptedBytes = callCipherDoFinal(cipher, bytesToEncrypt);
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    private T decrypt(Cipher cipher, String dbData) throws IllegalBlockSizeException, BadPaddingException {
        byte[] encryptedBytes = Base64.getDecoder().decode(dbData);
        byte[] decryptedBytes = callCipherDoFinal(cipher, encryptedBytes);
        return stringToEntityAttribute(new String(decryptedBytes));
    }
}
