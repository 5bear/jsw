package com.springapp.mvc;

import com.springapp.classes.FileUtil;
import com.springapp.entity.*;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created by 11369 on 2016/7/22.
 * 案例
 */
@Controller
@RequestMapping(value = "")
public class SlideController extends BaseController{
    @RequestMapping(value = "CourseEdit")
    public ModelAndView CourseEdit(Long id){
        ModelAndView modelAndView=new ModelAndView();
        Slide slide=slideDao.get(Slide.class,id);
        List<SlidePic>slidePics=baseDao.findAll("from SlidePic where slide=?",SlidePic.class,slide);
        modelAndView.addObject("slidePics",slidePics);
        modelAndView.addObject("slide",slide);
        modelAndView.setViewName("teacher/CourseEdit");
        return modelAndView;
    }
    public void uploadFile(Slide slide,MultipartFile file, String realPath) throws Exception {
        if(slide.getFilePath()!=null&&!slide.getFilePath().equals("")){
            String path="/WEB-INF/pages/"+slide.getFilePath();
            if(FileUtil.delFile(path))
                System.out.println("删除一个文件");
        }
        String contextType=file.getContentType();
        if(contextType.contains("pdf"))
            slide.setFileType("pdf");
        else if(contextType.contains("video"))
            slide.setFileType("video");
        else if(contextType.contains("image"))
            slide.setFileType("image");
        else
            slide.setFileType("error");
        String fileName = FileUtil.uploadFile(realPath, file);
        String originName = file.getOriginalFilename();
        slide.setFileName(originName.substring(0, originName.indexOf(".")));
        slide.setFilePath("slides/slides/" + fileName);
        /*if(!contextType.contains("pdf")&&!contextType.contains("video")&&!contextType.contains("image")){
            slide.setFileName("失败的上传文件");
            slide.setFilePath("slides/slides/head.png");
        }else {
            if(contextType.contains("pdf"))
                slide.setFileType("pdf");
            else if(contextType.contains("video"))
                slide.setFileType("video");
            else
                slide.setFileType("image");
            String fileName = FileUtil.uploadFile(realPath, file);
            String originName = file.getOriginalFilename();
            slide.setFileName(originName.substring(0, originName.indexOf(".")));
            slide.setFilePath("slides/slides/" + fileName);
        }*/
    }
    public void uploadPic(Slide slide,MultipartFile multipartFile,String realPath ){
        List<SlidePic>slidePics=slideDao.findAll("from SlidePic where slide=?",SlidePic.class,slide);
        String path;
        for(SlidePic tmp:slidePics){
            path = "/WEB-INF/pages/"+tmp.getPicPath();
            if(FileUtil.delFile(path))
                System.out.println("删除一个文件");
        }
        SlidePic slidePic=new SlidePic();
        String fileName = FileUtil.uploadFic(realPath, multipartFile);
        slidePic.setSlide(slide);
        slidePic.setPicPath("slides/previewPics/"+fileName);
        baseDao.save(slidePic);
    }
    public void saveTag(String t,Slide slide){
        uTag uTag=new uTag();
        uTag.setStatus(0);
        uTag.setUserCount(1);
        uTag.setSlide(slide);
        uTag.setRole(1);//教师
        uTag.setUtag(t);
        uTag.setUweight((long) 70);
        baseDao.save(uTag);
    }

    /**
     * 管理员修正案例
     * @param file
     * @param sid
     * @param request
     * @return
     */
    @RequestMapping(value = "reUpload",method = RequestMethod.POST)
    public String reUpload(@RequestParam(value = "file") MultipartFile file,Long sid,String redirectUrl,HttpServletRequest request,HttpSession session) throws Exception {
        Slide slide=slideDao.get(Slide.class,sid);
        if(slide==null){
            return "redirect:"+redirectUrl;
        }else{
            String realPath = session.getServletContext().getRealPath("/WEB-INF/pages/slides/slides");
            uploadFile(slide,file,realPath);
            slideDao.update(slide);
            return "redirect:"+redirectUrl;
        }
    }

    @RequestMapping(value = "CourseEdit",method = RequestMethod.POST)
    public String CourseEdit(Long sId,
                             String title,
                             String type,
                             String secondtype,
                             String description,
                             String tTag,
                             MultipartFile file,
                             @RequestParam(value = "previewPic")MultipartFile []previewPic,
                             HttpSession session,
                             HttpServletRequest request) throws Exception {
        Slide slide=slideDao.get(Slide.class,sId);
        slide.setTitle(title);
        slide.setType(type);
        slide.setSecondtype(secondtype);
        tTag=slide.gettTag().replaceAll("[^(\\u4e00-\\u9fa5)]", ",");
        slide.settTag(tTag);
        slide.setDescription(description);
        slide.setUploadDatetime(new Timestamp(System.currentTimeMillis()));
        if(!file.isEmpty()) {
            String realPath = session.getServletContext().getRealPath("/WEB-INF/pages/slides/slides");
            uploadFile(slide,file,realPath);
        }
        slideDao.update(slide);
        slideDao.addLog(slide,1);
        if(!previewPic[0].isEmpty()) {
            List<SlidePic>slidePics=baseDao.findAll("from SlidePic where slide=?",SlidePic.class,slide);
            for(SlidePic slidePic:slidePics){
                File file1=new File(request.getContextPath()+"/"+slidePic.getPicPath());
                if(file1.delete())
                    System.out.print("删除成功");
                baseDao.delete(slidePic);
            }
            String realPath = session.getServletContext().getRealPath("/WEB-INF/pages/slides/previewPics");
            for(MultipartFile multipartFile:previewPic) {
                uploadPic(slide,multipartFile,realPath);
            }
        }
        List<uTag>uTagList=tagDao.getTeacherTag(slide);
        for(uTag t:uTagList){
            tagDao.delete(t);
        }
        String[]tags=tTag.split(",");
        for(String t:tags){
            if(t.length()<2)
                continue;
            saveTag(t,slide);
/*
            DicUtils.OutToTxt(request.getServletContext().getRealPath("/"),t);
*/
        }
        /*String []titleTags= ToAnalysis.parse(slide.getTitle().replaceAll("[^(\\u4e00-\\u9fa5)]", "")).toStringWithOutNature().split(",");
        Set<String> mySet= StopWordFileUtil.StopWorldSet();
        for(String t:titleTags){
            if(!mySet.contains(t)) {
                if(t.length()<2)
                    continue;
                uTag uTag = new uTag();
                uTag.setStatus(1);
                uTag.setSlide(slide);
                uTag.setRole(3);//隐式标签
                uTag.setUtag(t);
                uTag.setUweight((long) 30);
                baseDao.save(uTag);
            }
        }*/
        return "redirect:/MySlide";
    }
    @RequestMapping(value = "CourseAdd")
    public ModelAndView CourseAdd(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("teacher/CourseMaintain-edit");
        return modelAndView;
    }
    @RequestMapping(value = "CourseAdd",method = RequestMethod.POST)
    public String CourseAdd(HttpServletRequest request,Integer flag,Slide slide,MultipartFile file,@RequestParam(value = "previewPic")MultipartFile []previewPic,HttpSession session) throws Exception {
        Account teacher= (Account) session.getAttribute("account");
        if(teacher==null)
            return "redirect:/Login";
        slide.setUploadDatetime(new Timestamp(System.currentTimeMillis()));
        slide.setTeacher(teacher);
        slide.setState(flag);//未审核
        //分标签
        String tag=slide.gettTag().replaceAll("[^(\\u4e00-\\u9fa5)]", ",");
        slide.settTag(tag);
        if(file!=null&&!file.isEmpty()) {
            String realPath = session.getServletContext().getRealPath("/WEB-INF/pages/slides/slides");
            uploadFile(slide,file,realPath);
        }
        //提交成功积分+1
        if(slide.getState()==2)
            teacher.setIntegral(teacher.getIntegral()+2);
        accountDao.update(teacher);
        baseDao.save(slide);
        slideDao.addLog(slide,null);
        /*teacher.setCaseCount(teacher.getCaseCount()+1);
        baseDao.update(teacher);*/
        if(previewPic!=null&&!previewPic[0].isEmpty()) {
            String realPath = session.getServletContext().getRealPath("/WEB-INF/pages/slides/previewPics");
            for(MultipartFile multipartFile:previewPic) {
                uploadPic(slide,multipartFile,realPath);
            }
        }else{
            SlidePic slidePic=new SlidePic();
            slidePic.setSlide(slide);
            slidePic.setPicPath("images/heads.png");//默认预览图
            baseDao.save(slidePic);
        }
        String[]tags=tag.split(",");
        for(String t:tags){
            if(t.length()<2)
                continue;
           saveTag(t,slide);
        }
        /*String []titleTags= ToAnalysis.parse(slide.getTitle().replaceAll("[^(\\u4e00-\\u9fa5)]", "")).toStringWithOutNature().split(",");
        Set<String> mySet= StopWordFileUtil.StopWorldSet();
        for(String t:titleTags){
            if(!mySet.contains(t)) {
                if(t.length()<2)
                    continue;
                uTag uTag = new uTag();
                uTag.setStatus(1);
                uTag.setSlide(slide);
                uTag.setRole(3);//隐式标签
                uTag.setUtag(t);
                uTag.setUweight((long) 30);
                baseDao.save(uTag);
            }
        }*/
        return "redirect:/MySlide";
    }
    @RequestMapping(value = "deleteSlide",method = RequestMethod.POST)
    @ResponseBody
    public String deleteSlide(Long sid){
        Slide slide=slideDao.get(Slide.class,sid);
        if(slide==null)
            return "fail";
        slideDao.deleteSlide(slide);
        return "success";
    }

    @RequestMapping(value = "EditCourse/{id}",method = RequestMethod.GET)
    public ModelAndView EditCourse(@PathVariable("id") Long id) {
        ModelAndView modelAndView = new ModelAndView();
        Slide slide = slideDao.get(Slide.class, id);
        if (slide == null) {
            modelAndView.setViewName("view/login");
        } else {
            Integer status = slide.getState();
            //未提交/驳回，进入编辑|否则进去查看
            if (status == 1 || status == 6) {
                List<SlidePic> slidePics = baseDao.findAll("from SlidePic where slide=?", SlidePic.class, slide);
                modelAndView.addObject("slidePics", slidePics);
                modelAndView.addObject("slide", slide);
                modelAndView.setViewName("view/EditCourse");
            } else {
                List<SlidePic> slidePics = baseDao.findAll("from SlidePic where slide=?", SlidePic.class, slide);
                List<uTag> constTags = tagDao.getConstTag(slide);
                List<uTag> userTags = tagDao.getUserTag(slide);
                List<Account>accountList=baseDao.findAll("select u.account from UserZan u where slide=?", Account.class,slide);
                modelAndView.addObject("accountList",accountList);
                modelAndView.addObject("constTags", constTags);
                modelAndView.addObject("userTags", userTags);
                modelAndView.addObject("slidePics", slidePics);
                modelAndView.addObject("slide", slide);
                modelAndView.setViewName("view/case");
            }
        }
        return modelAndView;
    }

    //获得案例操作日志
    @RequestMapping(value = "getLogs", method = RequestMethod.GET)
    @ResponseBody
    public String getLogs(Long sid){
        List<OperationLog> operationLogList = slideDao.getLogs(sid);
        return JSONArray.fromObject(operationLogList).toString();
    }
}
