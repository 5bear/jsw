package com.springapp.entity;

import javax.persistence.*;

/**
 * Created by 11369 on 2016/7/18.
 * 管理员账号
 */
@Entity
public class Admin {
    private Long adminId;
    private String account;
    private String password;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getAdminId() {
        return adminId;
    }

    public void setAdminId(Long adminId) {
        this.adminId = adminId;
    }

    @Column
    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    @Column
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
