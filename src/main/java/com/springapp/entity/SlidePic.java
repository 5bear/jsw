package com.springapp.entity;

import javax.persistence.*;

/**
 * Created by 11369 on 2016/7/23.
 * 案例预览图
 */
@Entity
public class SlidePic {
    private Long spId;
    private Slide slide;
    private String picPath;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getSpId() {
        return spId;
    }

    public void setSpId(Long spId) {
        this.spId = spId;
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
    public String getPicPath() {
        return picPath;
    }

    public void setPicPath(String picPath) {
        this.picPath = picPath;
    }
}
