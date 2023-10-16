package com.revolvingSolutions.aicvgeneratorbackend.converter;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;

@Component
public class EncryptionUtil {
    @Value("${app.encryption.name}")
    private String CIPHER_NAME;

    @Value("${app.encryption.algorithm}")
    private String SECRET_KEY_ALGORITHM;

    @Value("${app.encryption.key}")
    private String KEY;

    public Cipher prepareAndInitCipher(int encryptionMode) throws InvalidKeyException, NoSuchPaddingException, NoSuchAlgorithmException, InvalidAlgorithmParameterException {
        Cipher cipher = Cipher.getInstance(CIPHER_NAME != null ? CIPHER_NAME : "AES/CBC/PKCS5Padding");
        Key secretKey = new SecretKeySpec((KEY != null ? KEY : "aaaaaaaaaaaaaaaaaaaaaaaa").getBytes(),SECRET_KEY_ALGORITHM != null ? SECRET_KEY_ALGORITHM : "AES");
        AlgorithmParameterSpec algorithmParameters = getAlgorithmParameterSpec(cipher);

        callCipherInit(cipher, encryptionMode, secretKey, algorithmParameters);
        return cipher;
    }

    void callCipherInit(Cipher cipher, int encryptionMode, Key secretKey, AlgorithmParameterSpec algorithmParameters) throws InvalidKeyException, InvalidAlgorithmParameterException {

        cipher.init(encryptionMode, secretKey, algorithmParameters);
    }

    int getCipherBlockSize(Cipher cipher) {
        return cipher.getBlockSize();
    }

    private AlgorithmParameterSpec getAlgorithmParameterSpec(Cipher cipher) {
        byte[] iv = new byte[getCipherBlockSize(cipher)];
        return new IvParameterSpec(iv);
    }
}
