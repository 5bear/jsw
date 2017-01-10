package com.springapp.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by 11369 on 2016/7/14.
 * 用户收藏的案例
 */
@Entity
public class UserCollect {
    private Long ucId;//唯一标识
    private Account account;//外键
    private Slide slide;
    private Timestamp collectTime;//收藏时间
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getUcId() {
        return ucId;
    }

    public void setUcId(Long ucId) {
        this.ucId = ucId;
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
    @JoinColumn(name = "slide")
    public Slide getSlide() {
        return slide;
    }

    public void setSlide(Slide slide) {
        this.slide = slide;
    }

    @Column
    public Timestamp getCollectTime() {
        return collectTime;
    }

    public void setCollectTime(Timestamp collectTime) {
        this.collectTime = collectTime;
    }
}
