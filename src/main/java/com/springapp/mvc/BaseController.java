package com.springapp.mvc;


import com.springapp.classes.DateEditor;
import com.springapp.dao.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.SystemEnvironmentPropertySource;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Date;
import java.util.Set;

/**
 * Created by anc on 15/3/13.
 */
public class BaseController{
    @Autowired
    protected BaseDao baseDao;
    @Autowired
    protected AccountDao accountDao;
    @Autowired
    protected EditorDao editorDao;
    @Autowired
    protected TagDao tagDao;
    @Autowired
    protected SlideDao slideDao;
    @Autowired
    protected AdminDao adminDao;
    @InitBinder
    protected void initBinder(HttpServletRequest request,
                              ServletRequestDataBinder binder) throws Exception {
        //对于需要转换为Date类型的属性，使用DateEditor进行处理
        binder.registerCustomEditor(Date.class, new DateEditor());
    }

    //过滤出中文
    public static void main(String []args) throws IOException {
       System.out.print(System.currentTimeMillis());
    }
}
