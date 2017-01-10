<%@ page import="com.springapp.entity.Account" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 23:46
  To change this template use File | Settings | File Templates.
--%>
<%
  Account account= (Account) session.getAttribute("account");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="header">
    <div class="layer">
        <div class="wrapper">
            <div class="logo">
                <a href="<%=request.getContextPath()%>/Index"><img src="<%=request.getContextPath()%>/images/title.png" alt="全球汉语教师网"/></a>
            </div>
            <div class="login-status">
                <%
                    if(account==null){
                %>

                <a href="<%=request.getContextPath()%>/Login">登录</a>
                <a href="<%=request.getContextPath()%>/Register">注册</a>
                <%
                    }else{
                %>
                <div class="login-info">
                <div class="left">
                    <a href="<%=request.getContextPath()%>/UserIndex">
                        <img class="person-head " src="<%=request.getContextPath()+"/"+account.getHeadPath()%>" alt="头像"/>
                        <p><%=account.getNickName()%></p>
                    </a>
                </div>
                <div class="right">
                    <a href="<%=request.getContextPath()%>/Upload">上传案例</a>
                    <a href="<%=request.getContextPath()%>/userLogout">注销</a>
                </div>
                </div>
                <%--<a href=""></a>
                <a href="">上传案例</a>
                <a href="">注销</a>--%>
                <%
                    }
                %>
            </div>
            <div class="clearboth"></div>
        </div>
        <ul class="nav">
            <div class="wrapper">
                <li><a href="#">汉办直通车</a></li>
                <li><a href="#">教学信息</a></li>
                <li class="active"><a href="<%=request.getContextPath()%>/CaseIndex">教学资源</a></li>
                <li><a href="#">在线课堂</a></li>
                <li><a href="#">信息发布</a></li>
            </div>
        </ul>
    </div>
</div>
