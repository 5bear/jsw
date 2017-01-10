<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/21
  Time: 0:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
  <meta charset="UTF-8">
  <meta name=”viewport” content=”width=1000, user-scalable=yes, initial-scale=1.0”>
  <%
    String pageName=request.getParameter("pageName");
    if(pageName.equals("case")){
  %>
  <script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/jquery.easing.1.3.js"></script>
    <script src="<%=request.getContextPath()%>/script/mediaelement-and-player.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css" />
  <%
    }
    if(pageName.equals("case-index")){
  %>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />
  <%
    }
    if(pageName.equals("case-list")){
  %>
  <script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/jquery.easing.1.3.js"></script>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css" />
  <%
    }
    if(pageName.equals("comment")){
  %>
  <script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/jquery.easing.1.3.js"></script>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css" />
  <%
    }
    if(pageName.equals("index")){
  %>
  <script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/responsiveslides.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/jquery.slideBox.js"></script>
  <link href="<%=request.getContextPath()%>/css/jquery.slideBox.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/slide.css"/>
  <%
    }
    if(pageName.equals("like-case")){
  %>
  <script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/jquery.easing.1.3.js"></script>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css" />
  <%
    }
    if(pageName.equals("login")){
  %>
  <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/cropbox.css"/>
  <script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/script/jquery.form.js"></script>
  <script src="<%=request.getContextPath()%>/script/bootstrap.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/script/cropbox.js"></script>
  <%
    }
    if(pageName.equals("teacher")){
  %>
  <script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/jquery.easing.1.3.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/lib/jquery.raty.js"></script>
  <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/demo/css/application.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css" />

  <%
    }
    if (pageName.equals("teacher-list")){
  %>
  <script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/jquery.easing.1.3.js"></script>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css" />
  <%
    }
    if(pageName.equals("top-case")){
  %>
  <script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/jquery.easing.1.3.js"></script>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css" />
  <%
    }
    if(pageName.equals("user-index")){
  %>
  <script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/responsiveslides.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/bootstrap.min.js"></script>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/slide.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css"/>
  <%
    }
    if (pageName.equals("user-info")){
  %>
  <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/cropbox.css"/>
  <script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/script/bootstrap.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/script/cropbox.js"></script>
  <%
    }
  %>
  <title>全球汉语教师网</title>
</head>
