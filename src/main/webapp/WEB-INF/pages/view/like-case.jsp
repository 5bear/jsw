<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 23:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/viewHead.jsp">
  <jsp:param name="pageName" value="like-case"></jsp:param>
</jsp:include>
<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
  <p class="wrapper-title like-title">猜你喜欢</p>
  <a href="" class="float-right">换一批</a>
  <div class="case-list like-case-list">
    <c:forEach items="${likeList}" var="slide">
      <a href="<%=request.getContextPath()%>/Case?id=${slide.sId}"><div class="panel case-item">
        <div class="panel-heading">
          <div class="eye">
            <span class="love"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞"/>${slide.zanCount}</span>
            <span class="click"><img src="<%=request.getContextPath()%>/images/eye2.png" alt="查看"/>${slide.viewCount}</span>
          </div>
        </div>
        <div class="panel-body">
          <p class="title">${slide.title}</p>
          <p class="label">${slide.tTag.replace(","," ")}</p>
        </div>
        <div class="panel-footer">
          <img class="float-left teacher-head-sm" src="<%=request.getContextPath()%>/${slide.teacher.headPath}" alt="头像"/>
          <span>${slide.teacher.nickName}</span>
          <span class="float-right">上传日期：${slide.formatTimestamp}</span>
        </div>
      </div>
      </a>
    </c:forEach>
    <div class="clearboth"></div>
  </div>
</div>

<jsp:include page="../public/viewFooter.jsp"></jsp:include>

</body>
</html>
