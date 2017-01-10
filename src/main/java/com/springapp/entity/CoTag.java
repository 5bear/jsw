package com.springapp.entity;

import javax.persistence.*;

/**
 * Created by 11369 on 2016/9/20.
 * 标签共现，计算标签之间的相似度
 */
@Entity
public class CoTag {
    private Long id;
    private String uTag;
    private String coTag;//相关tag
    private Double coIndex;//相关系数

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }


    @Column
    public String getuTag() {
        return uTag;
    }

    public void setuTag(String uTag) {
        this.uTag = uTag;
    }

    @Column
    public String getCoTag() {
        return coTag;
    }

    public void setCoTag(String coTag) {
        this.coTag = coTag;
    }

    @Column
    public Double getCoIndex() {
        return coIndex;
    }

    public void setCoIndex(Double coIndex) {
        this.coIndex = coIndex;
    }
}
