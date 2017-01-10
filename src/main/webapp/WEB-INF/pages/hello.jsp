<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script type="text/javascript" src="script/jquery.min.js"></script>
	<script type="text/javascript" src="script/jquery.form.js"></script>
	<title>异步上传测试</title>
</head>
<body>
	<h1>${message}</h1>
	<form action="/upload/fileUpload" method="post" enctype="multipart/form-data" target="myFrame" name="fileForm">
		<input type="file" name="file" id="file">
		<input type="text" value="bg1" name="fileName">
	</form>
	<button onclick="submitBtn()">提交</button>
	<img src="" alt="图片" id="imgArea">
	<iframe name="myFrame" style="display: none"></iframe>
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