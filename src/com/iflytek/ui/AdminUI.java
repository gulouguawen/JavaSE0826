package com.iflytek.ui;

import java.util.Scanner;

public class AdminUI {
    private Scanner sc;

    public AdminUI(Scanner sc) {
        this.sc = sc;
    }

    public void init() {
        System.out.println("欢迎进入管理员界面");
        System.out.println("【操作】：【1】录入商品分类【2】录入商品\n请输入您要的操作：");
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
