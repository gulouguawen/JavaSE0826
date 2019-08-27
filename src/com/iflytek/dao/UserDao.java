package com.iflytek.dao;

import com.iflytek.pojo.User;
import com.iflytek.utils.DBUtils;

import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;

public class UserDao {
    private DBUtils<User> dbUtils = new DBUtils<User>();

    public User queryByUsernameAndPassword(String username, String password) {
        try {
            return dbUtils.uniqQuery(new String[2], User.class);
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
        }

        return null;
    }
}
