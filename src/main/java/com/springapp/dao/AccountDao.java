package com.springapp.dao;

import com.springapp.entity.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by 11369 on 2016/7/14.
 */
@Repository
public class AccountDao extends BaseDao {
    public void deleteUser(Account account){
        /*List<UserInterest>userInterests=this.getUserInterest(account);
        if(userInterests!=null) {
            for (UserInterest userInterest : userInterests) {
                this.delete(userInterest);
            }
        }*/
        List<Slide>slideList=this.findAll("from Slide where teacher=?",Slide.class, account);
        if(slideList!=null){
            for(Slide slide:slideList){
                slide.setState(0);//0表示删除
                this.update(slide);
            }
        }
        account.setIsDelete(1);//1表示删除
        this.update(account);
    }
    public List<Account>getList(){
        return this.findAll("from Account where isDelete=0 order by rDatetime desc",Account.class);
    }
    public List<Account>getPageList(int pn){
        return this.findByPage("from Account where isDelete=0 order by rDatetime desc",Account.class,(pn-1)*PAGELENGTH,PAGELENGTH);
    }
    public List<UserZan>getUserZanList(Account account){
        return this.findAll("from UserZan where account=?", UserZan.class, new Object[]{account});
    }
    public List<UserZan>getUserZanList(Account account,int pn){
        return this.findByPage("from UserZan where account.aId="+account.getaId(),UserZan.class,(pn-1)*PAGELENGTH,PAGELENGTH);
    }
    public List<UserCollect>getUserCollectList(Account account){
        return this.findAll("from UserCollect where account=?",UserCollect.class,new Object[]{account});
    }
    public List<UserCollect>getUserCollectList(Account account,int pn){
        return this.findByPage("from UserCollect where account.aId="+account.getaId(),UserCollect.class,(pn-1)*PAGELENGTH,PAGELENGTH);
    }
    public List<UserDown>getUserDownList(Account account){
        return this.findAll("from UserDown where account=?",UserDown.class,new Object[]{account});
    }
    public List<UserDown>getUserDownList(Account account,int pn){
        return this.findByPage("from UserDown where account.aId="+account.getaId(),UserDown.class,(pn-1)*PAGELENGTH,PAGELENGTH);
    }
    public UserTag getUserTag(Account account,Slide slide,String tag){
        return this.find("from UserTag where account=? and tag=? and slide=?",UserTag.class,new Object[]{account,tag,slide});
    }
    public Account getByEmail(String email){
        return this.find("from Account where email=? order by rDatetime desc",Account.class,new Object[]{email});
    }
    public List<Account>getTeacher(){
        return this.findAll("from Account where isDelete=0 order by rDatetime desc",Account.class);
    }
    public List<Account>getTeacherPageList(int pn){
        return this.findByPage("from Account where isDelete=0 order by rDatetime desc",Account.class,(pn-1)*PAGELENGTH,PAGELENGTH);
    }
}
