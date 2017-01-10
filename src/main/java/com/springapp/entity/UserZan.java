package com.springapp.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by 11369 on 2016/7/14.
 * 用户点赞案例表
 */
@Entity
public class UserZan {
    private Long uzId;//唯一标识
    private Account account;//外键
    private Slide slide;//外建
    private Timestamp zanTime;//点赞时间
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getUzId() {
        return uzId;
    }

    public void setUzId(Long uzId) {
        this.uzId = uzId;
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
    public Timestamp getZanTime() {
        return zanTime;
    }

    public void setZanTime(Timestamp zanTime) {
        this.zanTime = zanTime;
    }
}
