package com.iflytek.dao;

import com.iflytek.pojo.Order;
import com.iflytek.utils.DBUtils;

public class OrderDao {
    private DBUtils<Order> dbUtils = new DBUtils<Order>();

    public Order uniqQuery(Object[] params, String sql) {
        try {
            return dbUtils.uniqQuery(params, Order.class, sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int update(Object[] params, String sql) {
        try {
            return dbUtils.update(params, Order.class, sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
