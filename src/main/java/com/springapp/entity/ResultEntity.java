package com.springapp.entity;

/**
 * Created by 11369 on 2016/9/22.
 */
public class ResultEntity {
    private Slide slide;//案例
    private uTag term;//查询词
    private Double score;//分数
    private Long tag_weight;//权重

    public Slide getSlide() {
        return slide;
    }

    public void setSlide(Slide slide) {
        this.slide = slide;
    }

    public uTag getTerm() {
        return term;
    }

    public void setTerm(uTag term) {
        this.term = term;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public Long getTag_weight() {
        return tag_weight;
    }

    public void setTag_weight(Long tag_weight) {
        this.tag_weight = tag_weight;
    }
}
