package com.iflytek.dao;

import java.util.ArrayList;
import java.util.List;

import com.iflytek.pojo.Address;
import com.iflytek.utils.DBUtils;

public class AddressDao {
    private DBUtils<Address> dbUtils = new DBUtils<Address>();

    public List<Address> queryAll() {
        try {
            return dbUtils.query(null, Address.class, "select id, userId,userName,addr,tel,status from address");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<Address>();
    }

    public int insert(Address address) {
        // 规则：
        /**status : 0 不是默认的 1：是默认的
         *
         */
        String uSql = "update address set status=0 where status = 1";
        String sql = "insert into address (userId,userName, addr,tel,status) values(?,?,?,?,1)";
        try {
            dbUtils.update(null, Address.class, uSql);
            dbUtils.insert(new Object[]{address.getUserId(), address.getUserName(), address.getAddr(), address.getTel()}, Address.class, sql);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }

        return 1;
    }

    public Address uniqQuery(Object[] params, String sql) {
        try {
            return dbUtils.uniqQuery(params, Address.class, sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
