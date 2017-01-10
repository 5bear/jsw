<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/8/14
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String url=request.getContextPath()+"/UserCollect?";
  int totalPage= (Integer) request.getAttribute("totalPage");
  int currentPage= (Integer) request.getAttribute("currentPage");
%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/viewHead.jsp">
  <jsp:param name="pageName" value="case-list"></jsp:param>
</jsp:include>
<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
  <div class="case-list">
    <p class="wrapper-title like-title">我的收藏</p>
    <c:forEach items="${list}" var="usercollect">
      <a href="<%=request.getContextPath()%>/Case?id=${usercollect.slide.sId}"><div class="panel case-item">
        <div class="panel-heading">
          <div class="eye">
            <span class="love"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞"/>${usercollect.slide.zanCount}</span>
            <span class="click"><img src="<%=request.getContextPath()%>/images/eye2.png" alt="查看"/>${usercollect.slide.viewCount}</span>
          </div>
        </div>
        <div class="panel-body">
          <p class="title">${usercollect.slide.title}</p>
          <p class="label">${usercollect.slide.tTag.replace(","," ")==""?"&nbsp":usercollect.slide.tTag.replace(","," ")}</p>
        </div>
        <div class="panel-footer">
          <img class="float-left teacher-head-sm" src="<%=request.getContextPath()%>/${usercollect.slide.teacher.headPath}" alt="头像"/>
          <span>${usercollect.slide.teacher.nickName}</span>
          <span class="float-right">上传日期：${usercollect.slide.formatTimestamp}</span>
        </div>
      </div>
      </a>
    </c:forEach>
    <div class="clearboth"></div>
  </div>

  <jsp:include page="../public/page.jsp">
    <jsp:param name="url" value="<%=url%>"></jsp:param>
    <jsp:param name="totalPage" value="<%=totalPage%>"></jsp:param>
    <jsp:param name="currentPage" value="<%=currentPage%>"></jsp:param>
  </jsp:include>

</div>

<jsp:include page="../public/viewFooter.jsp"></jsp:include>

</body>
</html>
