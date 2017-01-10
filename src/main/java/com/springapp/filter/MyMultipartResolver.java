package com.springapp.filter;

import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by ZhanShaoxiong on 2015/7/21.
 */
public class MyMultipartResolver extends CommonsMultipartResolver {

    @Override
    public boolean isMultipart(HttpServletRequest request) {
        if(request.getRequestURI().contains("/Activity/fileUpload")) {
            return false;
        } else {
            return super.isMultipart(request);
        }
    }


}