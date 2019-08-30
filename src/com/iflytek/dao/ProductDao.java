package com.iflytek.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.iflytek.pojo.Product;
import com.iflytek.utils.DBUtils;

public class ProductDao {
    private DBUtils<Product> dbUtils = new DBUtils<Product>();

    public int insert(Product product) {
        String sql = "insert into product (name,price, brand,num,type,creator, creatorName) values (?,?,?,?,?,?,?)";
        try {
            return dbUtils.insert(new Object[]{product.getName(), product.getPrice(), product.getBrand(), product.getNum(), product.getType(), product.getCreator(), product.getCreatorName()}, Product.class, sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * 一般情况下：
     * 返回一个对象，找不到，此时返回null
     * 返回一个集合，找不到，此时就不能够返回null，返回一个空的集合
     *
     * @return
     */
    public List<Product> queryAll() {
        String sql = "select id, name, price, brand, num, type,creator,creatorName,status from product";
        try {
            return dbUtils.query(null, Product.class, sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<Product>();
    }

    public Integer getCount() {
        String sql = "select ceil(rand()*(count(*)-3)) from product";
        // 建立连接
        Connection conn;
        try {
            conn = DriverManager.getConnection(DBUtils.URL, DBUtils.USERNAME, DBUtils.PASSWORD);
            // Statement  --》调用数据库的执行程序  --> 预编译：防止sql注入，加快sql执行
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int rlt = rs.getInt(1);
                return rlt;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    public List<Product> pageQuery(int start, int step) {
        String sql = "select id, name, price, brand, num, type,creator,creatorName,status from product limit ?,?";
        try {
            return dbUtils.query(new Object[]{start, step}, Product.class, sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<Product>();
    }

    public static void main(String[] args) {
        DBUtils.print(new ProductDao().pageQuery(new ProductDao().getCount(), 3));
    }
}
