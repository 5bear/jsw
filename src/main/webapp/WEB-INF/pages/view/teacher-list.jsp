<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 23:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String url=request.getContextPath()+"/TeacherList?";
  int totalPage= (Integer) request.getAttribute("totalPage");
  int currentPage= (Integer) request.getAttribute("currentPage");
%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/viewHead.jsp">
  <jsp:param name="pageName" value="teacher-list"></jsp:param>
</jsp:include>
<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
  <div class="case-list teacher-list">
    <c:forEach items="${list}" var="teacher">
      <a href="<%=request.getContextPath()%>/Teacher/${teacher.tId}"><div class="case-item">
        <div class="">
          <img src="<%=request.getContextPath()%>/${teacher.headPath}" class="case-item-head" alt="头像"/>
          <p>${teacher.nickName}</p>
          <p class="orange">${teacher.department}</p>
          <p class="section">案例数 ${teacher.caseCount}</p>
          <p class="section">分数 ${teacher.score}</p>
        </div>
      </div></a>
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