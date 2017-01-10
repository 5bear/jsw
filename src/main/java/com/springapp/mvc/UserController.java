package com.springapp.mvc;

import com.springapp.classes.Base64Image;
import com.springapp.entity.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by 11369 on 2016/7/15.
 * 用户注册，登录，点赞，收藏等
 */
@Controller
@RequestMapping(value = "")
public class UserController extends BaseController {
    @RequestMapping(value = "LikeCase")
    public ModelAndView LikeCase(HttpSession session){
        ModelAndView modelAndView=new ModelAndView();
        Account account= (Account) session.getAttribute("account");
        if(account!=null){
            modelAndView.addObject("likeList",slideDao.RandomLikeList(account));
        }
        modelAndView.setViewName("view/like-case");
        return modelAndView;
    }
    @RequestMapping(value = "userLogout")
    public String userLogout(HttpSession session){
        session.removeAttribute("account");
        return "view/index";
    }
    @RequestMapping(value = "loginCheck",method = RequestMethod.POST)
    @ResponseBody
    public String loginCheck(String email,String password,HttpSession session){
        Account account=accountDao.getByEmail(email);
        if(account!=null) {
            if (account.getPassword().equals(password)) {
                account.setLastLogin(new Timestamp(new Date().getTime()));
                accountDao.update(account);
                session.setAttribute("account",account);
                return "user";
            }else{
                return "密码错误";
            }
        }else{
            Admin admin=adminDao.getByAdmin(email);
            if(admin!=null){
                if(admin.getPassword().equals(password)){
                    session.setAttribute("admin",admin);
                    return "admin";
                }else{
                   return "密码错误";
                }
            }else{
                Editor editor=editorDao.getByNo(email);
                if(editor!=null){
                    if(editor.getPassword().equals(password)){
                        session.setAttribute("editor",editor);
                        return "editor";
                    }
                    else
                        return "密码错误";
                }
            }
        }
        return "不存在该角色";
    }

    /*用户注册*/
    @RequestMapping(value = "Register")
    public ModelAndView Register(){
        ModelAndView modelAndView=new ModelAndView();
        List<uTag>uTagList=baseDao.findByPage("from uTag where role!=0 and slide.state=1 order by uweight desc",uTag.class,0,10);
        modelAndView.addObject("tags",uTagList);
        modelAndView.setViewName("view/register");
        return modelAndView;
    }
    @RequestMapping(value = "Register",method = RequestMethod.POST)
    public String Registerform(HttpSession session,Account account){
        account.setrDatetime(new Timestamp(new Date().getTime()));
        if ("".equals(account.getNickName()))
            account.setNickName("u"+new Date().getTime());
        if(!account.getHeadPath().equals("heads/head.png")) {
            String realPath = session.getServletContext().getRealPath("/WEB-INF/pages/heads/");
            File mainFile = new File(realPath);
            //文件保存目录URL
            String newFileName;
            if (!mainFile.exists())
                mainFile.mkdirs();
            newFileName = new Date().getTime() + "." + "jpg";
            if(Base64Image.GenerateImage(account.getHeadPath(),realPath + "/" + newFileName))
                account.setHeadPath("heads/" + newFileName);
            else
                return "redirect:/Register";
        }
        account.setScore(0f);
        account.setIntegral(10);
        /*account.setExist(1);*/
        baseDao.save(account);
        /*if(account.getInterests()!=null) {
            for (Long id : account.getInterests()) {
                uTag tag = baseDao.get(uTag.class, id);
                UserInterest userInterest = new UserInterest();
                userInterest.setAccount(account);
                userInterest.setuTag(tag);
                baseDao.save(userInterest);
            }
        }*/
        return "redirect:/Index";
    }
    /*检测邮箱是否已经被注册*/
    @RequestMapping(value = "checkEmail",method = RequestMethod.POST)
    @ResponseBody
    public String checkEmail(String email,Long id){
        Account checkAccount=null;
        if(id!=0)
            checkAccount=accountDao.get(Account.class,id);
        List<Account>accountList=accountDao.getList();
        for(Account account:accountList){
            if(email.equals(account.getEmail())) {
                if (checkAccount!=null&&checkAccount.equals(account))
                    return "not_exist";
                return "exist";
            }
        }
        return "not_exist";
    }
    /*修改密码*/
    @RequestMapping(value = "PasswordManage",method = RequestMethod.POST)
    @ResponseBody
    public String PasswordManage(HttpSession session,String newPwd){
        Account account= (Account) session.getAttribute("account");
        account.setPassword(newPwd);
        accountDao.update(account);
        return "success";
    }

    @RequestMapping(value = "UserIndex")
    public ModelAndView UserIndex(HttpSession session){
        ModelAndView modelAndView=new ModelAndView();
        Account account= (Account) session.getAttribute("account");
        if(account==null){
            return new ModelAndView("redirect:/Index");
        }
        modelAndView.addObject(account);
        List<UserZan>userZanList=baseDao.findAll("from UserZan where account=?",UserZan.class,new Object[]{account});
        modelAndView.addObject("userZanList",userZanList);
        List<UserCollect>userCollectList=baseDao.findAll("from UserCollect where account=?",UserCollect.class,new Object[]{account});
        modelAndView.addObject("userCollectList",userCollectList);
        List<UserDown>userDownList=baseDao.findAll("from UserDown where account=?",UserDown.class,new Object[]{account});
        modelAndView.addObject("userDownList",userDownList);
        modelAndView.setViewName("view/user-index");
        return modelAndView;
    }


    @RequestMapping(value = "UserInfo")
    public ModelAndView UserInfo(HttpSession session){
        ModelAndView modelAndView=new ModelAndView();
        Account account= (Account) session.getAttribute("account");
        if(account==null){
            return new ModelAndView("redirect:/Index");
        }
        modelAndView.addObject(account);
/*
        List<uTag>myInterests=accountDao.getInterest(account);
*/
        List<uTag>topTags=baseDao.findByPage("from uTag where role!=0 and slide.state=1 order by uweight desc",uTag.class,0,10);
/*
        modelAndView.addObject("myInterests",myInterests);
*/
        modelAndView.addObject("topTags",topTags);
        modelAndView.setViewName("view/user-info");
        return modelAndView;
    }
    @RequestMapping(value = "UserInfo",method = RequestMethod.POST)
    public String UserInfo(Long aId,
                           String nickName,
                           int sex,
                           String email,
                           String headPath,
                           String department,
                           String remark,
                          /* Long []interests,//新增兴趣点
                           Long []user_interests,//已选兴趣点/取消*/
                           HttpSession session) {
        Account account = accountDao.get(Account.class, aId);
/*
        List<UserInterest>userInterestList=baseDao.findAll("from UserInterest where account=?",UserInterest.class,account);
*/
        /*for(UserInterest userInterest:userInterestList){
            boolean flag=false;
            if(user_interests!=null) {
                for (Long i : user_interests) {
                    if (userInterest.getuTag().getTagId().equals(i)) {
                        flag = true;
                    }
                }
            }
            if(!flag)
                baseDao.delete(userInterest);
        }
        if(interests!=null) {
            for (Long i : interests) {
                uTag tag = baseDao.get(uTag.class, i);
                UserInterest userInterest = new UserInterest();
                userInterest.setuTag(tag);
                userInterest.setAccount(account);
                baseDao.save(userInterest);
            }
        }*/
        account.setNickName(nickName);
        account.setSex(sex);
        account.setEmail(email);
        account.setDepartment(department);
        account.setRemark(remark);
        if (!account.getHeadPath().equals(headPath)) {
            String realPath = session.getServletContext().getRealPath("/WEB-INF/pages/heads/");
            File mainFile = new File(realPath);
            //文件保存目录URL
            String newFileName = "";
            if (!mainFile.exists())
                mainFile.mkdirs();
            newFileName = new Date().getTime() + "." + "jpg";
            Base64Image.GenerateImage(headPath,realPath + "/" + newFileName);
            account.setHeadPath("heads/" + newFileName);
        }
        accountDao.update(account);
        session.setAttribute("account",account);
        return "redirect:/UserInfo";
    }

    /**
     * 评分
     * @param tId
     * @param score
     * @param session
     * @return
     */
    @RequestMapping(value = "evaluate",method = RequestMethod.POST)
    @ResponseBody
    public String evaluate(Long tId,Float score,HttpSession session){
        if(tId==null)
            return "fail";
        Account account = (Account) session.getAttribute("account");
        if(account==null)
            return "fail";
        Account teacher=accountDao.get(Account.class,tId);
        if(account==null||teacher==null)
            return "fail";
        UserScore userScore=baseDao.find("from UserScore where account=? and teacher=?",UserScore.class,new Object[]{account,teacher});
        if(userScore==null){
            userScore=new UserScore();
            userScore.setAccount(account);
            userScore.setTeacher(teacher);
            userScore.setScore(score);
            baseDao.save(userScore);
            teacher.setScore((teacher.getScore()*teacher.getScoreCount()+score)/(teacher.getScoreCount()+1));
            teacher.setScoreCount(teacher.getScoreCount()+1);
            accountDao.update(teacher);
        }else{
            teacher.setScore((teacher.getScore()*teacher.getScoreCount()-userScore.getScore()+score)/teacher.getScoreCount());
            accountDao.update(teacher);
            userScore.setScore(score);
            baseDao.update(userScore);
        }
        return "success";
    }
    /**
     * 未点赞点赞/点过赞取消
     * @param sId
     * @param aId
     * @return
     */
    @RequestMapping(value = "Zan",method = RequestMethod.POST)
    @ResponseBody
    public String Zan(Long sId,Long aId,HttpSession session) {
        Account account = accountDao.get(Account.class, aId);
        Slide slide=baseDao.get(Slide.class,sId);
        UserZan userZan=baseDao.find("from UserZan where account=? and slide=?",UserZan.class,new Object[]{account,slide});
        if(userZan!=null) {
            baseDao.delete(userZan);
            slide.setZanCount(slide.getZanCount()-1);
            baseDao.update(slide);
            return "fail";
        }
        else {
            userZan=new UserZan();
            userZan.setAccount(account);
            userZan.setSlide(slide);
            userZan.setZanTime(new Timestamp(System.currentTimeMillis()));
            baseDao.save(userZan);
            slide.setZanCount(slide.getZanCount()+1);
        }
        baseDao.update(slide);
        List<SearchKeyword>searchKeywords= (List<SearchKeyword>) session.getAttribute("searchKeywords");
        if(searchKeywords!=null){
            for(SearchKeyword searchKeyword:searchKeywords){
                if(searchKeyword.getSlide().getsId().equals(slide.getsId())){
                    List<uTag>uTagList=searchKeyword.getuTagList();
                    if(uTagList==null)
                        continue;
                    for(uTag uTag:uTagList){
                        uTag.setUweight(uTag.getUweight()+7);
                        tagDao.update(uTag);
                    }
                }
            }
        }
        return "success";
    }
    /**
     * 未收藏收藏/收藏过取消
     * @param sId
     * @param aId
     * @return
     */
    @RequestMapping(value = "Collect",method = RequestMethod.POST)
     @ResponseBody
     public String Collect(Long sId,Long aId,HttpSession session) {
        Account account = accountDao.get(Account.class, aId);
        Slide slide=baseDao.get(Slide.class,sId);
        UserCollect userCollect=baseDao.find("from UserCollect where account=? and slide=?",UserCollect.class,new Object[]{account,slide});
        if(userCollect!=null) {
            baseDao.delete(userCollect);
            slide.setCollectCount(slide.getCollectCount() - 1);
            baseDao.update(slide);
            return "fail";
        }
        else {
            userCollect=new UserCollect();
            userCollect.setAccount(account);
            userCollect.setSlide(slide);
            userCollect.setCollectTime(new Timestamp(System.currentTimeMillis()));
            baseDao.save(userCollect);
            slide.setCollectCount(slide.getCollectCount()+1);
        }
        baseDao.update(slide);
        List<SearchKeyword>searchKeywords= (List<SearchKeyword>) session.getAttribute("searchKeywords");
        if(searchKeywords!=null){
            for(SearchKeyword searchKeyword:searchKeywords){
                if(searchKeyword.getSlide().equals(slide)){
                    List<uTag>uTagList=searchKeyword.getuTagList();
                    if(uTagList==null)
                        continue;
                    for(uTag uTag:uTagList){
                        uTag.setUweight(uTag.getUweight()+7);
                        tagDao.update(uTag);
                    }
                }
            }
        }
        return "success";
    }

    /**
     * 下载
     * @param sId
     * @param aId
     * @return
     */
    @RequestMapping(value = "Down",method = RequestMethod.POST)
    @ResponseBody
    public String Down(Long sId,Long aId,HttpSession session) {
        Account account = accountDao.get(Account.class, aId);
        if(account==null)
            return "fail";
        Slide slide=baseDao.get(Slide.class,sId);
        if(slide==null)
            return "fail";
        UserDown userDown=baseDao.find("from UserDown where account=? and slide=?",UserDown.class,new Object[]{account,slide});
        if(userDown==null)
        {
            userDown=new UserDown();
            userDown.setAccount(account);
            userDown.setSlide(slide);
            userDown.setDownTime(new Timestamp(System.currentTimeMillis()));
            baseDao.save(userDown);
            slide.setDownCount(slide.getDownCount()+1);
            slideDao.update(slide);
        }else{
            slide.setDownCount(slide.getDownCount()+1);
            slideDao.update(slide);
        }
        List<SearchKeyword>searchKeywords= (List<SearchKeyword>) session.getAttribute("searchKeywords");
        if(searchKeywords!=null){
            for(SearchKeyword searchKeyword:searchKeywords){
                if(searchKeyword.getSlide().equals(slide)){
                    List<uTag>uTagList=searchKeyword.getuTagList();
                    if(uTagList==null)
                        continue;
                    for(uTag uTag:uTagList){
                        uTag.setUweight(uTag.getUweight()+7);
                        tagDao.update(uTag);
                    }
                }
            }
        }
        return slide.getFilePath();
    }
    @RequestMapping(value = "addTag",method = RequestMethod.POST)
    @ResponseBody
    public String addTag(String t,Long slide,HttpSession session){
        Slide slide1=slideDao.get(Slide.class,slide);
        if(slide1==null)
            return "无效课件";
        Account account= (Account) session.getAttribute("account");
        if(account!=null){
            UserTag userTag=accountDao.getUserTag(account,slide1,t);
            if(userTag==null){
                userTag=new UserTag();
                userTag.setAccount(account);
                userTag.setSlide(slide1);
                userTag.setTag(t);
                userTag.setAddTime(new Timestamp(System.currentTimeMillis()));
                accountDao.save(userTag);
            }else
                return "添加成功,等待管理员审核通过";
        }
        uTag tag=tagDao.getByTag(t,slide1);
        if(tag==null){
            tag=new uTag();
            tag.setUtag(t);
            tag.setStatus(0);
            tag.setUweight((long)50);
            tag.setUserCount(1);
            tag.setRole(0);
            tag.setSlide(slide1);
            baseDao.save(tag);
        }else{
            tag.setUserCount(tag.getUserCount()+1);
            tagDao.update(tag);
        }
        return "添加成功,等待管理员审核通过";
    }
}
