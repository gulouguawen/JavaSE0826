package com.iflytek.service;

import com.iflytek.dao.UserDao;
import com.iflytek.pojo.User;

public class UserService {
    private static User currentUser;
    private UserDao userDao = new UserDao();
    // 数组--》集合list--》set--》map
    // 存取：存：都可以，取：直接取   单系统（一次只允许一个用户登录）

    /**
     * 登录
     *
     * @param username
     * @param password
     * @return 2:管理员登录成功 1：普通用户登录成功， 0：登录失败
     */
    public int login(String username, String password) {
        User user = userDao.queryByUsernameAndPassword(username, password);
        if (user == null) {
            return 0;
        }
        currentUser = user;
        return user.getType();
    }

    public static User getCurrentUesr() {
        return currentUser;
    }

    public void order() {
        // Transaction
        // 创建订单
        // 创建订单明细
        // 关联地址信息
        // 调用物流....
        //
    }
}
