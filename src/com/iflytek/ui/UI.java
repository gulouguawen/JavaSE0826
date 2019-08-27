package com.iflytek.ui;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import com.iflytek.service.UserService;

public class UI {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        UserService userService = new UserService();

        /**
         * 1. 登录界面
         * 2. 管理员界面
         * 3. 普通用户界面
         */


        // 业务分解： 登录功能
        /**
         * 1) 登录功能  如果已经登录，不需要重复登录  --- 放到最后做
         * 2) 用户名密码失败三次，1分钟内不允许登录
         */
        System.out.println("欢迎使用XXX商城系统");
        Map<String, Integer> lgLoseMap = new HashMap<String, Integer>();

        while (true) {
            System.out.println("请输入您的用户名：");
            String username = sc.nextLine();
            System.out.println("请输入您的密码：");
            String password = sc.nextLine();

            // 查询
            int rlt = userService.login(username, password);
            if (rlt == 0) {
                System.out.println("登录失败，请重新登录");
                Integer times = lgLoseMap.get(username); // list 存  取？ 用户名，用户登录失败次数
                if (times == null) {
                    lgLoseMap.put(username, 1);
                } else if (times == 3) {
                    try {
                        System.out.println("您已经失败了三次，请等一分钟再试......");
                        Thread.sleep(60 * 1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    lgLoseMap.put(username, 0);
                } else {
                    lgLoseMap.put(username, times + 1);
                }
                continue;
            }

            if (rlt == 1) {
                System.out.println("恭喜你，登录成功，将要跳转到普通用户界面");
                // 调用普通用户的界面
                new UserUI(sc).init();
            } else if (rlt == 2) {
                System.out.println("恭喜你，登录成功，将要跳转到管理员界面");
                // 调用管理员的界面
                new AdminUI(sc).init();
            } else {
                System.out.println("系统异常，请联系管理员");
                System.exit(0);//退出系统
                break;
            }
        }
    }
}
