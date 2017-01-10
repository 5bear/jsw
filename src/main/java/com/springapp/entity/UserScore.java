package com.springapp.entity;


import javax.persistence.*;

/**
 * Created by 11369 on 2016/8/31.
 * 学生评分
 */
@Entity
public class UserScore {
    private Long id;
    private Account account;
    private Account teacher;
    private Float score;

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
    @JoinColumn(name = "teacher")
    public Account getTeacher() {
        return teacher;
    }

    public void setTeacher(Account teacher) {
        this.teacher = teacher;
    }

    @Column()
    public Float getScore() {
        return score;
    }

    public void setScore(Float score) {
        this.score = score;
    }
}
