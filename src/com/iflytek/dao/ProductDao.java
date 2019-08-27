package com.iflytek.dao;

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
}
