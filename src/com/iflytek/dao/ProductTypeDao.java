package com.iflytek.dao;

import java.util.ArrayList;
import java.util.List;

import com.iflytek.pojo.ProductType;
import com.iflytek.utils.DBUtils;

public class ProductTypeDao {
    private DBUtils<ProductType> dbUtils = new DBUtils<ProductType>();

    public int insert(ProductType productType) {
        String sql = "insert into product_type (name, creator, creatorName) values (?,?,?)";
        try {
            return dbUtils.insert(new Object[]{productType.getName(), productType.getCreator(), productType.getCreatorName()}, ProductType.class, sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<ProductType> queryAll() {
        String sql = "select id, name, creator, creatorName from product_type";
        try {
            return dbUtils.query(new Object[]{}, ProductType.class, sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<ProductType>();
    }

}
