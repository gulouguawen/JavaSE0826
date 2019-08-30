package com.iflytek.ui;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import com.iflytek.service.UserService;

/**
 * 讲解一下debug的使用
 * 以我们授课的错误示例来讲解（出现的错误）
 * 1.在代码中打入断点
 * 2.使用debug模式进行运行程序
 * 3.查询错误并解决（给出一个解决思路）：系统错误、设计错误、代码错误、参数错误、运行结果的错误
 * 设计错误：设计人员设计思路之后，代码无法实现，实现会出错，无法解决
 */
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
         * 1) 登录功能  如果已经登录，不需要重复登录
         * 2) 用户名密码失败三次，1分钟内不允许登录
         */
        System.out.println("欢迎使用XXX商城系统");
        Map<String, Integer> lgLoseMap = new HashMap<String, Integer>();

        while (true) {
            // 判断条件：currentUser对象有没有被赋值；赋值：说明已经登录过了 没有赋值：还没有登录。
            /**
             *  思考：
             *  1. 找判断条件  --》 如何判断用户已经登录？
             *        定义一个flag 定义进入管理员界面或者普通用户界面的判断条件 int rlt
             *  2. Map<Boolean, Integer> ---> 好用？ true  1/2   false   1/2
             *  3. 能不能不定义变量就能搞定呢？
             *  	UserService.getCurrentUesr() 有一个当前登录用户，此时是否有值就能够判断用户是否已经登录
             *              用户登录的信息全部在用户变量
             *
             *  下次遇到类似的问题：如何去思考?  思考方法
             */
            if (UserService.getCurrentUesr() == null) {
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
            }

            int rlt = UserService.getCurrentUesr().getType();
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
