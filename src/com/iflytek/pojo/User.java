package com.iflytek.pojo;

import java.lang.reflect.Field;

public class User {
    private int id;
    private int type;
    private String username;
    public String password;
    private String name;
    private String email;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", type=" + type + ", username=" + username + ", password=" + password + ", name="
                + name + ", email=" + email + "]";
    }

    public static void main(String[] args) throws InstantiationException, IllegalAccessException {
        Class clazz = User.class;
        User u = (User) clazz.newInstance();
        u.setId(44444);
        Field[] fields = clazz.getDeclaredFields(); // 返回所有类型的
        for (Field f : fields) {
            System.out.println(f.getName() + "----" + f.getType() + "---");
        }
        System.out.println("****************************");
        fields = clazz.getFields(); // 只能访问公有的
        for (Field f : fields) {
            System.out.println(f.getName() + "----" + f.getType() + "---");
        }
    }

}
