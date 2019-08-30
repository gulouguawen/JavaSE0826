package com.iflytek.service;

import java.util.List;

import com.iflytek.dao.AddressDao;
import com.iflytek.pojo.Address;

public class AddressService {
    private AddressDao addressDao = new AddressDao();

    public List<Address> queryAll() {
        return addressDao.queryAll();
    }
}
