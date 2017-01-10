<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 23:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/backHead.jsp"></jsp:include>

<body>

<div id="wrapper">

  <!-- Sidebar -->
  <jsp:include page="../public/teacherNavi.jsp">
    <jsp:param name="pageName" value="PasswordMaintain"></jsp:param>
  </jsp:include>

  <div id="page-wrapper">

    <div class="row password-row">
      <div class="col-lg-6 col-lg-offset-3">
        <table class="table vertical-table">
          <tbody>
          <tr>
            <td>新密码</td>
            <td><input type="text" class="table-input" id="pwd"/></td>
          </tr>
          <tr>
            <td>请确认新密码</td>
            <td><input type="text" class="table-input" id="repwd"/></td>
          </tr>
          </tbody>
        </table>
        <p class="red-alert text-center" hidden="hidden" id="error">两次密码不正确！请重新输入。</p>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-4 col-lg-offset-5 col-md-4 col-md-offset-5 col-sm-4 col-sm-offset-4">
        <button class="btn btn-default" onclick="changePwd()">修改</button>
        <button class="btn btn-default">取消</button>
      </div>
    </div>


  </div><!-- /#page-wrapper -->

</div><!-- /#wrapper -->

<!-- JavaScript -->
<jsp:include page="../public/backFooter.jsp"></jsp:include>
<script>
  function changePwd(){
    var pwd=$("#pwd").val()
    var repwd=$("#repwd").val()
    if(pwd==""||repwd==""){
      $("#error").html("密码不能为空")
      $("#error").hidden="";
      return false
    }
    $.ajax({
      url:"<%=request.getContextPath()%>/editorPasswordManage",
      type:"post",
      data:{newPwd:pwd},
      success: function (data) {
        if(data=="success")
        location.reload(true)
      }
    })
  }
</script>
</body>
</html>
