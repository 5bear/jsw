<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 22:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/backHead.jsp"></jsp:include>

<body>

<div id="wrapper">

  <!-- Sidebar -->
  <jsp:include page="../public/backNavi.jsp">
    <jsp:param name="pageName" value="UserManage"></jsp:param>
  </jsp:include>
  <div id="page-wrapper">

    <div class="row">
      <div class="col-lg-6 col-lg-offset-3 time-row">
        <a href="javascript:history.back();" class="operation"><< 返回</a>
      </div>
      <div class="col-lg-6 col-lg-offset-3">
        <form action="<%=request.getContextPath()%>/UserManageEditForm" method="post" modelAttribute="account" accept-charset="utf-8" name="accountForm">
        <table class="table vertical-table">
          <tbody>
          <input style="display: none" name="aId" value="${account.aId}">
          <tr>
            <td>用户昵称</td>
            <td><input type="text" class="table-input" name="nickName" value="${account.nickName}"/></td>
          </tr>
          <tr>
            <td>注册时间</td>
            <td><input type="text" class="table-input" readonly="readonly" value="${account.rDatetime}"/></td>
          </tr>
          <tr>
            <td>性别</td>
            <td><select name="sex" class="table-input">
              <option value="0" ${account.sex==0?"selected":""}>男</option>
              <option value="1" ${account.sex==1?"selected":""}>女</option>
            </select></td>
          </tr>
          <tr>
            <td>邮箱</td>
            <td><input type="text" id="email" class="table-input" name="email" value="${account.email}"/></td>
          </tr>
          <tr>
            <td>活跃度</td>
            <td><input type="text" class="table-input" readonly="readonly" value="99"/></td>
          </tr>
          <tr>
            <td>密码重置</td>
            <td><input type="password" id="pwd" class="table-input" name="password" value="${account.password}"/></td>
          </tr>
          </tbody>
          <p id="error" class="text-center alert-red"></p>
        </table>
          </form>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-4 col-lg-offset-5 col-md-4 col-md-offset-5 col-sm-4 col-sm-offset-4">
        <button class="btn btn-default" onclick="checkForm()">修改</button>
        <button class="btn btn-default" onclick="javascript:location.reload(true)">取消</button>
      </div>
    </div>

    <div class="modal fade" id="success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">修改提示</h4>
          </div>
          <div class="modal-body text-center">
            <p>修改成功</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


  </div><!-- /#page-wrapper -->

</div><!-- /#wrapper -->

<!-- JavaScript -->
<jsp:include page="../public/backFooter.jsp"></jsp:include>
<script>
  function checkForm(){
    var accountForm=document.getElementsByName("accountForm");
    var email=document.getElementById("email");
    var password=document.getElementById("pwd")
    var errorstr="";
    if(password.value==""){
      password.focus()
      errorstr += "密码不能为空;"
    }
    if(!emailCheck()) {
      email.focus()
      errorstr += "电子邮件地址必须包括 ( @ 和 . );"
      $("#error").html(errorstr)
    }else{
      $.ajax({
        url:"checkEmail",
        type:"post",
        data:{email:email.value,id:${account.aId}},
        success: function (data) {
          if(data=="exist"){
            errorstr+= "邮箱已被注册;"
            $("#error").html(errorstr)
          }else{
            accountForm[0].submit()
          }
        }
      })
    }
  }
  function emailCheck () {
    var emailStr=document.getElementById("email").value;
    var emailPat=/^(.+)@(.+)$/;
    var matchArray=emailStr.match(emailPat);
    if (matchArray==null) {
      return false
    }
    return true
  }
</script>
</body>
</html>
