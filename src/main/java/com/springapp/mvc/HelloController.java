package com.springapp.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/")
public class HelloController {
	@RequestMapping(value = "/hello",method = RequestMethod.GET)
	public String printWelcome(ModelMap model) {
		model.addAttribute("message", "异步上传测试");
		return "view/case";
	}
	@RequestMapping(method = RequestMethod.GET)
	public String home() {
		return "view/login";
	}
	@RequestMapping(value = "/formUpload",method = RequestMethod.GET)
	public String formUpload() {
		return "formUpload";
	}
	@RequestMapping(value = "/show",method = RequestMethod.GET)
	public ModelAndView show(HttpServletRequest request) {
		ModelAndView modelAndView=new ModelAndView();
		String path=request.getParameter("path");
		modelAndView.addObject("path",path);
		modelAndView.setViewName("/show");
		return modelAndView;
	}
}