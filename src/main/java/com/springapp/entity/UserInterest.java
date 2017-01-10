package com.springapp.entity;

import javax.persistence.*;

/**
 * Created by 11369 on 2016/7/19.
 * 用户兴趣点
 */
@Entity
public class UserInterest {
    private Long uiId;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getUiId() {
        return uiId;
    }

    public void setUiId(Long uiId) {
        this.uiId = uiId;
    }
   /*
    private Account account;
    private uTag uTag;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getUiId() {
        return uiId;
    }

    public void setUiId(Long uiId) {
        this.uiId = uiId;
    }

    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
    @JoinColumn(name = "account")
    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }
    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
    @JoinColumn(name = "uTag")
    public uTag getuTag() {
        return uTag;
    }

    public void setuTag(uTag uTag) {
        this.uTag = uTag;
    }*/
}
