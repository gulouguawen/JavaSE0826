package com.iflytek.service;

import com.iflytek.dao.ProductDao;
import com.iflytek.pojo.Product;

public class ProductService {
    private ProductDao productDao = new ProductDao();

    public int insertProduct(Product product) {
        return productDao.insert(product);
    }
}
