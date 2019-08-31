package com.iflytek.ui;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.iflytek.pojo.Address;
import com.iflytek.pojo.Product;
import com.iflytek.service.AddressService;
import com.iflytek.service.OrderService;
import com.iflytek.service.ProductService;
import com.iflytek.service.UserService;
import com.iflytek.utils.CommonUtils;
import com.iflytek.utils.DBUtils;

public class UserUI {
    private Scanner sc;
    private ProductService productService = new ProductService();
    private OrderService orderService = new OrderService();
    private AddressService addressService = new AddressService();

    public UserUI(Scanner sc) {
        this.sc = sc;
    }

    public void init() {
        System.out.println("欢迎进入普通用户界面");
        System.out.println("#【操作】：#【1】查询商品#【2】下单");
        System.out.println("请输入您要的操作：");
        String opt = sc.nextLine();

        switch (opt) {
            case "1":
                // 查询出来所有商品的列表（只要向数据库查询所有的商品并列出来）
                List<Product> list = productService.queryAll();
                DBUtils.print(list);
                break;
            case "2":
                // 1.系统要初始化商品（销量比较高的），选择商品编号，并使用逗号隔开
                // 1.系统要初始化化商品分类，根据商品分类列出所有商品，用户选择商品编号，并使用逗号隔开
                System.out.println("#【1】常见商品#【2】分类商品");
                opt = sc.nextLine();
                if (opt.equals("1")) {
                    /**
                     * 常见商品的规则
                     * 1.常见商品只有三条记录
                     * 2.三条记录是随机的  根据数据库记录的游标来确定三条记录
                     * 3.游标的位置不能超过 数据库记录数的最大数-3
                     *
                     * 步骤：
                     * 1.获取游标的位置 select floor(rand()*(count(*)-2)) from product;
                     * 2.查询游标位置之后的三条记录
                     * select * from product limit 游标的位置,3;
                     * select * from product limit 3 offset 游标的位置
                     *
                     * 关键点：MySQL 分页的写法 使用逗号 第一个参数是游标，第二参数记录数
                     *               使用关键字offset 第一个参数是记录数 第二个参数才是游标
                     */
                    list = productService.pageQuery(3);

                    // 初始化出来常见商品，供用户选择购买
                    DBUtils.print(list);
                    // 目的：向订单表和订单明细表插入数据
                    System.out.println("请选择您要购买的商品：#【id:数量】如 1:2,2:3...");

                    // [a-zA-z]\w{5,19}  用户名长度在6到20位，数字大小写字母，首字母不能为数字
                    String cart = sc.nextLine();
                    String reg = "\\d+:\\d+(,\\d:\\d)*";
                    Pattern p = Pattern.compile(reg);
                    Matcher m = p.matcher(cart);
                    boolean b = m.matches();
                    if (!b) {
                        System.out.println("对不起，您输入的#【购买商品明细】的格式不正确");
                        break;
                    }
                    //下单
                    /**
                     * 1. 4:1,2:3,3:1 获取下单数据
                     * 2. 解析下单数据 Map<Integer,Integer> <id,数量> <商品id，购买的数量>
                     * 3.生成订单信息（id,orderNo,status,creator,creatorName）
                     * 		orderNo:给定规则？--》
                     * 4.生成订单明细(productid，orderid，num)
                     */
                    Map<Integer, Integer> cartMap = new HashMap<Integer, Integer>();
                    String[] cartArr = cart.split(","); // ["4:1","2:3","3:1"]
                    for (int i = 0; i < cartArr.length; i++) {
                        String s = cartArr[i];
                        String orderProductStr[] = s.split(":");
                        cartMap.put(Integer.parseInt(orderProductStr[0]), Integer.parseInt(orderProductStr[1]));
                    }

                    // order功能就是向数据库插入 订单和订单明细
                    // 2.根据选择的商品编号，向数据库中添加一条 订单记录 ，和订单明细记录
                    String orderNo = CommonUtils.generatorOrderNo();

                    // 此处加上了orderNo的参数 ： 在确认订单业务功能中需要一个订单信息
                    int rlt = orderService.order(cartMap, orderNo);
                    if (rlt == 0) {
                        System.out.println("对不起，存在商品数据库库存不足，不能下单");
                        break;
                    }

                    // 3.添加成功后，选择一条地址信息，最后订单生成成功
                    /**
                     * 1) 建立订单和地址表的关系 --》在表订单中添加字段addrId(地址ID)
                     * 2) 在Order类中添加字段addrId
                     * 3)确认支付：需要进行订单关联地址，如果有地址那么就关联，否则新建地址信息
                     * 4)确认地址是否存在
                     * 5)如果存在 A 提示用户 "#
                     # 【1】请选择地址信息 #
                     # 【2】新建地址信息"
                     * 6)如果不存在 B 提示用户 "请录入地址信息:"
                     * 7)在A的条件下，选择地址后，就直接关联地址，下单成功
                     * 8)在B的条件下，录入地址信息后，就直接关联地址，下单成功
                     */
                    List<Address> addrList = addressService.queryAll();
                    if (addrList != null && addrList.size() > 0) {
                        // 找到了地址信息
                        System.out.println("#【1】请选择地址信息 #【2】新建地址信息");
                        opt = sc.nextLine();
                        if (opt.equals("1")) {
                            // 打印 addrList集合对象

                            // 选择其中一个地址关联订单后，确认下单
                        } else {
                            System.out.println("请录入地址信息:");
                            // 进入地址录入

                            // 关联到订单后，确认下单
                        }
                    } else {
                        System.out.println("请录入地址信息:");
                        // 进入地址录入
                        System.out.println("请输入收货人姓名：");
                        String userName = sc.nextLine();
                        System.out.println("请输入收货人地址：");
                        String addr = sc.nextLine();
                        System.out.println("请输入收货人联系方式：");
                        String tel = sc.nextLine();  // 此处大家验证一下手机号码

                        // 封装数据（数据校验）
                        Address address = new Address();
                        address.setAddr(addr);
                        address.setTel(tel); // 此处需要校验一下手机号码
                        address.setUserId(UserService.getCurrentUesr().getId()); // userId == > 下单人的ID == > 登录人的ID
                        address.setUserName(userName);

                        // 关联到订单后，确认下单
                        /**
                         * 1. 向数据库插入地址
                         * 2.获取地址id 关联到订单中 ，update order （addrId）
                         * 	    根据订单的编号查询到关联订单
                         * 3.同步修改订单信息中的状态 ---》 从初始化0--》已经完成
                         */
                        orderService.confirmOrder(address, orderNo);

                        System.out.println("恭喜您，下单成功，您的订单信息为：#【订单号为：" + orderNo + ",收货人为：" + userName + ",收货人电话为：" + tel + ",收货人地址为：" + addr + "】");
                        // 订单号：，收货人：，收货人电话：，收货人地址：
                    }

                    // 确认支付 --》确认下单 --》填写地址信息
                    // 获取地址信息  ---》 判断数据库是否有地址信息，如果有，否则


//					sc.nextLine();
                    // 下单成功
                } else if (opt.equals("2")) {

                }

                break;
            default:
                break;
        }
    }

    public static void main(String[] args) {

//		String reg = "\\d+:\\d+(,\\d+:\\d+)*";
//		Pattern p = Pattern.compile(reg);
//		Matcher m = p.matcher("11:2,2:3");
//		boolean b = m.matches();
//		System.out.println(b);

        AddressService addressService = new AddressService();
        System.out.println(addressService.queryAll());
    }
}
