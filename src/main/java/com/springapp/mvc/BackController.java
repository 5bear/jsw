package com.springapp.mvc;

import com.springapp.entity.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 11369 on 2016/7/12.
 * 管理后台页面
 */
@Controller
@RequestMapping(value = "")
public class BackController extends BaseController {
    @RequestMapping(value = "EditorManagement")
    public ModelAndView EditorManagement(HttpServletRequest request,HttpSession session){
        ModelAndView modelAndView=new ModelAndView();
        Admin admin= (Admin) session.getAttribute("admin");
        if(admin==null)
            return new ModelAndView("redirect:/Login");
        String pn=request.getParameter("pn");
        int pageNum=1;
        if(pn!=null&&!"".equals(pn))
        {
            try{
                pageNum=Integer.parseInt(pn);
            }catch (Exception e){
                pageNum=1;
            }
        }
        List<Editor>editorList=editorDao.getEditor();
        int totalPage;
        if(editorList.size()%baseDao.PAGELENGTH==0)
            totalPage=editorList.size()/baseDao.PAGELENGTH;
        else
            totalPage=editorList.size()/baseDao.PAGELENGTH+1;
        List<Editor>myList=editorDao.getEditorPageList(pageNum);
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        modelAndView.setViewName("back/EditorManagement");
        return modelAndView;
    }
    @RequestMapping(value = "EditorManagement/{id}")
    public ModelAndView EditorUpdate(HttpSession session, @PathVariable("id") Long id){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("back/EditorManagement-edit");
        if(id!=null&&id!=0){
            Editor editor=editorDao.get(Editor.class,id);
            if(editor==null)
                return new ModelAndView("view/login");
            modelAndView.addObject("editor",editor);
        }
        return modelAndView;
    }

    @RequestMapping(value = "updateEditor",method = RequestMethod.POST)
    @ResponseBody
    public String updateEditor(Long id,String nickName,String no,String remark){
        Editor editor;
        if(id==0){
            editor=new Editor();
            editor.setUsername(nickName);
            editor.setNo(no);
            editor.setRemark(remark);
            editor.setPassword("123");
            editorDao.save(editor);
            return "success";
        }else{
            editor=editorDao.get(Editor.class,id);
            editor.setUsername(nickName);
            editor.setNo(no);
            editor.setRemark(remark);
            accountDao.update(editor);
        }
        return "success";
    }
    @RequestMapping(value = "adminLogout")
    public String adminLogout(HttpSession session){
        session.removeAttribute("admin");
        return "view/login";
    }
    @RequestMapping(value = "adminLoginCheck",method = RequestMethod.POST)
    @ResponseBody
    public String adminLoginCheck(String account,String password,HttpSession session){
        if(account==null||"".equals(account))
            return "false";
        Admin admin=adminDao.getByAdmin(account);
        if(admin==null)
            return "账号不存在";
        if(!admin.getPassword().equals(password))
            return "密码错误";
        session.setAttribute("admin",admin);
        return "success";
    }
    @RequestMapping(value = "UserManage")
    public ModelAndView UserManage(HttpServletRequest request,HttpSession session){
        ModelAndView modelAndView=new ModelAndView();
        Admin admin= (Admin) session.getAttribute("admin");
        if(admin==null)
            return new ModelAndView("redirect:/Login");
        String pn=request.getParameter("pn");
        int pageNum=1;
        if(pn!=null&&!"".equals(pn))
        {
            try{
                pageNum=Integer.parseInt(pn);
            }catch (Exception e){
                pageNum=1;
            }
        }
        List<Account>accountList=accountDao.getList();
        int totalPage;
        if(accountList.size()%baseDao.PAGELENGTH==0)
            totalPage=accountList.size()/baseDao.PAGELENGTH;
        else
            totalPage=accountList.size()/baseDao.PAGELENGTH+1;
        List<Account>myList=accountDao.getPageList(pageNum);
        /*for(Account account:myList){
            List<UserInterest>userInterestList=baseDao.findAll("from UserInterest where account=?",UserInterest.class,new Object[]{account});
            String interest="";
            int len=userInterestList.size();
            for(int i=0;i<len;i++){
                if(i==0)
                    interest+=userInterestList.get(i).getuTag().getUtag();
                else{
                    interest+=","+userInterestList.get(i).getuTag().getUtag();
                }
            }
            account.setInterest(interest);
        }*/
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        modelAndView.setViewName("back/UserManage");
        return modelAndView;
    }
    @RequestMapping(value = "UserManageEdit")
    public ModelAndView UserManageEdit(Long id,HttpSession session){
        ModelAndView modelAndView=new ModelAndView();
        Admin admin= (Admin) session.getAttribute("admin");
        if(admin==null)
            return new ModelAndView("redirect:/Login");
        Account account=accountDao.get(Account.class, id);
        /*List<UserInterest>userInterestList=baseDao.findAll("from UserInterest where account=?",UserInterest.class,new Object[]{account});
        String interest="";
        int len=userInterestList.size();
       for(int i=0;i<len;i++){
           if(i==0)
               interest+=userInterestList.get(i).getuTag().getUtag();
           else{
               interest+=","+userInterestList.get(i).getuTag().getUtag();
           }
       }
        modelAndView.addObject("interests",interest);*/
        modelAndView.addObject("account",account);
        modelAndView.setViewName("back/UserManage-edit");
        return modelAndView;
    }
    @RequestMapping(value = "UserManageEditForm",method = RequestMethod.POST)
    public String UserManageEditForm(Long aId,
            String nickName,
            int sex,
            String email,
            String password){
        Account account=accountDao.get(Account.class,aId);
        account.setNickName(nickName);
        account.setSex(sex);
        account.setEmail(email);
        account.setPassword(password);
        accountDao.update(account);
        return "redirect:/UserManageEdit?id="+account.getaId();
    }
    @RequestMapping(value = "deleteUser",method = RequestMethod.POST)
    @ResponseBody
    public String DeleteUser(Long id){
        Account account=accountDao.get(Account.class,id);
        if(account==null)
            return "success";
        accountDao.deleteUser(account);
        return "success";
    }
    @RequestMapping(value = "TeacherManage")
    public ModelAndView TeacherManage(HttpSession session){
        ModelAndView modelAndView=new ModelAndView();
        Admin admin= (Admin) session.getAttribute("admin");
        if(admin==null)
            return new ModelAndView("redirect:/Login");
        List<Account>teacherList=accountDao.getTeacher();
        modelAndView.addObject("list",teacherList);
        modelAndView.setViewName("back/TeacherManage");
        return modelAndView;
    }
    @RequestMapping(value = "TeacherManageEdit")
    public ModelAndView TeacherManageEdit(HttpServletRequest request,HttpSession session){
        Admin admin= (Admin) session.getAttribute("admin");
        if(admin==null)
            return new ModelAndView("redirect:/Login");
        String id=request.getParameter("id");
        ModelAndView modelAndView=new ModelAndView();
        if(id!=null&&!"".equals("id")) {
            Account teacher = baseDao.get(Account.class,Long.parseLong(id));
            if(teacher!=null)
                modelAndView.addObject("teacher", teacher);
        }
        modelAndView.setViewName("back/TeacherManage-edit");
        return modelAndView;
    }
    @RequestMapping(value = "TeacherManageEdit",method = RequestMethod.POST)
    public String TeacherManageAdd(Account teacher){
        teacher.setCaseCount(0);
        teacher.setScore(0.0f);
        teacher.setPassword("123");
        teacher.setHeadPath("heads/head.png");
        teacher.setrDatetime(new Timestamp(System.currentTimeMillis()));
        baseDao.save(teacher);
        return "redirect:/TeacherManage";
    }
    @RequestMapping(value = "TeacherEdit",method = RequestMethod.POST)
    @ResponseBody
    public String TeacherEdit(Long id,String no,String remark){
        Account teacher=baseDao.get(Account.class,id);
/*
        teacher.setNo(no);
*/
        teacher.setNo(no);
        teacher.setRemark(remark);
        baseDao.update(teacher);
        return "redirect:/TeacherManage";
    }
    @RequestMapping(value = "deleteTeacher",method = RequestMethod.POST)
    @ResponseBody
    public String deleteTeacher(Long id){
        Account teacher=baseDao.get(Account.class,id);
        if(teacher==null)
            return "fail";
        accountDao.deleteUser(teacher);
        return "success";
    }
    @RequestMapping(value = "TagManage")
    public ModelAndView TagManage(HttpServletRequest request,HttpSession session){
        Admin admin= (Admin) session.getAttribute("admin");
        if(admin==null)
            return new ModelAndView("redirect:/Login");
        ModelAndView modelAndView=new ModelAndView();
        String pn=request.getParameter("pn");
        String status=request.getParameter("status");
        int pageNum=1;
        if(pn!=null&&!"".equals(pn))
        {
            try{
                pageNum=Integer.parseInt(pn);
            }catch (Exception e){
                pageNum=1;
            }
        }
        List<uTag>tagList=tagDao.getUserTagByStatus(status);
        int totalPage;
        if(tagList.size()%baseDao.PAGELENGTH==0)
            totalPage=tagList.size()/baseDao.PAGELENGTH;
        else
            totalPage=tagList.size()/baseDao.PAGELENGTH+1;
        List<uTag>myList=tagDao.getPageListByStatus(pageNum, status);
        if(status!=null)
            request.setAttribute("status",status);
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        modelAndView.setViewName("back/TagManage");
        return modelAndView;
    }
    @RequestMapping(value = "addAdminTag",method = RequestMethod.POST)
    @ResponseBody
    public String addAdminTag(String tag,Long sId){
        Slide slide=slideDao.get(Slide.class,sId);
        //如果状态未通过并且未驳回，状态置为编审中
        if(slide.getState()==2) {
            slide.setState(3);
            slideDao.update(slide);
        }
        uTag uTag=tagDao.getByTag(tag,slide);
        if(uTag==null){
            uTag=new uTag();
            uTag.setUtag(tag);
            uTag.setRole(2);
            uTag.setUweight((long)50);
            uTag.setStatus(1);
            uTag.setSlide(slide);
            uTag.setUserCount(1);
            tagDao.save(uTag);
        }else{
            uTag.setUserCount(uTag.getUserCount()+1);
            tagDao.update(uTag);
        }
        return "success";
    }
    @RequestMapping(value = "changeStatus",method = RequestMethod.POST)
    @ResponseBody
    public String changeStatus(int status,Long tagId){
        try {
            uTag tag = tagDao.get(uTag.class, tagId);
            if(status==3){
                tagDao.delete(tag);
                return "success";
            }
            tag.setStatus(status);
            tagDao.update(tag);
        }catch (Exception e){
            return "fail";
        }
        return "success";
    }
    @RequestMapping(value = "PasswordManage")
    public ModelAndView PasswordManage(HttpSession session){
        Admin admin= (Admin) session.getAttribute("admin");
        if(admin==null)
            return new ModelAndView("redirect:/Login");
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("back/PasswordManage");
        return modelAndView;
    }
    /*修改密码*/
    @RequestMapping(value = "adminPasswordManage",method = RequestMethod.POST)
    @ResponseBody
    public String adminPasswordManage(HttpSession session,String newPwd){
        Admin admin= (Admin) session.getAttribute("admin");
        if(admin==null)
            return "redirect:/Login";
        admin.setPassword(newPwd);
        adminDao.update(admin);
        return "success";
    }
    @RequestMapping(value = "CourseManage")
    public ModelAndView CourseManage(HttpServletRequest request,HttpSession session){
        Admin admin= (Admin) session.getAttribute("admin");
        if(admin==null)
            return new ModelAndView("redirect:/Login");
        ModelAndView modelAndView=new ModelAndView();
        String pn=request.getParameter("pn");
        String status=request.getParameter("status");
        int pageNum=1;
        if(pn!=null&&!"".equals(pn)){
            try{
                pageNum=Integer.parseInt(pn);
            }catch (Exception e){
                pageNum=1;
            }
        }
        List<Slide>slideList=slideDao.getListByStatus(status);
        if(slideList==null)
            slideList=new ArrayList<>();
        int totalPage;
        if(slideList.size()%baseDao.PAGELENGTH==0)
            totalPage=slideList.size()/baseDao.PAGELENGTH;
        else
            totalPage=slideList.size()/baseDao.PAGELENGTH+1;
        List<Slide>myList=slideDao.getPageListByStatus(pageNum, status);
        for(Slide slide:myList){
            List<uTag>userTagList=tagDao.getUserTag(slide);
            String userTag="";
            for(int i=0;i<userTagList.size();i++){
                if(i==0)
                    userTag+=userTagList.get(i).getUtag();
                else{
                    userTag+="、"+userTagList.get(i).getUtag();
                }
            }
            slide.setuTag(userTag);
            List<uTag>adminTagList=tagDao.getAdminTag(slide);
            String adminTag="";
            for(int i=0;i<adminTagList.size();i++){
                if(i==0)
                    adminTag+=adminTagList.get(i).getUtag();
                else{
                    adminTag+="、"+adminTagList.get(i).getUtag();
                }
            }
            slide.setaTag(adminTag);
        }
        if(status!=null)
            request.setAttribute("status",status);
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        modelAndView.setViewName("back/CourseManage");
        return modelAndView;
    }
    @RequestMapping(value = "filterCourse",method = RequestMethod.POST)
    @ResponseBody
    public String filterCourse(int status,Long sId,String opinion){
        try {
            Slide slide = slideDao.get(Slide.class, sId);
            if(status==0){
                slideDao.delete(slide);
                return "success";
            }else{
                List<uTag>uTagList=tagDao.getAllConstTag(slide);
                for(uTag uTag:uTagList){
                    if(status==5)
                        uTag.setStatus(1);
                    else if(status==4)
                        uTag.setStatus(0);
                    tagDao.update(uTag);
                }
            }
            slide.setOpinion(opinion);
            if(status==5){
                if(slide.getFileType().equals("error")){
                    return "FileTypeError";
                }
                boolean tFlag=false;
                if(slide.gettTag()==null||slide.gettTag().equals(""))
                    tFlag=true;
                boolean aFlag=false;
                if(slide.getaTag()==null||slide.getaTag().equals(""))
                    aFlag=true;
                if(aFlag&&tFlag){
                    return "TagEmpty";
                }
            }
            slide.setState(status);
            slideDao.update(slide);
            slideDao.addLog(slide,null);
            Account teacher=slide.getTeacher();
            //审核通过 积分+10
            if(status==5){
                teacher.setIntegral(teacher.getIntegral()+10);
                teacher.setCaseCount(teacher.getCaseCount()+1);
            }else{
                teacher.setCaseCount(teacher.getCaseCount()>0?teacher.getCaseCount()-1:0);
            }
            accountDao.update(teacher);
        }catch (Exception e){
            return "fail";
        }
        return "success";
    }

    @RequestMapping(value = "CourseManageEdit")
    public ModelAndView CourseManageEdit(HttpSession session){
        Admin admin= (Admin) session.getAttribute("admin");
        if(admin==null)
            return new ModelAndView("redirect:/Login");
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("back/CourseManage-edit");
        return modelAndView;
    }
}
