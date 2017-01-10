package com.springapp.entity;

import javax.persistence.*;

/**
 * Created by 11369 on 2016/9/26.
 */
@Entity
public class Recommend {
    private Long id;
    private Account account;
    private Slide slide;
    private float cos;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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
    public float getCos() {
        return cos;
    }

    public void setCos(float cos) {
        this.cos = cos;
    }
}
