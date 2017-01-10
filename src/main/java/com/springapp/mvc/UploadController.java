package com.springapp.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * Created by ZhanShaoxiong on 2016/3/30.
 * spring MultipartFile 方法上传文件
 */
@Controller
@RequestMapping(value = "/upload")
public class UploadController{
    /**
     * 文件异步上传
     * */
    @RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
    @ResponseBody
    public String fileUpload(HttpSession session,@RequestParam("file") MultipartFile file) throws IOException {
        String realPath = session.getServletContext().getRealPath("/WEB-INF/pages/heads/");
        File mainFile=new File(realPath);
        //文件保存目录URL
        String newFileName="";
        if(!mainFile.exists())
            mainFile.mkdirs();
        // 获取文件类型
        //System.out.println(file.getContentType());
        // 获取文件大小
        //System.out.println(file.getSize());
        // 获取文件名称
        //System.out.println(file.getOriginalFilename());

        // 判断文件是否存在
        if (!file.isEmpty() && file.getContentType().equals("image/jpeg")) {
            newFileName=new Date().getTime() + "."+"jpg";
            String path = realPath + "/" + newFileName;
            File localFile = new File(path);
            try {
                file.transferTo(localFile);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            return "fail";
        }
        return "heads/"+newFileName;
    }
    /**
     * 文件同步上传
     * */
    @RequestMapping(value = "/formUpload", method = RequestMethod.POST)
    public String formUpload(HttpSession session,@RequestParam("file") MultipartFile file) throws IOException {
        String realPath = session.getServletContext().getRealPath("/WEB-INF/pages/Web/Upload/images/");
        File mainFile=new File(realPath);
        //文件保存目录URL
        String newFileName="";
        if(!mainFile.exists())
            mainFile.mkdirs();
        // 获取文件类型
        //System.out.println(file.getContentType());
        // 获取文件大小
        //System.out.println(file.getSize());
        // 获取文件名称
        //System.out.println(file.getOriginalFilename());

        // 判断文件是否存在
        if (!file.isEmpty() && file.getContentType().equals("image/jpeg")) {
            newFileName=new Date().getTime() + "."+"jpg";
            String path = realPath + "/" + newFileName;
            File localFile = new File(path);
            try {
                file.transferTo(localFile);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        session.setAttribute("img",newFileName);
        return "redirect:/formUpload";
    }
}
