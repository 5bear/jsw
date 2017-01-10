package com.springapp.mvc;


import com.springapp.classes.DicUtils;
import com.springapp.classes.SplitWord;
import com.springapp.entity.*;
import org.ansj.library.UserDefineLibrary;
import org.ansj.splitWord.analysis.ToAnalysis;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created by 11369 on 2016/7/12.
 * 前台页面
 */
@Controller
@RequestMapping(value = "")
public class ViewController extends BaseController {
    @RequestMapping(value = "Login")
    public ModelAndView Login(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("view/login");
        return modelAndView;
    }
    @RequestMapping(value = "Index")
    public ModelAndView Index(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("view/index");
        return modelAndView;
    }
    @RequestMapping(value = "Preview/{sid}")
    public ModelAndView Index(@PathVariable("sid") Long sid){
        ModelAndView modelAndView=new ModelAndView();
        try {
            Slide slide = slideDao.get(Slide.class, sid);
            if(slide!=null)
                modelAndView.addObject("slide",slide);
        }catch (Exception e){
            return new ModelAndView("view/case-index");
        }
        modelAndView.setViewName("view/Preview");
        return modelAndView;
    }
    @RequestMapping(value = "Case")
    public ModelAndView Case(Long id,HttpSession session){
        ModelAndView modelAndView=new ModelAndView();
        if(id==null||"".equals(id)){
            return new ModelAndView("redirect:/CaseList");
        }
        Slide slide=slideDao.get(Slide.class,id);
        if(slide==null)
            return new ModelAndView("redirect:/CaseList");
        slide.setViewCount(slide.getViewCount()+1);
        slideDao.update(slide);
        Account account= (Account) session.getAttribute("account");
        if(account!=null){
            List<Slide>likeList=slideDao.RandomLikeList(account);
            /*for(Slide slide1:likeList){
                if(slide.getsId()==slide1.getsId())
                    likeList.remove(slide1);
            }*/
            modelAndView.addObject("likeList",likeList);
        }
        if(account!=null&&slide!=null){
            UserView userView=new UserView();
            userView.setAccount(account);
            userView.setSlide(slide);
            userView.setViewTime(new Timestamp(System.currentTimeMillis()));
            accountDao.save(userView);
        }
        List<Account>accountList=baseDao.findAll("select u.account from UserZan u where slide=?", Account.class,slide);
        List<uTag>constTags=tagDao.getConstTag(slide);
        List<uTag>userTags=tagDao.getUserTag(slide);
        modelAndView.addObject("account",account);
        modelAndView.addObject("constTags",constTags);
        modelAndView.addObject("userTags",userTags);
        modelAndView.addObject("accountList",accountList);
        modelAndView.addObject("slide",slide);
        modelAndView.setViewName("view/case");
        return modelAndView;
    }
    @RequestMapping(value = "CaseIndex")
    public ModelAndView CaseIndex(HttpSession session,HttpServletRequest request){
        ModelAndView modelAndView=new ModelAndView();
        Account account= (Account) session.getAttribute("account");
        if(account!=null){
/*
            List<Slide>slideList=baseDao.findAll("select distinct t.slide from uTag t,UserInterest u where u.uTag=t and u.account=? and state=1",Slide.class,account);
*/
            modelAndView.addObject("likeList",slideDao.RandomLikeList(account));
        }
        String pn=request.getParameter("pn");
        int pageNum=1;
        if(pn!=null&&!"".equals(pn)){
            try{
                pageNum=Integer.parseInt(pn);
            }catch (Exception e){
                pageNum=1;
            }
        }
        String searchType=request.getParameter("st");
        String []conditions=null;
        if(searchType!=null&&!"".equals(searchType)){
            session.setAttribute("searchType",searchType);
            conditions =searchType.split(";");
        }else
            session.removeAttribute("searchType");
        String searchInput=request.getParameter("si");
        if(searchInput!=null&&!"".equals(searchInput)) {
            session.setAttribute("searchInput", searchInput);
        }else{
            session.removeAttribute("searchInput");
        }
        String[] keywords=null;
        if(searchInput!=null&&!"".equals(searchInput)) {
            session.setAttribute("searchInput",searchInput);
            searchInput=searchInput.replaceAll("[^(\\u4e00-\\u9fa5)]", "");
            try {
                List<String> dic = DicUtils.getDicList();
                for (int i = 0; i < dic.size(); i++) {
                    UserDefineLibrary.insertWord(dic.get(i), DicUtils.USER_DEFINE, 1000);
                }
                keywords = ToAnalysis.parse(searchInput).toStringWithOutNature().split(",");
            }catch (Exception e) {
                keywords =new String[]{""};
            }
          /* keywords= SplitWord.SplitWords(searchInput);*/
        }
        String qKey="";
        if(keywords!=null){
            for (int i = 0; i < keywords.length; i++) {
                if (i == 0)
                    qKey += keywords[i];
                else
                    qKey += "|" + keywords[i];
            }
        }
        System.out.println(qKey);
        /*

        String[] keywords=null;
        if(searchInput!=null&&!"".equals(searchInput)) {
            session.setAttribute("searchInput",searchInput);
            searchInput=searchInput.replaceAll("[^(\\u4e00-\\u9fa5)]", "");
            try {
                List<String> dic = DicUtils.getDicList();
                for (int i = 0; i < dic.size(); i++) {
                    UserDefineLibrary.insertWord(dic.get(i), DicUtils.USER_DEFINE, 1000);
                }
                keywords = ToAnalysis.parse(searchInput).toStringWithOutNature().split(",");
            }catch (Exception e) {
                keywords =new String[]{""};
            }
        }
        List<uTag>tagList1=tagDao.getListByTypeByPage(keywords,conditions,0,0);
        if(tagList1==null)
            tagList1=new ArrayList<uTag>();
        Map<Slide,List<uTag>>slideMap=new HashMap<Slide, List<uTag>>();
        for(uTag uTag:tagList1){
            List<uTag>uTagList=slideMap.get(uTag.getSlide());
            if(uTagList==null){
                uTagList=new ArrayList<uTag>();
                uTagList.add(uTag);
                slideMap.put(uTag.getSlide(),uTagList);
            }else{
                uTagList.add(uTag);
                slideMap.put(uTag.getSlide(), uTagList);
            }
        }*/
        List<SearchKeyword>searchKeywords=QueryList(qKey,conditions);//搜索结果集
        if(searchInput!=null&&conditions!=null)
            session.setAttribute("searchKeywords", searchKeywords);
        else
            session.removeAttribute("searchKeywords");
        Integer result=0;
        //为空，首先根据title匹配
        if(searchKeywords==null||searchKeywords.size()==0) {
            searchKeywords = slideDao.QueryTitleList(qKey,conditions);//根据title匹配
            if(searchKeywords==null){
                result=1;//表示搜索无结果
                searchKeywords=slideDao.getAllSlide(conditions);//搜索无结果，返回全部案例
                if(searchInput==null||"".equals(searchInput))
                    result = 2;
            }
        }
        for (SearchKeyword searchKeyword : searchKeywords) {
            List<SlidePic> slidePics = baseDao.findAll("from SlidePic where slide=?", SlidePic.class, searchKeyword.getSlide());
            if (slidePics != null && slidePics.get(0) != null) {
                searchKeyword.getSlide().setPicPath(slidePics.get(0).getPicPath());
            } else {
                searchKeyword.getSlide().setPicPath("images/case-img6.png");
            }
        }
        int totalPage;
        int length = 14;
        if(searchKeywords.size()%length==0)
            totalPage=searchKeywords.size()/length;
        else
            totalPage=searchKeywords.size()/length+1;
        List<Slide>myList = new ArrayList<>();
        if(totalPage-1<0)
            totalPage=1;
        if(pageNum<totalPage){
            for(int i=(pageNum-1)*length;i<(pageNum-1)*length+length;i++){
                myList.add(searchKeywords.get(i).getSlide());
            }
        }else{
            for(int i=(totalPage-1)*length;i<searchKeywords.size();i++){
                myList.add(searchKeywords.get(i).getSlide());
            }
        }
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        modelAndView.addObject("result",result);
        /*modelAndView.addObject("list",subList);*/
        List<Slide>hotViewList=slideDao.hotViewList();
        if(hotViewList!=null)
            modelAndView.addObject("hosList",hotViewList);
        List<uTag>uTagList=tagDao.getPassedList();
        modelAndView.addObject("uTagList",uTagList);
        modelAndView.setViewName("view/case-index");
        return modelAndView;
    }
    private static int adjustFactor=1000;

    /**
     * 返回搜索结果
     * @param qKey
     * @param conditions
     * @return
     */
    public List<SearchKeyword>QueryList(String qKey,String []conditions){
        //关键词为空直接返回空
        if(qKey!=null&&!"".equals(qKey)) {
            //首先在相似表里面找到相似度大于0.2的标签,Map<标签，相似度>
            Map<String, Double> termMap = tagDao.getCoTagList(qKey);
            //没有相似标签直接返回空
            if (termMap == null || termMap.size() <= 0)
                return null;
            //记录返回的案例
            List<ResultEntity> resultList = new ArrayList<>();
            for (String uTag : termMap.keySet()) {
                List<uTag> uTagList = tagDao.getByTag(uTag,conditions);
                for (uTag tag : uTagList) {
                    ResultEntity resultEntity = new ResultEntity();
                    resultEntity.setSlide(tag.getSlide());
                    resultEntity.setTerm(tag);
                    resultEntity.setTag_weight(tag.getUweight());
                    Double score = tag.getUweight() + termMap.get(uTag) * adjustFactor;
                    resultEntity.setScore(score);
                    resultList.add(resultEntity);
                }
            }
            //记录案例与，对应搜索关键词以及得分情况
            List<SearchKeyword> searchKeywordList = new ArrayList<>();
            //记录得分
            Map<Long, Double> FinalMap1 = new HashMap<>();
            //记录搜索关键词
            Map<Long, List<uTag>> FinalMap2 = new HashMap<>();
            for (ResultEntity resultEntity : resultList) {
                Double score = FinalMap1.get(resultEntity.getSlide().getsId());//获取得分
                List<uTag> tagList = FinalMap2.get(resultEntity.getSlide().getsId());//获取tagList
                if (score == null) {
                    FinalMap1.put(resultEntity.getSlide().getsId(), resultEntity.getScore());
                } else {
                    FinalMap1.put(resultEntity.getSlide().getsId(), resultEntity.getScore() + score);
                }
                if (tagList == null) {
                    tagList = new ArrayList<>();
                    tagList.add(resultEntity.getTerm());
                    FinalMap2.put(resultEntity.getSlide().getsId(), tagList);
                } else {
                    tagList.add(resultEntity.getTerm());
                    FinalMap2.put(resultEntity.getSlide().getsId(), tagList);
                }
            }
            for (Long sid : FinalMap1.keySet()) {
                Slide slide=slideDao.get(Slide.class,sid);
                SearchKeyword searchKeyword = new SearchKeyword();
                if(slide.getState()!=5)
                    continue;
                searchKeyword.setSlide(slide);
                searchKeyword.setuTagList(FinalMap2.get(sid));
                searchKeyword.setWeight(FinalMap1.get(sid));
                searchKeywordList.add(searchKeyword);
            }
        /*按权重倒序排序*/
            Collections.sort(searchKeywordList, new Comparator<SearchKeyword>() {
                @Override
                public int compare(SearchKeyword o1, SearchKeyword o2) {
                    if (o1.getWeight() < o2.getWeight())
                        return 1;
                    else if (o1.getWeight() == o2.getWeight())
                        return 0;
                    else
                        return -1;
                }
            });
            return searchKeywordList;
        }
        return null;
    }
    @RequestMapping(value = "CaseList")
    public ModelAndView CaseList(HttpServletRequest request){
        ModelAndView modelAndView=new ModelAndView();
        String pn=request.getParameter("pn");
        int pageNum=1;
        if(pn!=null&&!"".equals(pn)){
            try{
                pageNum=Integer.parseInt(pn);
            }catch (Exception e){
                pageNum=1;
            }
        }
        String searchType=request.getParameter("st");
        String []conditions=null;
        if(searchType!=null&&!"".equals(searchType)){
            conditions =searchType.split(";");
        }
        String searchInput=request.getParameter("si");
        String[] keywords=null;
        if(searchInput!=null&&!"".equals(searchInput)) {
            searchInput=searchInput.replaceAll("[^(\\u4e00-\\u9fa5)]", "");
            try {
                List<String> dic = DicUtils.getDicList();
                for (int i = 0; i < dic.size(); i++) {
                    UserDefineLibrary.insertWord(dic.get(i), DicUtils.USER_DEFINE, 1000);
                }
                keywords = ToAnalysis.parse(searchInput).toStringWithOutNature().split(",");
            }catch (Exception e) {
                keywords =new String[]{""};
            }
          /*
           简易分词
         keywords= SplitWord.SplitWords(searchInput);*/
        }
        String qKey="";
        if(keywords!=null){
            for (int i = 0; i < keywords.length; i++) {
                if (i == 0)
                    qKey += keywords[i];
                else
                    qKey += "|" + keywords[i];
            }
        }
        System.out.println(qKey);
        List<SearchKeyword>slideList=QueryList(qKey, conditions);
        if(slideList==null||slideList.size()==0) {
            slideList = slideDao.QueryTitleList(qKey,conditions);//根据title匹配
            if(slideList==null){
                slideList=slideDao.getAllSlide(conditions);//搜索无结果，返回全部案例
            }
        }
        int totalPage;
        if(slideList.size()%baseDao.PAGELENGTH==0)
            totalPage=slideList.size()/baseDao.PAGELENGTH;
        else
            totalPage=slideList.size()/baseDao.PAGELENGTH+1;
        List<Slide>myList = new ArrayList<>();
        if(totalPage-1<0)
            totalPage=1;
        if(pageNum<totalPage){
            for(int i=(pageNum-1)*baseDao.PAGELENGTH;i<(pageNum-1)*baseDao.PAGELENGTH+9;i++){
                myList.add(slideList.get(i).getSlide());
            }
        }else{
            for(int i=(totalPage-1)*baseDao.PAGELENGTH;i<slideList.size();i++){
                myList.add(slideList.get(i).getSlide());
            }
        }
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        modelAndView.setViewName("view/case-list");
        return modelAndView;
    }
    @RequestMapping(value = "UserZan")
    public ModelAndView UserZan(HttpServletRequest request,HttpSession session){
        Account account=(Account)session.getAttribute("account");
        if(account==null)
            return new ModelAndView("redirect:/Index");
        ModelAndView modelAndView=new ModelAndView();
        String pn=request.getParameter("pn");
        int pageNum=1;
        if(pn!=null&&!"".equals(pn)){
            try{
                pageNum=Integer.parseInt(pn);
            }catch (Exception e){
                pageNum=1;
            }
        }
        List<UserZan>userZanList=accountDao.getUserZanList(account);
        int totalPage;
        if(userZanList.size()%baseDao.PAGELENGTH==0)
            totalPage=userZanList.size()/baseDao.PAGELENGTH;
        else
            totalPage=userZanList.size()/baseDao.PAGELENGTH+1;
        List<UserZan>myList=accountDao.getUserZanList(account,pageNum);
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        modelAndView.setViewName("view/UserZan");
        return modelAndView;
    }
    @RequestMapping(value = "UserCollect")
    public ModelAndView UserCollect(HttpServletRequest request,HttpSession session){
        Account account=(Account)session.getAttribute("account");
        if(account==null)
            return new ModelAndView("redirect:/Index");
        ModelAndView modelAndView=new ModelAndView();
        String pn=request.getParameter("pn");
        int pageNum=1;
        if(pn!=null&&!"".equals(pn)){
            try{
                pageNum=Integer.parseInt(pn);
            }catch (Exception e){
                pageNum=1;
            }
        }
        List<UserCollect>userCollectList=accountDao.getUserCollectList(account);
        int totalPage;
        if(userCollectList.size()%baseDao.PAGELENGTH==0)
            totalPage=userCollectList.size()/baseDao.PAGELENGTH;
        else
            totalPage=userCollectList.size()/baseDao.PAGELENGTH+1;
        List<UserCollect>myList=accountDao.getUserCollectList(account, pageNum);
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        modelAndView.setViewName("view/UserCollect");
        return modelAndView;
    }
    @RequestMapping(value = "UserDown")
    public ModelAndView UserDown(HttpServletRequest request,HttpSession session){
        Account account=(Account)session.getAttribute("account");
        if(account==null)
            return new ModelAndView("redirect:/Index");
        ModelAndView modelAndView=new ModelAndView();
        String pn=request.getParameter("pn");
        int pageNum=1;
        if(pn!=null&&!"".equals(pn)){
            try{
                pageNum=Integer.parseInt(pn);
            }catch (Exception e){
                pageNum=1;
            }
        }
        List<UserDown>userCollectList=accountDao.getUserDownList(account);
        int totalPage;
        if(userCollectList.size()%baseDao.PAGELENGTH==0)
            totalPage=userCollectList.size()/baseDao.PAGELENGTH;
        else
            totalPage=userCollectList.size()/baseDao.PAGELENGTH+1;
        List<UserDown>myList=accountDao.getUserDownList(account, pageNum);
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        modelAndView.setViewName("view/UserDown");
        return modelAndView;
    }
    @RequestMapping(value = "TeacherView")
    public ModelAndView TeacherView(HttpSession session,HttpServletRequest request){
        Account teacher= (Account) session.getAttribute("account");
        if(teacher==null)
            return new ModelAndView("redirect:/Login");
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("view/teacher");
        modelAndView.addObject("teacher",teacher);
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
        List<Slide> slideList=slideDao.getList(teacher);
        int totalPage;
        if(slideList.size()%baseDao.PAGELENGTH==0)
            totalPage=slideList.size()/baseDao.PAGELENGTH;
        else
            totalPage=slideList.size()/baseDao.PAGELENGTH+1;
        List<Slide>myList=slideDao.getPageList(teacher, pageNum);
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        return modelAndView;
    }
    @RequestMapping(value = "Teacher/{id}")
    public ModelAndView Teacher(HttpServletRequest request,HttpSession session,@PathVariable("id") Long id){
        if(id==null||"".equals(id))
            return new ModelAndView("redirect:/TeacherList");
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("view/teacher");
        Account teacher=accountDao.get(Account.class,id);
        if(teacher==null)
            return new ModelAndView("redirect:/TeacherList");
        request.setAttribute("tid",id);
        modelAndView.addObject("teacher",teacher);
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
        List<Slide> slideList=slideDao.getList(teacher,5);
        if(teacher.getCaseCount()!=slideList.size()) {
            teacher.setCaseCount(slideList.size());
            accountDao.update(teacher);
        }
        int totalPage;
        if(slideList.size()%4==0)
            totalPage=slideList.size()/4;
        else
            totalPage=slideList.size()/4+1;
        List<Slide>myList=slideDao.getPageListForTeacher(teacher, pageNum, 5);
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        Account account = (Account) session.getAttribute("account");
        if(account!=null){
            UserScore userScore=accountDao.find("from UserScore where account="+account.getaId()+" and teacher ="+teacher.getaId(),UserScore.class);
            modelAndView.addObject("score",userScore);
        }
        return modelAndView;
    }
    @RequestMapping(value = "TeacherList")
    public ModelAndView TeacherList(HttpServletRequest request){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("view/teacher-list");
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
        List<Account> teacherList=accountDao.getTeacher();
        int totalPage;
        if(teacherList.size()%baseDao.PAGELENGTH==0)
            totalPage=teacherList.size()/baseDao.PAGELENGTH;
        else
            totalPage=teacherList.size()/baseDao.PAGELENGTH+1;
        List<Account>myList=accountDao.getTeacherPageList(pageNum);
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        return modelAndView;
    }
    @RequestMapping(value = "TopCase")
    public ModelAndView TopCase(){
        ModelAndView modelAndView=new ModelAndView();
        List<Slide>hotViewList=slideDao.AllhotViewList();
        List<Slide>hotZanList=slideDao.AllhotZanList();
        List<Slide>hotSearchList=slideDao.AllhotSearchList();
        modelAndView.addObject("hotView",hotViewList);
        modelAndView.addObject("hotZan",hotZanList);
        modelAndView.addObject("hotSearch",hotSearchList);
        modelAndView.setViewName("view/top-case");
        return modelAndView;
    }

    @RequestMapping(value = "RegisterTeacher")
    public ModelAndView RegisterTeacher(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("view/register-teacher");
        return modelAndView;
    }

    @RequestMapping(value = "TeacherIndex")
    public ModelAndView TeacherIndex(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("view/teacher-info");
        return modelAndView;
    }

    @RequestMapping(value = "MySlide")
    public ModelAndView MySlide(HttpServletRequest request,HttpSession session,String si,String status,String pn){
        ModelAndView modelAndView=new ModelAndView();
        Account account=(Account)session.getAttribute("account");
        if(account==null)
            return new ModelAndView("view/login");
        Integer state;
        try {
          state =Integer.parseInt(status);
        }catch (Exception e){
            state=0;
        }
        int pageNum=1;
        if(pn!=null&&!"".equals(pn)){
            try{
                pageNum=Integer.parseInt(pn);
            }catch (Exception e){
                pageNum=1;
            }
        }
        List<Slide>slideList=slideDao.getList(account,state,si);
        if(slideList==null)
            slideList=new ArrayList<>();
        int totalPage;
        if(slideList.size()%baseDao.PAGELENGTH==0)
            totalPage=slideList.size()/baseDao.PAGELENGTH;
        else
            totalPage=slideList.size()/baseDao.PAGELENGTH+1;
        List<Slide>myList=slideDao.getPageListForTeacher(account,pageNum, state,si);
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
            request.setAttribute("status",state);
        if(si!=null)
            request.setAttribute("si",si);
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);
        modelAndView.addObject("list", myList);
        modelAndView.setViewName("view/teacher-upload");
        return modelAndView;
    }
    @RequestMapping(value = "Upload")
    public ModelAndView Upload(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("view/upload");
        return modelAndView;
    }
    @RequestMapping(value = "UploadPreview")
    public ModelAndView UploadPreview(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("view/upload-preview");
        return modelAndView;
    }
}
