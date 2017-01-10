package com.springapp.entity;

import javax.persistence.*;

/**
 * Created by 11369 on 2016/7/18.
 * 用户新增大于等于100才显示
 */
@Entity
public class uTag {
    private Long tagId;
    private Slide slide;//案例外键
    private String utag;
    private Long uweight;//权重 上传者：70  管理员：50 其他用户：50 标题tag：30
    private int status;//0未审核 1 审核通过 2驳回 3 删除
    private int role;//0 用户 1 教师 2管理员 3隐式标签，标题分词
    private int userCount;//添加此标签的人数
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getTagId() {
        return tagId;
    }

    public void setTagId(Long tagId) {
        this.tagId = tagId;
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
    public Long getUweight() {
        return uweight;
    }

    public void setUweight(Long weight) {
        this.uweight = weight;
    }

    @Column()
    public String getUtag() {
        return utag;
    }

    public void setUtag(String utag) {
        this.utag = utag;
    }

    @Column()
    public int getStatus() {
        return status;
    }

    public void setStatus(int state) {
        this.status = state;
    }

    @Column()
    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    @Column
    public int getUserCount() {
        return userCount;
    }

    public void setUserCount(int userCount) {
        this.userCount = userCount;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof uTag)) return false;

        uTag uTag = (uTag) o;

        if (role != uTag.role) return false;
        if (status != uTag.status) return false;
        if (slide != null ? !slide.equals(uTag.slide) : uTag.slide != null) return false;
        if (tagId != null ? !tagId.equals(uTag.tagId) : uTag.tagId != null) return false;
        if (utag != null ? !utag.equals(uTag.utag) : uTag.utag != null) return false;
        if (uweight != null ? !uweight.equals(uTag.uweight) : uTag.uweight != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = tagId != null ? tagId.hashCode() : 0;
        result = 31 * result + (slide != null ? slide.hashCode() : 0);
        result = 31 * result + (utag != null ? utag.hashCode() : 0);
        result = 31 * result + (uweight != null ? uweight.hashCode() : 0);
        result = 31 * result + status;
        result = 31 * result + role;
        return result;
    }
}
