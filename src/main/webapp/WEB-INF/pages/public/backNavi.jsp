<%@ page import="com.springapp.entity.Admin" %>
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
  Admin admin= (Admin) session.getAttribute("admin");
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
    <a class="navbar-brand" href="<%=request.getContextPath()%>/Index">全球汉语教师网</a>
  </div>

  <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse navbar-ex1-collapse">
    <ul class="nav navbar-nav side-nav">
<%--
      <li <%if(pageName.equals("TeacherManage")){%>class="active"<%}%>><a href="<%=request.getContextPath()%>/TeacherManage"><i class="fa fa-dashboard"></i> 教师管理</a></li>
--%>
      <li <%if(pageName.equals("EditorManagement")){%>class="active"<%}%>><a href="<%=request.getContextPath()%>/EditorManagement"><i class="fa fa-dashboard"></i> 编辑管理</a></li>
      <li <%if(pageName.equals("CourseManage")){%>class="active"<%}%>><a href="<%=request.getContextPath()%>/CourseManage"><i class="fa fa-dashboard"></i> 案例管理</a></li>
      <li <%if(pageName.equals("UserManage")){%>class="active"<%}%>><a href="<%=request.getContextPath()%>/UserManage"><i class="fa fa-dashboard"></i> 用户管理</a></li>
      <li <%if(pageName.equals("TagManage")){%>class="active"<%}%>><a href="<%=request.getContextPath()%>/TagManage"><i class="fa fa-dashboard"></i> tag管理</a></li>
      <li <%if(pageName.equals("PasswordManage")){%>class="active"<%}%>><a href="<%=request.getContextPath()%>/PasswordManage"><i class="fa fa-dashboard"></i> 修改密码</a></li>
    </ul>

    <ul class="nav navbar-nav navbar-right navbar-user">
      <li><a href="#"><%=admin==null?"":admin.getAccount()%></a></li>
      <li><a href="<%=request.getContextPath()%>/adminLogout">退出</a></li>
    </ul>
  </div><!-- /.navbar-collapse -->
</nav>