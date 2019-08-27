package com.iflytek.ui;

import java.util.Scanner;

public class UserUI {
    private Scanner sc;

    public UserUI(Scanner sc) {
        this.sc = sc;
    }

    public void init() {
        System.out.println("欢迎进入普通用户界面");
        System.out.println("【操作】：【1】查询商品【2】下单\n请输入您要的操作：");
        String opt = sc.nextLine();

        switch (opt) {
            case "1":
                break;
            case "2":
                break;
            default:
                break;
        }
    }
}
