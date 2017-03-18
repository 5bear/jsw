package com.springapp.dao;

import com.springapp.entity.CoTag;
import com.springapp.entity.Slide;
import com.springapp.entity.uTag;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 11369 on 2016/7/23.
 * 标签
 */
@Repository
public class TagDao extends BaseDao {
    public List<uTag>getListByTypeByPage(String []result,String []conditions,int pn,int pageLen){
        List<uTag>returnList = null;
        if(result==null&&conditions==null) {
            if(pageLen==0)
                returnList =findAll("from uTag where slide.state=5 group by slide order by uweight desc", uTag.class);
            else
                returnList = findByPage("from uTag where slide.state=5 group by slide order by uweight desc", uTag.class, (pn - 1) * pageLen, pageLen);
        }
        else if(result==null){
            String hql="from uTag where slide.state=5";
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
            hql+=" order by uweight desc";
            if(pageLen==0)
                returnList=findAll(hql,uTag.class);
            else
                returnList =findByPage(hql, uTag.class, (pn - 1) * pageLen, pageLen);
        }else if(conditions==null){
            String hql="select t from uTag as t where t.slide.state=5";
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
            hql+=" order by uweight desc";
            returnList =findByPage(hql,uTag.class,0,14);
        }else{
            String hql1="select uTag from uTag where slide.state=5";
            int i=0;
            for(String condition:conditions){
                if(i==0){
                    if(!"".equals(condition)){
                        String type=condition.split("-")[0];
                        String subType=condition.split("-")[1];
                        if(subType.equals("全部"))
                            hql1+=" and slide.type='"+type+"'";
                        else{
                            hql1+=" and slide.type='"+type+"' and slide.secondtype='"+subType+"'";
                        }
                    }
                }else{
                    if(!"".equals(condition)){
                        String type=condition.split("-")[0];
                        String subType=condition.split("-")[1];
                        if(subType.equals("全部"))
                            hql1+=" or slide.type='"+type+"'";
                        else{
                            hql1+=" or slide.type='"+type+"' and slide.secondtype='"+subType+"'";
                        }
                    }
                }
                i++;
            }
            String hql="select t from uTag as t where t.slide.state=5";
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
            hql+=" and t.slide in ("+hql1+") order by uweight desc";
            try {
                if(pageLen==0)
                    returnList=findAll(hql,uTag.class);
                else
                    returnList =findByPage(hql, uTag.class, (pn - 1) * pageLen, pageLen);
            }catch (Exception e){
                return returnList;
            }
        }
        return returnList;
    }
    public List<uTag>getPassedList(){
        return this.findAllBySql("select * from uTag where status=1 group by utag order by convert(utag USING gbk) COLLATE gbk_chinese_ci asc",uTag.class);
    }
    public List<uTag>getList(){
        return this.findAll("from uTag",uTag.class);
    }
    public List<uTag>getPassList(){
        return this.findAll("from uTag where status=1 order by uweight desc",uTag.class);
    }
    /*获得用户添加标签*/
    public List<uTag>getUserTag(Slide slide){
        return this.findAll("from uTag where role=0 and status=1 and slide=? order by uweight desc",uTag.class,slide);
    }
    public List<uTag>getUserTagByStatus(String status){
        try{
            int s=Integer.parseInt(status);
            return this.findAll("from uTag where role=0 and status=? and userCount>=5  order by uweight desc",uTag.class,s);
        }catch (Exception e) {
            return this.findAll("from uTag where role=0 and userCount>=5  order by uweight desc", uTag.class);
        }
    }
    public List<uTag>getUserPassTag(){
        return this.findAll("from uTag where status=1 and role=0 order by uweight desc",uTag.class);
    }
    /*获得教师添加标签*/
    public List<uTag>getTeacherTag(){
        return this.findAll("from uTag where status=1 and role=1 order by uweight desc",uTag.class);
    }
    public List<uTag>getTeacherTag(Slide slide){
        return this.findAll("from uTag where role=1 and slide=? order by uweight desc",uTag.class,slide);
    }
    /*管理员添加标签*/
    public List<uTag>getAdminTag(){
        return this.findAll("from uTag where status=1 and role=2 order by uweight desc",uTag.class);
    }
    public List<uTag>getAdminTag(Slide slide){
        return this.findAll("from uTag where status=1 and role=2 and slide=? order by uweight desc",uTag.class,slide);
    }
    //获得管理员+教师标签
    public List<uTag>getConstTag(Slide slide){
        return this.findAll("from uTag where slide=? and role=1 or role=2 and slide=? order by uweight desc",uTag.class,new Object[]{slide,slide});
    }
    /*public List<uTag>getConstTag(Slide slide){
        return this.findAll("from uTag where status=1 and slide=? and role=1 and slide.state=5 or role=2 and status=1 and slide=? and slide.state=5 order by uweight desc",uTag.class,new Object[]{slide,slide});
    }*/
    public List<uTag>getAllConstTag(Slide slide){
        return this.findAll("from uTag where slide=? and role=1 or role=2 and slide=? order by uweight desc",uTag.class,new Object[]{slide,slide});
    }
    public List<uTag>getPageList(int pn){
        return this.findByPage("from uTag where role=0",uTag.class,(pn-1)*PAGELENGTH,PAGELENGTH);
    }
    public List<uTag>getPageListByStatus(int pn,String status){
        try{
            int s=Integer.parseInt(status);
            return this.findByPage("from uTag where role=0 and userCount>=5  and status="+s,uTag.class,(pn-1)*PAGELENGTH,PAGELENGTH);
        }catch (Exception e) {
            return this.findByPage("from uTag where role=0 and userCount>=5 ", uTag.class, (pn - 1) * PAGELENGTH, PAGELENGTH);
        }
    }
    public uTag getByTag(String tag,Slide slide){
        return this.find("from uTag where utag=? and slide=?",uTag.class,new Object[]{tag,slide});
    }

    /**
     * 获得查询top10的标签
     * @return
     */
    public List<uTag> getTopTags(){
        return this.findByPage("from uTag where tagId not in(select uTag.tagId from UserInterest) and  role!=0 and slide.state=5 order by uweight desc",uTag.class,0,10);
    }

    private static int k=3;
    public Map<String,Double> getCoTagList(String tag){
        List<CoTag>coTags= this.findAllBySql("select * from CoTag as c where c.uTag REGEXP '"+tag+"' or c.coTag REGEXP '"+tag+"' and coIndex>0.2 group by id order by coIndex desc ",CoTag.class/*,0,k*/);
        if(coTags==null)
            return null;
        Map<String,Double>termMap=new HashMap<>();
        for(CoTag cotag:coTags){
            Double index=termMap.get(cotag.getuTag());
            if(index==null){
                termMap.put(cotag.getuTag(),cotag.getCoIndex());
            }
            index=termMap.get(cotag.getCoTag());
            if(index==null){
                termMap.put(cotag.getCoTag(),cotag.getCoIndex());
            }
        }
        return termMap;
    }
    public List<uTag>getByTag(String tag,String []conditions){
        String sql="from uTag where status=1 and utag='"+tag+"'";
        if(conditions!=null) {
            int i = 0;
            for (String condition : conditions) {
                if (i == 0) {
                    if (!"".equals(condition)) {
                        String type = condition.split("-")[0];
                        String subType = condition.split("-")[1];
                        if (subType.equals("全部"))
                            sql += " and slide.type='" + type + "'";
                        else {
                            sql += " and slide.type='" + type + "' and slide.secondtype='" + subType + "'";
                        }
                    }
                } else {
                    if (!"".equals(condition)) {
                        String type = condition.split("-")[0];
                        String subType = condition.split("-")[1];
                        if (subType.equals("全部"))
                            sql += " or slide.type='" + type + "'";
                        else {
                            sql += " or slide.type='" + type + "' and slide.secondtype='" + subType + "'";
                        }
                    }
                }
                i++;
            }
        }
        return this.findAll(sql+" group by slide",uTag.class);
    }
}
