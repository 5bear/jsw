<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/10/15
  Time: 17:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="<%=request.getContextPath()%>/script/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/script/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/script/tags.js"></script>
    <script src="<%=request.getContextPath()%>/script/jquery-barIndicator.js"></script>
    <script src="<%=request.getContextPath()%>/script/jquery.easing.1.3.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/tag.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/site.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/front.css" />
    <title>在线预览</title>
</head>
<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
    <div class="preview-header">
        <h2 class="case-info-title">
            ${slide.title}
        </h2>
        <p class="upload-time text-right">
            ${slide.formatTimestamp}
        </p>
    </div>
    <iframe class="preview-frame" src = "<%=request.getContextPath()%>/${slide.filePath}" width='900' height='636' allowfullscreen webkitallowfullscreen></iframe>
</div>
<jsp:include page="../public/viewFooter.jsp"></jsp:include>
</body>
</html>
