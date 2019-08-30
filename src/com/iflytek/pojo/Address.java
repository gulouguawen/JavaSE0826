package com.iflytek.pojo;

public class Address {
    /**
     * 主键ID
     */
    private Integer id;
    /**
     * 下单人的ID
     */
    private Integer userId;
    /**
     * 联系人姓名
     */
    private String userName;
    /**
     * 联系人地址
     */
    private String addr;
    /**
     * 联系人电话
     */
    private String tel;
    /**
     * 是否是默认地址
     */
    private Integer status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Address [id=" + id + ", userId=" + userId + ", userName=" + userName + ", addr=" + addr + ", tel=" + tel
                + ", status=" + status + "]";
    }
}
