package com.iflytek.utils;

import com.iflytek.pojo.Test;
import com.iflytek.pojo.User;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.List;

public class DBUtils<T> {
    public T uniqQuery(String params[], Class<T> clazz) throws SQLException, InstantiationException, IllegalAccessException, NoSuchMethodException, SecurityException, IllegalArgumentException, InvocationTargetException {

        List<User> list = null;
        Connection conn = null;
        String sql = "select * from user where username = ? and password = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        int size = params.length;
        for (int i = 0; i < size; i++) {
            pstmt.setObject(i + 1, params[i]);
        }
        ResultSet rs = pstmt.executeQuery();

        // 反射
        T in = (T) clazz.newInstance();

        if (rs.next()) {
            // rs --》 对象T
            Field[] fields = clazz.getDeclaredFields();
            for (int j = 0; j < fields.length; j++) {
                Method method = clazz.getDeclaredMethod("set" + fields[j].getName(), fields[j].getType());
                method.invoke(in, rs.getObject(fields[j].getName()));
            }
        }
        // 资源关闭操作
        // ...

        return in;
    }

    public List<T> Query(String params[]) {
        return null;
    }


    static final String USERNAME = "root";
    static final String PASSWORD = "sy205919";
    static final String DRIVER = "com.mysql.jdbc.Driver";
    static final String URL = "jdbc:mysql://localhost:3306/java0826?useUnicode=true&characterEncoding=UTF-8&useSSL=false&autoReconnect=true&failOverReadOnly=false";
    // 加载驱动

    /**
     * 数据库jdbc操作：
     * 1、加载驱动 --》原因：jdbc支持多种数据库，有不同的驱动，就能够连接不同的数据库--》桥接设计模式
     * 2、获取连接--》建立数据库和系统的通道
     * 3、创建操作sql的对象———》调用数据库执行语句PreparedStatement / Statement
     * 4、执行sql语句，获取返回值（ResultSet/执行成功记录数）  如何保证两条sql语句是原子性（事务）
     * 5、begin transaction  commit  rollback
     * 6、资源回收机制
     *
     *    数据连接池：每次创建jdbc连接的时候是非常耗费内存，非常耗费时间的
     *      连接放在池子里面，当我需要的时候，拿出来使用，不需要的时候放进池子里面。通道还是需要关的，ResultSet，Statement
     *     数据源：DataSource --> 数据库连接池的一个具体实现 --》并发控制
     *
     *  以后使用框架的时候，这些东西都已经不需要了，只需要执行框架就可以了；只需要了解就可以。
     *
     */

    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public T uniqQuery(Object[] obj, Class<T> clazz, String sql) throws Exception {
        // 建立连接
        Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);

        // Statement  --》调用数据库的执行程序  --> 预编译：防止sql注入，加快sql执行
        PreparedStatement pstmt = conn.prepareStatement(sql);
        for (int i = 0; i < obj.length; i++) {
            pstmt.setObject(i + 1, obj[i]);
        }

        // 执行获取到一个结果集
        ResultSet rs = pstmt.executeQuery();
        T t = null;
        if (rs.next()) {
            // 此方法其实就是new一个对象出来
            t = clazz.newInstance();
            Field[] fields = clazz.getDeclaredFields();
            for (Field f : fields) {
                Method m = clazz.getDeclaredMethod("set" + StringUtils.toUpcaseFirst(f.getName()), f.getType());
                m.invoke(t, rs.getObject(f.getName()));  //ORM hibernate mybatis -->关系映射
            }
        }
        return t;
    }

    public static void main(String[] args) throws Exception {
        String sql = "select id, username, password, name, email, type from user where username = ? and password = ? ";
        User user = new DBUtils<User>().uniqQuery(new Object[]{"admin", "123456"}, User.class, sql);
        System.out.println(user);

        sql = "select id, name from user where id = ? ";
        Test test = new DBUtils<Test>().uniqQuery(new Object[]{3}, Test.class, sql);
        System.out.println(test);
    }
}
