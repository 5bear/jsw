<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 23:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<jsp:include page="../public/viewHead.jsp">
  <jsp:param name="pageName" value="login"></jsp:param>
</jsp:include>

<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
  <div id="page-wrapper">

    <div  class="row login-row">
      <div class="info-table login-table">
        <h1>登录</h1>
       <%-- <div>
          <span><img src="<%=request.getContextPath()%>/images/user.png" alt="用户名"/></span>
                            <span>
                                <label><input type="radio" name="identify" value="1" checked> 教师</label>
                                <label><input type="radio" name="identify" value="2"> 管理员</label>
                            </span>
        </div>--%>
        <div>
          <span><img src="<%=request.getContextPath()%>/images/user.png" alt="注册邮箱"/></span>
          <span><input type="text" class="table-input" placeholder="注册邮箱" id="uname"/></span>
        </div>
        <div>
          <span><img src="<%=request.getContextPath()%>/images/password.png" alt="密码"/></span>
          <span><input type="password" class="table-input" placeholder="密码" id="upwd"/></span>
        </div>
        <div class="login-btn-row text-center">
          <button class="login-btn" onclick="login()">登录</button>
        </div>
      </div>
    </div>
  </div><!-- /#page-wrapper -->

</div><!-- /#wrapper -->

<!-- JavaScript -->
<script type="text/javascript">

  document.onkeydown= function (event) {
    var e = event || window.event || arguments.callee.caller.arguments[0];
    if(e && e.keyCode==13) {//enter 键
      login()
    }
  }
  function login(){
    var account=$("#uname").val()
    var password=$("#upwd").val()
    $.ajax({
      url:"loginCheck",
      type:"post",
      data:{email:account,password:password},
      success: function (data) {
        if(data=="admin")
          location.href="<%=request.getContextPath()%>/EditorManagement";
        else if(data=="user") {
          location.href="<%=request.getContextPath()%>/CaseIndex";
        }else if(data=="editor"){
            location.href="<%=request.getContextPath()%>/CourseMaintain";
        } else
          alert(data)
      }
    })
  }
</script>
</body>
</html>
