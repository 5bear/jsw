package com.springapp.mvc;

import com.springapp.classes.Base64Image;
import com.springapp.entity.*;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.text.html.HTML;
import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by 六花 on 2016/7/25.
 * 教师登录，修改密码
 */
@Controller
@RequestMapping(value = "")
public class EditorController extends BaseController{

    @RequestMapping(value = "teacherLogout")
    public String teacherLogout(HttpSession session){
        session.removeAttribute("editor");
        return "view/login";
    }
      /* @RequestMapping(value = "teacherLoginCheck",method = RequestMethod.POST)
       @ResponseBody
       public String teacherLoginCheck(String no,String password,HttpSession session){
        List<Account>teacherList=accountDao.getTeacher();
        for (Account teacher:teacherList){
            if(no.equals(teacher.getNo())) {
                if (password.equals(teacher.getPassword())) {
                    teacher.setLastLogin(new Timestamp(new Date().getTime()));
                    teacherDao.update(teacherList);
                    session.setAttribute("teacher",teacher);
                    return "teacher_login_success";
                }
                else
                    return "密码错误";
            }
        }
        return "工号不存在";
    }*/

    @RequestMapping(value = "TeacherInfo")
    public ModelAndView TeacherInfo(HttpSession session){
        ModelAndView modelAndView=new ModelAndView("teacher/TeacherMaintain");
        Editor editor= (Editor) session.getAttribute("editor");
        if(editor==null)
            return new ModelAndView("redirect:Login");
        modelAndView.addObject("editor",editor);
        return modelAndView;
    }
    /*教师编辑个人信息*/
    @RequestMapping(value = "TeacherInfo",method = RequestMethod.POST)
    public String TeacherInfo(Long tId,String nickName,String no,String remark,HttpSession session){
        Editor editor=editorDao.get(Editor.class,tId);
        if(editor==null)
            return "redirect:/Login";
        else{
            editor.setUsername(nickName);
            editor.setNo(no);
            editor.setRemark(remark);
            editorDao.update(editor);
        }
        session.setAttribute("editor",editor);
        return "redirect:/TeacherInfo";
    }

    /**
     * 案例管理 编辑
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "CourseMaintain")
    public ModelAndView CourseManage(HttpServletRequest request,HttpSession session){
        ModelAndView modelAndView=new ModelAndView();
        Editor editor= (Editor) session.getAttribute("editor");
        if(editor==null)
            return new ModelAndView("redirect:Login");
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
        modelAndView.setViewName("teacher/CourseMaintain");
        return modelAndView;
    }
    //修改编辑密码
    @RequestMapping(value = "PasswordMaintain")
    public ModelAndView PasswordMaintain(HttpSession session){
        Editor editor= (Editor) session.getAttribute("editor");
        if(editor==null)
            return new ModelAndView("redirect:/Login");
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("teacher/PasswordMaintain");
        return modelAndView;
    }
    /*修改密码*/
    @RequestMapping(value = "editorPasswordManage",method = RequestMethod.POST)
    @ResponseBody
    public String editorPasswordManage(HttpSession session,String newPwd){
        Editor editor= (Editor) session.getAttribute("editor");
        if(editor==null)
            return "redirect:/Login";
        editor.setPassword(newPwd);
        editorDao.update(editor);
        return "success";
    }
    @RequestMapping(value = "deleteEditor",method = RequestMethod.POST)
    @ResponseBody
    public String deleteEditor(Long id){
        Editor editor= editorDao.get(Editor.class,id);
        if(editor==null)
            return "fail";
        editorDao.delete(editor);
        return "success";
    }
    @RequestMapping(value = "resetPWD",method = RequestMethod.POST)
    @ResponseBody
    public String resetPWD(Long id){
        try {
            Editor editor = editorDao.get(Editor.class, id);
            if(editor==null)
                return "fail";
            editor.setPassword("123");
            editorDao.update(editor);
            return "success";
        }catch (Exception e){
            return "fail";
        }
    }

}
