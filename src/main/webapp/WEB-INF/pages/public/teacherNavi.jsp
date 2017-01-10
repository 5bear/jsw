<%@ page import="com.springapp.entity.Account" %>
<%@ page import="com.springapp.entity.Editor" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 21:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String pageName=request.getParameter("pageName");
  Editor editor= (Editor) session.getAttribute("editor");
%>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="<%=request.getContextPath()%>/Index"><img src="<%=request.getContextPath()%>/images/title.png" alt="全球汉语教师网"/></a>
  </div>

  <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse navbar-ex1-collapse">
    <ul class="nav navbar-nav side-nav">
      <li <%if(pageName.equals("TeacherMaintain")){%> class="active"<%}%>><a href="<%=request.getContextPath()%>/TeacherInfo"><i class="fa fa-dashboard"></i> 个人信息维护</a></li>
      <li <%if(pageName.equals("CourseMaintain")){%> class="active"<%}%>><a href="<%=request.getContextPath()%>/CourseMaintain"><i class="fa fa-dashboard"></i> 案例管理</a></li>
      <!--<li><a href="CommentMaintain.html"><i class="fa fa-dashboard"></i> 评论回复</a></li>-->
      <li <%if(pageName.equals("PasswordMaintain")){%> class="active"<%}%>><a href="<%=request.getContextPath()%>/PasswordMaintain"><i class="fa fa-dashboard"></i> 修改密码</a></li>
    </ul>

    <ul class="nav navbar-nav navbar-right navbar-user">
      <li><a href="javascript:void(0)"><%=editor==null?"":editor.getUsername()%></a></li>
      <li><a href="<%=request.getContextPath()%>/teacherLogout">注销</a></li>
    </ul>
  </div><!-- /.navbar-collapse -->
</nav>
