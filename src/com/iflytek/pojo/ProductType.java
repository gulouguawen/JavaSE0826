package com.iflytek.pojo;

public class ProductType {
    private Integer id; // 尽量不要使用基本数据类型，包装类比较的时候，不要使用==，要使用equals去比较
    private String name; // 它类似于 淘宝上男装、女装（分类的名称）
    // 管理员录入商品分类
    private Integer creator; // 对应于管理员的ID
    private String creatorName; // 对应于管理员的姓名 在数据库中就叫做冗余

    /**
     * 什么时候能够建立冗余： 在于这个字段 不经常变化
     */
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCreator() {
        return creator;
    }

    public void setCreator(Integer creator) {
        this.creator = creator;
    }

    public String getCreatorName() {
        return creatorName;
    }

    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }
}
