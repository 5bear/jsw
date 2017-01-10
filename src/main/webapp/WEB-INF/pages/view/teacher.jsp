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
  Long id= (Long) request.getAttribute("tid");
  String url=request.getContextPath()+"/Teacher/"+id+"?";
  int totalPage= (Integer) request.getAttribute("totalPage");
  int currentPage= (Integer) request.getAttribute("currentPage");
%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/viewHead.jsp">
  <jsp:param name="pageName" value="teacher"></jsp:param>
</jsp:include>
<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
  <div class="teacher">
    <div class="teacher-left">
      <div class="teacher-left-detail">
        <div class="row teacher-info">
          <img class="teacher-head" src="<%=request.getContextPath()%>/${teacher.headPath}" alt="头像"/>
          <p class="md-name">${teacher.nickName}</p>
          <p class="sm-name">${teacher.no}</p>
        </div>
        <div class="row">
          <div class="teacher-detail">
            <p><img class="teacher-detail-icon" src="<%=request.getContextPath()%>/images/followers.png" alt="案例数"/>案例数</p>
            <p>${teacher.caseCount}</p>
          </div>
          <div class="teacher-detail">
            <p><img class="teacher-detail-icon" src="<%=request.getContextPath()%>/images/like.png" alt="评分"/>评分</p>
            <p>${teacher.score}</p>
          </div>
          <div class="star-row">
            <div id="star" class="star-teacher"></div>
          </div>
        </div>
      </div>
    </div>
    <div class="teacher-right">

     <c:forEach items="${list}" var="slide">
       <a href="<%=request.getContextPath()%>/Case?id=${slide.sId}"><div class="panel case-item">
         <div class="panel-heading">
           <div class="eye">
             <span class="love"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞"/>${slide.zanCount}</span>
             <span class="click"><img src="<%=request.getContextPath()%>/images/eye2.png" alt="查看"/>${slide.viewCount}</span>
           </div>
         </div>
         <div class="panel-body">
           <p class="title">${slide.title}</p>
           <p class="label">${slide.tTag.replace(","," ")==""?"&nbsp":slide.tTag.replace(","," ")}</p>
         </div>
         <div class="panel-footer">
           <img class="float-left teacher-head-sm" src="<%=request.getContextPath()%>/${teacher.headPath}" alt="头像"/>
           <span>${teacher.nickName}</span>
           <span class="float-right">上传日期：${slide.formatTimestamp}</span>
         </div>
       </div>
         </a>
     </c:forEach>
      <div class="clearboth"></div>
         <jsp:include page="../public/page.jsp">
           <jsp:param name="url" value="<%=url%>"></jsp:param>
           <jsp:param name="totalPage" value="<%=totalPage%>"></jsp:param>
           <jsp:param name="currentPage" value="<%=currentPage%>"></jsp:param>
         </jsp:include>
    </div>
    <div class="clearboth"></div>
  </div>
</div>

<jsp:include page="../public/viewFooter.jsp"></jsp:include>
<script>
  $('#star').raty({ half: true });
  $('#star').raty({ score: ${score==null?0:score.score} });
  $("#star").click(function(){
    var score=$('.star-teacher input').val();
    $.ajax({
      url:"<%=request.getContextPath()%>/evaluate",
      type:"post",
      data:{tId:'${teacher.aId}',score:score},
      success: function (data) {
        if(data=="success"){
          location.reload(true)
        }
      }
    })
  })
</script>
</body>
</html>
