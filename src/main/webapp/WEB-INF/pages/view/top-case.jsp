<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 23:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/viewHead.jsp">
  <jsp:param name="pageName" value="top-case"></jsp:param>
</jsp:include>
<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
  <div class="case-list top-case-list top-case-list-first">
    <div class="panel">
      <div class="panel-heading">
        <div class="top-icon">
          <img src="<%=request.getContextPath()%>/images/star.png" alt="星星"/>
        </div>
        <p>热门点击</p>
      </div>
      <div class="panel-body">
        <c:forEach items="${hotView}" var="slide" varStatus="count">
          <div class="top-case-list-row">
            <span class="order">${count.count}、</span><a href="<%=request.getContextPath()%>/Case?id=${slide.sId}">${slide.title}</a>
            <span class="float-right">${slide.viewCount}</span>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
  <div class="case-list top-case-list">
    <div class="panel">
      <div class="panel-heading">
        <div class="top-icon">
          <img src="<%=request.getContextPath()%>/images/star.png" alt="星星"/>
        </div>
        <p>热门搜索</p>
      </div>
      <div class="panel-body">
        <c:forEach items="${hotSearch}" var="slide" varStatus="count">
          <div class="top-case-list-row">
              <span class="order">${count.count}、</span><a href="<%=request.getContextPath()%>/Case?id=${slide.sId}">${slide.title}</a>
            <span class="float-right">${slide.viewCount}</span>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
  <div class="case-list top-case-list">
    <div class="panel">
      <div class="panel-heading">
        <div class="top-icon">
          <img src="<%=request.getContextPath()%>/images/star.png" alt="星星"/>
        </div>
        <p>热门点赞</p>
      </div>
      <div class="panel-body">
        <c:forEach items="${hotZan}" var="slide" varStatus="count">
          <div class="top-case-list-row">
              <span class="order">${count.count}、</span><a href="<%=request.getContextPath()%>/Case?id=${slide.sId}">${slide.title}</a>
            <span class="float-right">${slide.zanCount}</span>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
  <div class="clearboth"></div>
</div>

<jsp:include page="../public/viewFooter.jsp"></jsp:include>


</body>
</html>