package com.iflytek.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.Map.Entry;

import com.iflytek.dao.AddressDao;
import com.iflytek.dao.OrderDao;
import com.iflytek.pojo.Address;
import com.iflytek.pojo.Order;
import com.iflytek.utils.DBUtils;

public class OrderService {
    private OrderDao orderDao = new OrderDao();
    private AddressDao addressDao = new AddressDao();

    public int order(Map<Integer, Integer> cartMap, String orderNo) {
        // 移动这里来了
        // 建立连接
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(DBUtils.URL, DBUtils.USERNAME, DBUtils.PASSWORD);
            conn.setAutoCommit(false);
            // 订单号的设计规则
            /**
             *  订单号的设计规则
             *     唯一、体现下单的时间
             *  IFLYTEKyyyyMMddHHmmssSSSX
             */
            // 插入表order
            String orderSql = "insert into `order`(orderNo,creator,creatorName) values(?,?,?)";
            // 插入表ordermx
            String ordermxSql = "insert into ordermx(productid,orderid,num) values (?,?,?)";
            //
            PreparedStatement pstmt = conn.prepareStatement(orderSql);
            pstmt.setString(1, orderNo);
            pstmt.setInt(2, UserService.getCurrentUesr().getId());
            pstmt.setString(3, UserService.getCurrentUesr().getName());
            pstmt.executeUpdate();

            // sql 根据订单号获取订单id
            pstmt = conn.prepareStatement("select id from `order` where orderNo = ?");
            pstmt.setString(1, orderNo);
            int orderId = -1;
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                orderId = rs.getInt("id");
            }

            // 根据传入的商品id 循环获取每个商品的库存，对比库存是否还有剩余，没有剩余就直接下单失败
            for (Entry<Integer, Integer> entry : cartMap.entrySet()) {
                int productId = entry.getKey();
                int num = entry.getValue();
                pstmt = conn.prepareStatement("select num from product where id = ?");
                pstmt.setInt(1, productId);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    int _num = rs.getInt("num");
                    if (_num < num) {
                        System.out.println("本次下单失败");
                        conn.rollback();
                        return 0;
                    }
                }
            }

            // 插入订单明细表
            for (Entry<Integer, Integer> entry : cartMap.entrySet()) {
                int productId = entry.getKey();
                int num = entry.getValue();
                pstmt = conn.prepareStatement("insert into ordermx (productId, orderId, num) values(?,?,?)");
                pstmt.setInt(1, productId);
                pstmt.setInt(2, orderId);
                pstmt.setInt(3, num);

                pstmt.executeUpdate();

                pstmt = conn.prepareStatement("update product set num = num - ? where id = ?");
                pstmt.setInt(1, num);
                pstmt.setInt(2, productId);
                pstmt.executeUpdate();
            }
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
        }
        return 1;
    }

    /**
     * 1. 向数据库插入地址
     * 2.获取地址id 关联到订单中 ，update order （addrId）
     * 根据订单的编号查询到关联订单
     * 3.同步修改订单信息中的状态 ---》 从初始化0--2》已经完成
     */
    public void confirmOrder(Address address, String orderNo) {
        addressDao.insert(address);
        // 查询status=1那条记录
        String sql = "select id,userId,userName,tel,addr,status from address where status = 1";
        Address addr = addressDao.uniqQuery(null, sql);
        int id = addr.getId();

        String oSql = "select id, orderNo,status,creator,creatorName,addrId from `order` where orderNo = ?";
        Order order = orderDao.uniqQuery(new Object[]{orderNo}, oSql);
        order.setAddrId(id); // 此处就关联了
        order.setStatus(2);  // 此处同步关联 修改订单的状态为已完成

        String uSql = "update `order` set status = ?, addrId = ? where id = ?";
        orderDao.update(new Object[]{order.getStatus(), order.getAddrId(), order.getId()}, uSql);
    }

    public static void main(String[] args) {
        String orderNo = "IFLYTEK201908301142554142";
        String oSql = "select id, orderNo,status,creator,creatorName,addrId from `order` where orderNo = ?";
        OrderDao orderDao = new OrderDao();
        Order order = orderDao.uniqQuery(new Object[]{orderNo}, oSql);
        order.setAddrId(3);
        order.setStatus(2);
        String uSql = "update `order` set status = ?, addrId = ? where id = ?";
        orderDao.update(new Object[]{order.getStatus(), order.getAddrId(), order.getId()}, uSql);
    }

}
