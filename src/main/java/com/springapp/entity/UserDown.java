package com.springapp.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by 11369 on 2016/7/15.
 * 用户下载
 */
@Entity
public class UserDown {
    private Long udId;
    private Account account;
    private Slide slide;
    private Timestamp downTime;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getUdId() {
        return udId;
    }

    public void setUdId(Long udId) {
        this.udId = udId;
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

    @Column()
    public Timestamp getDownTime() {
        return downTime;
    }

    public void setDownTime(Timestamp downTime) {
        this.downTime = downTime;
    }
}
