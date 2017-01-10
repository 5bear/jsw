<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/21
  Time: 0:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="footer">
  <div class="wrapper">
    <%--<div class="footer-left">
      <div><label class="label-user" for="username">用户登录</label><input type="text" id="username" onkeypress="if(event.keyCode==13) {loginCheck();return false;}"/></div>
      <div><label class="label-user" for="password">密码输入</label><input type="password" id="password" onkeypress="if(event.keyCode==13) {loginCheck();return false;}"/></div>
      <p id="lerror" class="text-center alert-red"></p>
      <button class="btn footer-btn" name="loginBtn" onclick="loginCheck()">邮箱登录</button>
      <a href="<%=request.getContextPath()%>/Register" class="btn footer-btn">注册</a>
    </div>--%>
    <div class="footer-center">
      <p>主办方</p>
      <p>全球汉语教师网 （汉办）</p>
      <p class="footer-web">www.hanban.com</p>
    </div>
    <div class="footer-right text-left">
      <p>与我们联系</p>
      <ul class="contact-ul">
        <li><a href="#"><img src="<%=request.getContextPath()%>/images/contact1.png" alt=""/></a></li>
        <li><a href="#"><img src="<%=request.getContextPath()%>/images/contact2.png" alt=""/></a></li>
        <li><a href="#"><img src="<%=request.getContextPath()%>/images/contact3.png" alt=""/></a></li>
        <li><a href="#"><img src="<%=request.getContextPath()%>/images/contact4.png" alt=""/></a></li>
        <li><a href="#"><img src="<%=request.getContextPath()%>/images/contact5.png" alt=""/></a></li>
      </ul>
    </div>
    <div class="clearboth"></div>
    <div class="footer-bottom">
      <p>© Copyright 2016 华东师范大学 国际汉语教师研修基地版权所有</p>
    </div>
  </div>
</div>
<script type="text/javascript">
  function loginCheck(){
    var email=document.getElementById("username").value
    var password=document.getElementById("password").value
    var loginIp=location.hostname
    $.ajax({
      url:"<%=request.getContextPath()%>/loginCheck",
      type:"post",
      data:{email:email,password:password,loginIp:loginIp},
      success: function (data) {
        if(data=="login_success")
            location.href="<%=request.getContextPath()%>/UserIndex"
        else{
          $("#lerror").html(data)
        }
      }
    })
  }
</script>