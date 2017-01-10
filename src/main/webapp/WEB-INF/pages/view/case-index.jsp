<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 23:40
  To change this template use File | Settings | File Templates.
--%>
<%
    String searchType= (String) session.getAttribute("searchType")==null?"":(String) session.getAttribute("searchType");
    String searchInput= (String) session.getAttribute("searchInput")==null?"":(String) session.getAttribute("searchInput");
    String url=request.getContextPath()+"/CaseIndex?st="+(searchType==null?"":searchType)+"&si="+(searchInput==null?"":searchInput)+"&";
    int totalPage= (Integer) request.getAttribute("totalPage");
    int currentPage= (Integer) request.getAttribute("currentPage");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/viewHead.jsp">
  <jsp:param name="pageName" value="case-index"></jsp:param>
</jsp:include>
<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper" id="label-section">
  <div class="case-index-right">
    <div class="left-top-top"></div>
    <div class="left-top">
      <div class="tab-tree">
        <p>案例分类</p>
        <!--<ul class="nav nav-tabs" role="tablist">-->
        <!--<li role="presentation" class="active"><a href="#sort" aria-controls="sort" role="tab" data-toggle="tab">案例分类<img src=<%=request.getContextPath()%>/images/tablist.png" alt="下拉"/></a></li>-->
        <!--<li role="presentation"><a href="#background" aria-controls="background" role="tab" data-toggle="tab">案例背景-->
        <!--<img src=<%=request.getContextPath()%>/images/tablist.png" alt="下拉"/></a></li>-->
        <!--</ul>-->

        <div class="tab-content">
          <!--<div role="tabpanel" class="tab-pane fade" id="background">-->
          <!--<div class="tree">-->
          <!--<ul id="background-case"></ul>-->
          <!--</div>-->
          <!--</div>-->
          <div role="tabpanel" class="tab-pane fade active in" id="sort">
            <div class="tree">
              <ul id="sort-case"></ul>
            </div>
          </div>
        </div>
      </div>

      <div id="progress1" class="progress-bar-panel">
        <div class="clear">
          <p class="float-left">热门点击</p>
            <img class="all-more float-right" src="<%=request.getContextPath()%>/images/more.png"  onclick="javascript:location.href='<%=request.getContextPath()%>/TopCase'" alt="更多">
        </div>
        <c:forEach items="${hosList}" var="slide">
          <div class="bars clear">
            <a href="<%=request.getContextPath()%>/Case?id=${slide.sId}"><span class="bars-title"> ${slide.title}</span></a>
            <div class="eye">
              <span class="love"><img src="<%=request.getContextPath()%>/images/good3.png" alt="点赞"/>${slide.zanCount}</span>
              <span class="click"><img src="<%=request.getContextPath()%>/images/eye3.png" alt="查看"/>${slide.viewCount}</span>
            </div>
            <p>. . . . . . . . . . . . . </p>
          </div>
        </c:forEach>
      </div>
    </div>

    <div class="tagList left-bottom clear">
        <div class="clear">
      <p class="float-left">猜您喜欢</p>
        <img class="all-more float-right" src="<%=request.getContextPath()%>/images/more.png"  onclick="javascript:location.href='<%=request.getContextPath()%>/LikeCase'" alt="更多">
            </div>
      <c:forEach items="${likeList}" var="slide">
        <a href="<%=request.getContextPath()%>/Case?id=${slide.sId}"><div class="panel case-item">
          <div class="panel-heading">
            <div class="eye">
              <span class="love"><img src="<%=request.getContextPath()%>/images/good3.png" alt="点赞"/>${slide.zanCount}</span>
              <span class="click"><img src="<%=request.getContextPath()%>/images/eye3.png" alt="查看"/>${slide.viewCount}</span>
            </div>
          </div>
          <div class="panel-body">
            <p class="title">${slide.title}</p>
            <p class="label">${slide.description}</p>
          </div>
          <div class="panel-footer">
            <img class="float-left teacher-head-sm" src="<%=request.getContextPath()%>/${slide.teacher.headPath}" alt="头像"/>
            <span>${slide.teacher.nickName}</span>
            <span class="float-right">${slide.formatTimestamp}</span>
          </div>
        </div>
        </a>
      </c:forEach>
    </div>
  </div>

  <div class="case-index-left">
    <div class="right-top-top"></div>
    <div class="right-top">
        <div class="case-search">
            <input type="text" class="case-search-input" list="tList" placeholder="请输入要搜索的关键词" id="searchinput" value="<%=searchInput%>" onkeypress="if(event.keyCode==13) {query();return false;}"/>
            <datalist id="tList">
                <c:forEach items="${uTagList}" var="tag">
                    <option value="${tag.utag}">${tag.utag}</option>
                </c:forEach>
            </datalist>
            <button class="btn btn-default" onclick="query()"><span class="glyphicon glyphicon-search"></span></button>
<%--
            <button class="btn btn-default" >搜索</button>
--%>
            <p>${result==1?"没有符合要求的内容":""}</p>
        </div>


        <%--<div class="case-search">
        <input type="text" class="case-search-input" list="tList" placeholder="请输入要搜索的关键词" id="searchinput" value="<%=searchInput%>" onkeypress="if(event.keyCode==13) {query();return false;}"/>
        <datalist id="tList">
          <c:forEach items="${uTagList}" var="tag">
            <option value="${tag.utag}">${tag.utag}</option>
          </c:forEach>
        </datalist>
        <button name="subSearch" onclick="query()"><img src="<%=request.getContextPath()%>/images/search1.png" alt=""/></button>
        <p>${result==1?"没有符合要求的内容":""}</p>
      </div>--%>
      <div class="panel search-panel">
        <div class="panel-heading">
          <h5 class="panel-title">
            <div class="panel-header" v-cloak>
              <div class="row">
                <div class="title sort-title" id="emptySort">候选分类:</div>
                <div class="items" v-for="sort in sorts">
                  <a class="btn btn-danger" data-field="category" onclick="deleteSort(this)"> <span class="js-cate-content"><span>{{ sort.title }}</span>-<span>{{ sort.sub }}</span></span> <span class="glyphicon glyphicon-remove"></span></a>
                </div>
                <div class="clearboth"></div>
              </div>
              <!--<div class="row">-->
              <!--<label class="title sort-title float-left" id="emptyBack">所有背景:</label>-->
              <!--<div class="items" v-for="background in backgrounds">-->
              <!--<a class="btn btn-danger" data-field="category" onclick="deleteBG(this)"> <span class="js-cate-content"><span>{{ background.title }}</span>-<span>{{ background.sub }}</span></span> <span class="glyphicon glyphicon-remove"></span></a>-->
              <!--</div>-->
              <!--<div class="clearboth"></div>-->
              <!--</div>-->
            </div>
          </h5>
        </div>
      </div>
      <div class="case-list case-index-list">
        <div class="course-section clear">
            <a class="link" href="<%=request.getContextPath()%>/CaseList?st=<%=searchType%>&si=<%=searchInput%>">
                <img class="all-more" src="<%=request.getContextPath()%>/images/more.png" alt="更多">
            </a>
            <c:forEach items="${list}" var="slide">
            <div class="case-item-lg">
              <div class="case-item-left">
                <a href="<%=request.getContextPath()%>/Case?id=${slide.sId}"><img src="<%=request.getContextPath()%>/${slide.picPath}" alt=""/></a>
              </div>
              <div class="case-item-mid">
                <a href="<%=request.getContextPath()%>/Case?id=${slide.sId}"><h5 class="title">${slide.title}</h5></a>
                <p>${slide.description}</p>
              </div>
              <div class="case-item-right text-center">
                <a href="<%=request.getContextPath()%>/Teacher/${slide.teacher.aId}"><img class="teacher-head-sm" src="<%=request.getContextPath()%>/${slide.teacher.headPath}" alt="头像"/></a>
                <a href="<%=request.getContextPath()%>/Teacher/${slide.teacher.aId}"><p>${slide.teacher.nickName}</p></a>
                <div class="eye">
                  <span class="love"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞"/>${slide.zanCount}</span>
                  <span class="click"><img src="<%=request.getContextPath()%>/images/eye2.png" alt="查看"/>${slide.viewCount}</span>
                </div>
                <p>上传日期：${slide.formatTimestamp}</p>
              </div>
            </div>
          </c:forEach>

            <jsp:include page="../public/page1.jsp">
                <jsp:param name="url" value="<%=url%>"></jsp:param>
                <jsp:param name="totalPage" value="<%=totalPage%>"></jsp:param>
                <jsp:param name="currentPage" value="<%=currentPage%>"></jsp:param>
            </jsp:include>
        </div>
      </div>
    </div>

  </div>
  <div class="clearboth"></div>
</div>

<jsp:include page="../public/viewFooter.jsp"></jsp:include>

<script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/script/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/script/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/script/vue.min.js"></script>
<script src="<%=request.getContextPath()%>/script/case-index.js"></script>
<script type="text/javascript">
var result = '<%=searchType%>';
    if(result){
result = result.split(';');
    var title, sub, index;
    var findTitle = $("#sort-case").find("label");

    if (result.length !== 0) {
        for (var k in result) {
            title = result[k].split('-')[0];
            sub = result[k].split('-')[1];
            vm.sorts.push( { title: title, sub: sub} )

            for (var i in findTitle) {
                if ($(findTitle[i]).text() == title) {
                    if (sub == "全部") {
                        $(findTitle[i]).siblings("input").attr("checked", true);
                    } else {
                        var findSub = $(findTitle[i]).siblings("ul").find("span");
                        for(var j in findSub) {
                            if ($(findSub[j]).text()==sub) {
                                $(findSub[j]).siblings("input").attr("checked", true);
                                break;
                            }
                        }
                    }
                    break;
                }
            }
        }
    }}
   
  function query(){
    var si=$("#searchinput").val()
    var data=vm.sorts.slice();
    var type="";
    $(data).each(function (index,obj) {
      if(index==0){
        type+=obj.title+"-"+obj.sub;
      }else{
        type+=";"+obj.title+"-"+obj.sub;
      }
    })
    location.href="<%=request.getContextPath()%>/CaseIndex?st="+type+"&si="+si;
    console.log(type)
  }
</script>
</body>
</html>
