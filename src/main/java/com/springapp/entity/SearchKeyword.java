package com.springapp.entity;

import java.util.List;

/**
 * Created by 11369 on 2016/8/20.
 */
public class SearchKeyword {
    private Slide slide;
    private List<uTag> uTagList;
    private Double weight;

    public Slide getSlide() {
        return slide;
    }

    public void setSlide(Slide slide) {
        this.slide = slide;
    }

    public List<uTag> getuTagList() {
        return uTagList;
    }

    public void setuTagList(List<uTag> uTagList) {
        this.uTagList = uTagList;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }
}
