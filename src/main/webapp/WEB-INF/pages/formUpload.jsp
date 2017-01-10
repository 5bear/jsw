<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/16
  Time: 12:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script type="text/javascript" src="script/jquery.min.js"></script>
  <script type="text/javascript" src="script/jquery.form.js"></script>
  <title>表单上传测试</title>
</head>
<body>
<%
  String img= (String) session.getAttribute("img");
%>
<h1>表单上传</h1>
<form action="/upload/formUpload" method="post" enctype="multipart/form-data" target="myFrame" name="fileForm">
  <input type="file" name="file" id="file">
  <input type="submit" value="提交">
</form>
<img src="<%=request.getContextPath()%>/Web/Upload/images/<%=img%>" alt="图片" id="imgArea">
</body>
<script>
  function submitBtn() {
    var form = $("form[name=fileForm]");
    var options  = {
      url:'/upload/fileUpload',
      type:'post',
      success:function(data)
      {
        console.log(data)
        $("#imgArea").attr("src","<%=request.getContextPath()%>/Web/Upload/images/"+data);
      }
    };
    form.ajaxSubmit(options);
    //$("#fileForm").submit();
  }
</script>
</html>
