package com.springapp.dao;
import com.springapp.entity.*;
import org.springframework.stereotype.Repository;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by 11369 on 2016/7/22.
 * 案例
 */
@Repository
public class SlideDao extends BaseDao {
    public List<Slide>getListByTypeByPage(String []result,String []conditions,int pn,int pageLen){
        List<Slide>returnList = null;
        if(result==null&&conditions==null) {
            if(pageLen==0)
                returnList =findAll("from Slide where state=5 order by uploadDatetime desc", Slide.class);
            else
            returnList = findByPage("from Slide where state=5 order by uploadDatetime desc", Slide.class, (pn - 1) * pageLen, pageLen);
        }
        else if(result==null){
            String hql="from Slide where state=5";
            int i=0;
            for(String condition:conditions){
                if(i==0){
                    if(!"".equals(condition)){
                        String type=condition.split("-")[0];
                        String subType=condition.split("-")[1];
                        if(subType.equals("全部"))
                            hql+=" and type='"+type+"'";
                        else{
                            hql+=" and type='"+type+"' and secondtype='"+subType+"'";
                        }
                    }
                }else{
                    if(!"".equals(condition)){
                        String type=condition.split("-")[0];
                        String subType=condition.split("-")[1];
                        if(subType.equals("全部"))
                            hql+=" or type='"+type+"'";
                        else{
                            hql+=" or type='"+type+"' and secondtype='"+subType+"'";
                        }
                    }
                }
                i++;
            }
            hql+=" order by uploadDatetime desc";
            if(pageLen==0)
                returnList=findAll(hql,Slide.class);
            else
                returnList =findByPage(hql, Slide.class, (pn - 1) * pageLen, pageLen);
        }else if(conditions==null){
            String hql="select distinct t.slide from uTag as t where t.slide.state=5";
            String results="";
            int i=0;
            for(String keyword:result){
                if(i==0)
                    results+="'"+keyword+"'";
                else
                    results+=","+"'"+keyword+"'";
                i++;
            }
            hql+=" and t.utag in("+results+")";
            hql+=" order by uploadDatetime desc";
            returnList =findByPage(hql,Slide.class,0,14);
        }else{
            String hql1="select s from Slide as s where state=5";
            int i=0;
            for(String condition:conditions){
                if(i==0){
                    if(!"".equals(condition)){
                        String type=condition.split("-")[0];
                        String subType=condition.split("-")[1];
                        if(subType.equals("全部"))
                            hql1+=" and type='"+type+"'";
                        else{
                            hql1+=" and type='"+type+"' and secondtype='"+subType+"'";
                        }
                    }
                }else{
                    if(!"".equals(condition)){
                        String type=condition.split("-")[0];
                        String subType=condition.split("-")[1];
                        if(subType.equals("全部"))
                            hql1+=" or type='"+type+"'";
                        else{
                            hql1+=" or type='"+type+"' and secondtype='"+subType+"'";
                        }
                    }
                }
                i++;
            }
            String hql="select distinct t.slide from uTag as t where t.slide.state=5 ";
            String results="";
            i=0;
            for(String keyword:result){
                if(i==0)
                    results+="'"+keyword+"'";
                else
                    results+=","+"'"+keyword+"'";
                i++;
            }
            hql+="and t.utag in("+results+")";
           /* for(String keyword:result){
                if(i==0)
                    hql+=" and utag='"+keyword+"'";
                else
                    hql+=" or utag='"+keyword+"'";
                i++;
            }*/
            hql+=" and t.slide in ("+hql1+") order by uploadDatetime desc";
            try {
                if(pageLen==0)
                    returnList=findAll(hql,Slide.class);
                else
                    returnList =findByPage(hql, Slide.class, (pn - 1) * pageLen, pageLen);
            }catch (Exception e){
                return returnList;
            }
        }
        return returnList;
    }
    public List<Slide>getList(){
        return this.findAll("from Slide where state>0",Slide.class);
    }
    public List<Slide>getList(Account teacher){
        return this.findAll("from Slide where teacher=? and state>0 order by uploadDatetime desc ",Slide.class,teacher);
    }
    public List<Slide>getList(Account teacher,int status){
        if(status==0)
            return getList(teacher);
        return this.findAll("from Slide where teacher=? and state=? order by uploadDatetime desc",Slide.class,new Object[]{teacher,status});
    }
    public List<Slide>getList(Account teacher,String title){
        return this.findAll("from Slide where teacher=? and title like ? and state>0 order by uploadDatetime desc",Slide.class,new Object[]{teacher,'%'+title+'%'});
    }
    public List<Slide>getList(Account teacher,int status,String title){
        if(title==null||title.equals(""))
            return getList(teacher,status);
        if(status==0)
            return getList(teacher,title);
        return this.findAll("from Slide where teacher=? and state=? and title like ? order by uploadDatetime desc",Slide.class,new Object[]{teacher,status,'%'+title+'%'});
    }
    //编辑、管理员
    public List<Slide>getListByStatus(String status){
        try {
            int s=Integer.parseInt(status);
            if(s==0)
                return this.findAll("from Slide where state>1 order by uploadDatetime desc", Slide.class);
            return this.findAll("from Slide where state=? order by uploadDatetime desc",Slide.class,s);
        }catch (Exception e) {
            return this.findAll("from Slide where state>1 order by uploadDatetime desc", Slide.class);
        }
    }
    public List<Slide>getPassList(){
        return this.findAll("from Slide where state=5 order by uploadDatetime desc",Slide.class);
    }
    public List<Slide>getPageList(int pn){
        return this.findByPage("from Slide where state>0",Slide.class,(pn-1)*PAGELENGTH,PAGELENGTH);
    }
    public List<Slide>getPageList(Account teacher,int pn){
        return this.findByPage("from Slide where state>0 and teacher.aId="+teacher.getaId()+" order by uploadDatetime desc",Slide.class,(pn-1)*PAGELENGTH,PAGELENGTH);
    }
    public List<Slide>getPageListForTeacher(Account teacher,int pn,int status){
        if(status==0)
            return getPageList(teacher,pn);
        return this.findByPage("from Slide where state="+status+"and teacher.aId="+teacher.getaId()+" order by uploadDatetime desc",Slide.class,(pn-1)*4,4);
    }
    public List<Slide>getPageListForTeacher(Account teacher,int pn,String title){
        return this.findByPage("from Slide where state>0 and title like '%"+title+"%' and teacher.aId="+teacher.getaId()+" order by uploadDatetime desc",Slide.class,(pn-1)*4,4);
    }
    public List<Slide>getPageListForTeacher(Account teacher,int pn,int status,String title){
        if(title==null||title.equals(""))
            return getPageListForTeacher(teacher,pn,status);
        if(status==0)
            return getPageListForTeacher(teacher,pn,title);
        return this.findByPage("from Slide where title like '%"+title+"%' and state="+status+"and teacher.aId="+teacher.getaId()+" order by uploadDatetime desc",Slide.class,(pn-1)*4,4);
    }
    public List<Slide>getPageList(Account teacher,int pn,int status){
        return this.findByPage("from Slide where state="+status+"and teacher.aId="+teacher.getaId()+" order by uploadDatetime desc",Slide.class,(pn-1)*PAGELENGTH,PAGELENGTH);
    }
    //编辑、管理员
    public List<Slide>getPageListByStatus(int pn,String status){
        try {
            int s=Integer.parseInt(status);
            if(s==0)
                return this.findByPage("from Slide where state>1 order by uploadDatetime desc", Slide.class, (pn - 1) * PAGELENGTH, PAGELENGTH);
            return this.findByPage("from Slide where state="+s +" order by uploadDatetime desc",Slide.class,(pn-1)*PAGELENGTH,PAGELENGTH);
        }catch (Exception e) {
            return this.findByPage("from Slide where state>1 order by uploadDatetime desc", Slide.class, (pn - 1) * PAGELENGTH, PAGELENGTH);
        }
    }

    public List<Slide>LikeList(Account account){
        List<Slide>slideList =this.findAll("select r.slide from Recommend as r where r.account=? order by r.cos desc",Slide.class,new Object[]{account});
        if(slideList==null||slideList.size()==0)
            slideList=hotViewList();
        return slideList;
    }

    public List<Slide>hotViewList(){
        return this.findByPage("from Slide where state=5 order by viewCount desc",Slide.class,0,10);
    }
    public List<Slide>hotList(){
        return this.findByPage("from Slide where state=5 order by downCount desc",Slide.class,0,6);
    }

    /**
     * 随机选择6条
     * @param account
     * @return
     */
    public List<Slide>RandomLikeList(Account account){
        List<Slide>slideList=null;
        slideList=this.findByPage("select distinct r.slide FROM Recommend r WHERE r.slide.state=5 and r.account="+account.getaId()+" and r.id >= ((SELECT MAX(id) FROM Recommend)-(SELECT MIN(id) FROM Recommend)) * RAND() + (SELECT MIN(id) FROM Recommend)",Slide.class,0,6);
        if(slideList==null||slideList.size()==0){
            slideList=this.findByPage("FROM Slide WHERE state=5 and sId >= ((SELECT MAX(sId) FROM Slide)-(SELECT MIN(sId) FROM Slide)) * RAND() + (SELECT MIN(sId) FROM Slide) and state=5 order by downCount desc",Slide.class,0,6);
        }
        return slideList;
    }
    public List<Slide>AllhotViewList(){
        return this.findByPage("from Slide where state=5 order by viewCount desc",Slide.class,0,15);
    }
    public List<Slide>AllhotZanList(){
        return this.findByPage("from Slide where state=5 order by zanCount desc",Slide.class,0,15);
    }
    public List<Slide>AllhotSearchList(){
        return this.findByPage("select distinct u.slide from uTag u  where state=5 order by uweight desc",Slide.class,0,15);
    }

    public List<SearchKeyword>QueryTitleList(String qkey,String []conditions){
        if(qkey==null||"".equals(qkey))
            return null;
        String sql="select * from Slide where title REGEXP '"+qkey+"' and state=5";
        if(conditions!=null) {
            int i = 0;
            for (String condition : conditions) {
                if (i == 0) {
                    if (!"".equals(condition)) {
                        String type = condition.split("-")[0];
                        String subType = condition.split("-")[1];
                        if (subType.equals("全部"))
                            sql += " and type='" + type + "'";
                        else {
                            sql += " and type='" + type + "' and secondtype='" + subType + "'";
                        }
                    }
                } else {
                    if (!"".equals(condition)) {
                        String type = condition.split("-")[0];
                        String subType = condition.split("-")[1];
                        if (subType.equals("全部"))
                            sql += " or type='" + type + "'";
                        else {
                            sql += " or type='" + type + "' and secondtype='" + subType + "'";
                        }
                    }
                }
                i++;
            }
        }
        List<Slide>slideList=this.findAllBySql(sql+" order by uploadDatetime desc",Slide.class);
        if(slideList==null||slideList.size()==0)
            return null;
        List<SearchKeyword>searchKeywordList=new ArrayList<>();
        for(Slide slide:slideList){
            SearchKeyword searchKeyword=new SearchKeyword();
            searchKeyword.setSlide(slide);
            searchKeywordList.add(searchKeyword);
        }
        return searchKeywordList;
    }
    public List<SearchKeyword>getAllSlide(String []conditions){
        String sql="from Slide where state=5";
        if(conditions!=null) {
            int i = 0;
            for (String condition : conditions) {
                if (i == 0) {
                    if (!"".equals(condition)) {
                        String type = condition.split("-")[0];
                        String subType = condition.split("-")[1];
                        if (subType.equals("全部"))
                            sql += " and type='" + type + "'";
                        else {
                            sql += " and type='" + type + "' and secondtype='" + subType + "'";
                        }
                    }
                } else {
                    if (!"".equals(condition)) {
                        String type = condition.split("-")[0];
                        String subType = condition.split("-")[1];
                        if (subType.equals("全部"))
                            sql += " or type='" + type + "'";
                        else {
                            sql += " or type='" + type + "' and secondtype='" + subType + "'";
                        }
                    }
                }
                i++;
            }
        }
        List<Slide>slideList=this.findAll(sql+" order by uploadDatetime desc",Slide.class);
        List<SearchKeyword>searchKeywordList=new ArrayList<>();
        for(Slide slide:slideList){
            SearchKeyword searchKeyword=new SearchKeyword();
            searchKeyword.setSlide(slide);
            searchKeywordList.add(searchKeyword);
        }
        return searchKeywordList;
    }
    public void deleteSlide(Slide slide){
        Account account=slide.getTeacher();
        account.setCaseCount((account.getCaseCount()-1)<0?0:(account.getCaseCount()-1));
        this.update(account);
        List<uTag>uTagList=this.findAll("from uTag where slide=?",uTag.class,slide);
        if(uTagList!=null){
            for(uTag tag:uTagList){
                tag.setStatus(3);
                this.update(tag);
            }
        }
        slide.setState(0);
        this.update(slide);
    }

    //添加日志 状态0表示删除   1 草稿箱 2 提交待审 3 正在编审 4 驳回 5 审核通过
    public void addLog(Slide slide, Integer update){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        OperationLog operationLog = new OperationLog();
        operationLog.setSlide(slide);
        if(update == null) {
            switch (slide.getState()) {
                case 0:
                    operationLog.setLogInfo("案例" + slide.getTitle() + "被删除");
                    break;
                case 1:
                    operationLog.setLogInfo("案例" + slide.getTitle() + "被保存");
                    break;
                case 2:
                    operationLog.setLogInfo("案例" + slide.getTitle() + "被提交");
                    break;
                case 3:
                    operationLog.setLogInfo("案例" + slide.getTitle() + "正在编审");
                    break;
                case 4:
                    operationLog.setLogInfo("案例" + slide.getTitle() + "被拒绝录用");
                    break;
                case 5:
                    operationLog.setLogInfo("案例" + slide.getTitle() + "被审核通过");
                    break;
                case 6:
                    operationLog.setLogInfo("案例" + slide.getTitle() + "被退回修改"  + ",驳回原因:" + slide.getOpinion());
                    break;
                default:
                    operationLog.setLogInfo("案例默认操作");
                    break;
            }
        }else{
            operationLog.setLogInfo("案例" + slide.getTitle() + "被更新");
        }
        operationLog.setTimestamp(System.currentTimeMillis());
        operationLog.setFormatTime(sdf.format(new Date()));
        this.save(operationLog);
    }

    public List<OperationLog> getLogs(Long sid){
        return this.findAll("from OperationLog where slide = " + sid + " order by timestamp desc", OperationLog.class);
    }
}
