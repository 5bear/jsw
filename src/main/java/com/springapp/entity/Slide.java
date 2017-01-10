package com.springapp.entity;

import javax.persistence.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Created by 六花 on 2016/7/14.
 * 案例表
 * 案例id，标题，一级分类。二级分类，教师打标签，管理员打标签，上传时间，状态，上传文件
 */
@Entity
public class Slide {
    private Long sId;//案例唯一标识id
    private String title;//案例标题
    private String type;//案例一级分类
    private String secondtype;//案例二级分类
    private Account teacher;//所属教师
    private String description;//描述
    private List<uTag> UserTag;//用户打标签,达到100次才加进去
    private String uTag;
    private List<uTag> TeacherTag;//教师打标签
    private String tTag;//教师标签，原标签
    private List<uTag> AdminTag;//管理员打标签
    private String aTag;
    private Timestamp uploadDatetime;//上传时间
    private Integer state;//状态0表示删除   1 草稿箱 2 已提交 3 编审中 4 驳回 5 审核通过
    private String opinion;//驳回意见
    private String fileName;//上传的文件名
    private String fileType;//上传的文件类型
    private String filePath;//上传文件位置
    private String picPath;//用于展示案例
    private int viewCount;//查看次数
    private int downCount;//下载次数
    private int collectCount;//收藏次数
    private int zanCount;//点赞次数
    private String formatTimestamp;
    private String formatYM;

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getsId() {
        return sId;
    }

    public void setsId(Long sId) {
        this.sId = sId;
    }

    @Column()
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title= title;
    }

    @Column
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Column
    public String getSecondtype() {
        return secondtype;
    }

    public void setSecondtype(String secondtype) {
        this.secondtype = secondtype;
    }

    @Transient
    public List<uTag> getUserTag() {
        return UserTag;
    }

    public void setUserTag(List<uTag> userTag) {
        UserTag = userTag;
    }
    @Transient
    public List<uTag> getTeacherTag() {
        return TeacherTag;
    }

    public void setTeacherTag(List<uTag> teacherTag) {
        TeacherTag = teacherTag;
    }
    @Transient
    public List<uTag> getAdminTag() {
        return AdminTag;
    }

    public void setAdminTag(List<uTag> adminTag) {
        AdminTag = adminTag;
    }

    @Transient
    public String getuTag() {
        return uTag;
    }

    public void setuTag(String uTag) {
        this.uTag = uTag;
    }
    @Column
    public String gettTag() {
        return tTag;
    }

    public void settTag(String tTag) {
        this.tTag = tTag;
    }
    @Column
    public String getaTag() {
        return aTag;
    }

    public void setaTag(String aTag) {
        this.aTag = aTag;
    }

    @Column
    public Timestamp getUploadDatetime() {
        return uploadDatetime;
    }

    public void setUploadDatetime(Timestamp uploadDatetime) {
        this.uploadDatetime = uploadDatetime;
    }

    @Column
    public Integer getState() {return state;}

    public void setState(Integer state) {this.state = state;}

    @Column
    public String getFilePath() {return filePath;}

    public void setFilePath(String filePath) {this.filePath = filePath;}
    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
    @JoinColumn(name = "teacher")
    public Account getTeacher() {
        return teacher;
    }

    public void setTeacher(Account teacher) {
        this.teacher = teacher;
    }

    @Column
    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }
    @Column
    public int getDownCount() {
        return downCount;
    }

    public void setDownCount(int downCount) {
        this.downCount = downCount;
    }
    @Column
    public int getCollectCount() {
        return collectCount;
    }

    public void setCollectCount(int collectCount) {
        this.collectCount = collectCount;
    }
    @Column
    public int getZanCount() {
        return zanCount;
    }

    public void setZanCount(int zanCount) {
        this.zanCount = zanCount;
    }

    @Column
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    @Column
    public String getFileName() {
        return fileName;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    @Column
    public String getOpinion() {
        return opinion;
    }

    public void setOpinion(String opinion) {
        this.opinion = opinion;
    }



    @Transient
    public String getPicPath() {
        return picPath;
    }

    public void setPicPath(String picPath) {
        this.picPath = picPath;
    }

    @Transient
    public String getFormatTimestamp() {
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(uploadDatetime);
    }

    public void setFormatTimestamp(String formatTimestamp) {
        this.formatTimestamp = formatTimestamp;
    }

    @Transient
    public String getFormatYM() {
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM");
        return sdf.format(uploadDatetime);
    }

    public void setFormatYM(String formatYM) {
        this.formatYM = formatYM;
    }
}
