package com.iflytek.utils;

public class StringUtils {
    public static String toUpcaseFirst(String name) {
        //首字母大写
        char[] cs = name.toCharArray();
        cs[0] -= 32; // a 97 A 65
        return String.valueOf(cs);
    }

}
