package com.iflytek.ui;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.iflytek.pojo.Product;
import com.iflytek.pojo.ProductType;
import com.iflytek.service.ProductService;
import com.iflytek.service.ProductTypeService;
import com.iflytek.service.UserService;
import com.iflytek.utils.DBUtils;

public class AdminUI {
    private Scanner sc;
    private ProductTypeService ptService = new ProductTypeService();
    private ProductService productService = new ProductService();

    public AdminUI(Scanner sc) {
        this.sc = sc;
    }

    public void init() {
        System.out.println("欢迎进入管理员界面");
        System.out.println("【操作】：【1】录入商品分类【2】录入商品");
        System.out.println("请输入您要的操作：");
        String opt = sc.nextLine();

        switch (opt) {
            case "1":
                System.out.println("请输入商品分类的名称：");
                // 商品分类的名称
                String name = sc.nextLine();

                // 封装数据：定义一个对象，将数据库product_type封装成对象
                // 思考：如果name为 " " ？ 或者说它有特殊字符？ \在字符串当中 是一个特殊字符 表示“转义”
                String reg = "\\s*";
                Pattern p = Pattern.compile(reg);
                Matcher m = p.matcher(name);
                boolean b = m.matches();
                if (b) {
                    System.out.println("对不起，您输入的商品分类的格式有问题，不能为空或空字符串");
                    break;
                }

                ProductType pt = new ProductType();
                pt.setName(name);
                pt.setCreatorName(UserService.getCurrentUesr().getName());
                pt.setCreator(UserService.getCurrentUesr().getId());

                // 录入商品类别 是一个业务--》service
                int rlt = ptService.insertProductType(pt);
                if (rlt == 1) {
                    System.out.println("录入成功，您可以继续录入");
                } else {
                    System.out.println("对不起，您录入失败了");
                }
                // ---END 流程已经结束

                // 商品分类的信息  -- 开发阶段 必须要加的
                System.out.println("商品分类信息如下：");
                List<ProductType> list = ptService.queryAll();
                DBUtils.print(list); // 给你看看 数据库的数据有没有错误  业务代码错误了？
                break;
            case "2":
                /**
                 * 录入商品（编号，名称，单价，品牌，库存，状态（商品下架 1：正常 0 ：下架），商品类别，创建者，创建者姓名）
                 *
                 *1、接受控制台输入的 商品的名称、单价、品牌、库存
                 *
                 *
                 */
                // 差一个 product_type_id
                // 界面初始化： 初始化界面上的数据
                System.out.print("请选择您要录入商品的商品分类：");
                List<ProductType> l = ptService.queryAll();
                Map<String, Integer> xhTypeId = new HashMap<String, Integer>();
                for (int i = 0; i < l.size(); i++) {
                    System.out.print("【" + (i + 1) + "】" + l.get(i).getName());
                    xhTypeId.put((i + 1) + "", l.get(i).getId());
                }
                System.out.println("");
                String idx = sc.nextLine();
                int typeId = xhTypeId.get(idx);
                System.out.println("请输入您要录入商品的名称：");
                String productName = sc.nextLine();
                System.out.println("请输入您要录入商品的价格：");
                String productPrice = sc.nextLine();
                System.out.println("请输入您要录入商品的品牌：");
                String brand = sc.nextLine();
                System.out.println("请输入您要录入商品的库存：");
                String num = sc.nextLine();
                // 价格
                Double f = Double.parseDouble(productPrice);
                // 数量
                int n = Integer.parseInt(num);

                // 封装数据
                Product product = new Product();
                product.setBrand(brand);
                product.setName(productName);
                product.setNum(n);
                product.setPrice(f);
                product.setCreatorName(UserService.getCurrentUesr().getName());
                product.setCreator(UserService.getCurrentUesr().getId());
                product.setType(typeId);
                rlt = productService.insertProduct(product);
                // productService.insertProduct(String brand,String productName, ...)
                // productService.insertProduct(null, String productName, ...)
                if (rlt > 0) {
                    System.out.println("管理员成功录入" + productName + "的商品");
                } else {
                    System.out.println("对不起，录入失败，请检查网络是否通");
                }
                break;
            default:
                break;
        }
    }
}
