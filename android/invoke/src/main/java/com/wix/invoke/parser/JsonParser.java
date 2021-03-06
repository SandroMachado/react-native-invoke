package com.wix.invoke.parser;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;

/**
 * Created by rotemm on 13/10/2016.
 */
public class JsonParser {

    public static <T> T parse(Object object, Class<T> valueType) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.convertValue(object, valueType);
        } catch (IllegalArgumentException e) {
            throw new RuntimeException(e);
        }
    }

    public static <T> T parse(String jsonData, Class<T> valueType) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.readValue(jsonData, valueType);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
