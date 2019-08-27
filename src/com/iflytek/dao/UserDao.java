package com.iflytek.dao;


import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;

import com.iflytek.pojo.User;
import com.iflytek.utils.DBUtils;

public class UserDao {
    private DBUtils<User> dbUtils = new DBUtils<User>();

    public User queryByUsernameAndPassword(String username, String password) {
        try {
            String sql = "select id, username, password, name, email, type from user where username = ? and password = ? ";
            return dbUtils.uniqQuery(new String[]{username, password}, User.class, sql);
        } catch (InstantiationException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SecurityException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return null;
    }
}
