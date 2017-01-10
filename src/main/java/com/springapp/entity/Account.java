package com.springapp.entity;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Arrays;

/**
 * Created by 11369 on 2016/7/12.
 * 用户账户
 * 唯一标识ID，昵称，头像存储位置，性别，邮箱，最近登录，（兴趣点新建一张表）
 */
@Entity
public class Account {
    private Long aId;//用户唯一标识id
    private String email;//邮箱唯一
    private String nickName;//昵称
    private String password;
    private String headPath;//头像位置
    private int sex;//0男，1女
/*
    private int role;//1 普通用户 2表示教师，教师需要审核
*/
/*
    private int exist;//教师未通过为0
*/
  /*  private String interest;//兴趣点，前台显示
    private Long[]interests;//兴趣点
    private Long[]user_interests;//已选兴趣点*/
    private Timestamp rDatetime;//注册时间
    private Timestamp lastLogin;//最近登录时间
    private String lastIP;//最近登录IP
    //工号以及备注均为用户可选字段
    private String no;//工号
    private String department;//工作单位
    private String remark;//备注
    private int caseCount;//案例数
    private Float score;//教师评分
    private Integer integral;//积分
    private String rank;//等级
    private int scoreCount;//打分的人数
    private int isDelete;//1 表示删除
  /*  public int getExist() {
        return exist;
    }

    public void setExist(int exist) {
        this.exist = exist;
    }*/

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public Integer getIntegral() {
        return integral;
    }

    public void setIntegral(Integer integral) {
        this.integral = integral;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getCaseCount() {
        return caseCount;
    }

    public void setCaseCount(int caseCount) {
        this.caseCount = caseCount;
    }

    public Float getScore() {
        return score;
    }

    public void setScore(Float score) {
        this.score = score;
    }

    public int getScoreCount() {
        return scoreCount;
    }

    public void setScoreCount(int scoreCount) {
        this.scoreCount = scoreCount;
    }

   /* @Column
    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }*/

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getaId() {
        return aId;
    }

    public void setaId(Long aId) {
        this.aId = aId;
    }

    @Column()
    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    @Column
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column()
    public String getHeadPath() {
        return headPath;
    }

    public void setHeadPath(String headPath) {
        this.headPath = headPath;
    }

    @Column(length = 4)
    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    /*邮箱作为用户登录唯一标识*/
    @Column(unique = true)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column
    public Timestamp getrDatetime() {
        return rDatetime;
    }

    public void setrDatetime(Timestamp rDatetime) {
        this.rDatetime = rDatetime;
    }

    @Column
    public Timestamp getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Timestamp lastLogin) {
        this.lastLogin = lastLogin;
    }

    @Column
    public String getLastIP() {
        return lastIP;
    }

    public void setLastIP(String lastIP) {
        this.lastIP = lastIP;
    }

    public int getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(int isDelete) {
        this.isDelete = isDelete;
    }

    /*  @Transient
    public Long[] getInterests() {
        return interests;
    }

    public void setInterests(Long[] interests) {
        this.interests = interests;
    }

    @Transient
    public String getInterest() {
        return interest;
    }

    public void setInterest(String interest) {
        this.interest = interest;
    }

    @Transient
    public Long[] getUser_interests() {
        return user_interests;
    }

    public void setUser_interests(Long[] user_interests) {
        this.user_interests = user_interests;
    }*/

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Account)) return false;

        Account account = (Account) o;

        if (sex != account.sex) return false;
        if (caseCount != account.caseCount) return false;
        if (scoreCount != account.scoreCount) return false;
        if (isDelete != account.isDelete) return false;
        if (aId != null ? !aId.equals(account.aId) : account.aId != null) return false;
        if (email != null ? !email.equals(account.email) : account.email != null) return false;
        if (nickName != null ? !nickName.equals(account.nickName) : account.nickName != null) return false;
        if (password != null ? !password.equals(account.password) : account.password != null) return false;
        if (headPath != null ? !headPath.equals(account.headPath) : account.headPath != null) return false;
        if (rDatetime != null ? !rDatetime.equals(account.rDatetime) : account.rDatetime != null) return false;
        if (lastLogin != null ? !lastLogin.equals(account.lastLogin) : account.lastLogin != null) return false;
        if (lastIP != null ? !lastIP.equals(account.lastIP) : account.lastIP != null) return false;
        if (no != null ? !no.equals(account.no) : account.no != null) return false;
        if (remark != null ? !remark.equals(account.remark) : account.remark != null) return false;
        if (score != null ? !score.equals(account.score) : account.score != null) return false;
        if (integral != null ? !integral.equals(account.integral) : account.integral != null) return false;
        return rank != null ? rank.equals(account.rank) : account.rank == null;

    }

    @Override
    public int hashCode() {
        int result = aId != null ? aId.hashCode() : 0;
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (nickName != null ? nickName.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (headPath != null ? headPath.hashCode() : 0);
        result = 31 * result + sex;
        result = 31 * result + (rDatetime != null ? rDatetime.hashCode() : 0);
        result = 31 * result + (lastLogin != null ? lastLogin.hashCode() : 0);
        result = 31 * result + (lastIP != null ? lastIP.hashCode() : 0);
        result = 31 * result + (no != null ? no.hashCode() : 0);
        result = 31 * result + (remark != null ? remark.hashCode() : 0);
        result = 31 * result + caseCount;
        result = 31 * result + (score != null ? score.hashCode() : 0);
        result = 31 * result + (integral != null ? integral.hashCode() : 0);
        result = 31 * result + (rank != null ? rank.hashCode() : 0);
        result = 31 * result + scoreCount;
        result = 31 * result + isDelete;
        return result;
    }
}
