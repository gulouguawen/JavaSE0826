package com.iflytek.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CommonUtils {
    private static SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSSS");

    public static String generatorOrderNo() {
        String prefix = "IFLYTEK";
        String suffix = Math.round(Math.floor(Math.random() * 10)) + "";
        return prefix + format.format(new Date()) + suffix;
    }

    public static void main(String[] args) {
        System.out.println(generatorOrderNo());
    }
}
