package com.iflytek.service;

import java.util.List;

import com.iflytek.dao.ProductTypeDao;
import com.iflytek.pojo.ProductType;

public class ProductTypeService {
    private ProductTypeDao productTypeDao = new ProductTypeDao();

    public int insertProductType(ProductType productType) {
        return productTypeDao.insert(productType);
    }

    public List<ProductType> queryAll() {
        return productTypeDao.queryAll();
    }
}
