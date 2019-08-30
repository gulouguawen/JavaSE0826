package com.iflytek.service;

import java.util.List;

import com.iflytek.dao.ProductDao;
import com.iflytek.pojo.Product;

public class ProductService {
    private ProductDao productDao = new ProductDao();

    public int insertProduct(Product product) {
        return productDao.insert(product);
    }

    public List<Product> queryAll() {
        return productDao.queryAll();
    }

    public List<Product> pageQuery(int step) {
        return productDao.pageQuery(productDao.getCount(), step);
    }
}
