<%@ page import="com.springapp.entity.Account" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 23:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  Account account= (Account) session.getAttribute("account");
  if(account==null)
    response.sendRedirect(request.getContextPath()+"/Index");
%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/viewHead.jsp">
  <jsp:param name="pageName" value="user-index"></jsp:param>
</jsp:include>
<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
  <div class="content">
      <h1 class="person-title">个人中心</h1>
    <div class="person-info">
      <img class="person-head " src="<%=request.getContextPath()%>/${account.headPath}" alt="头像"/>
      <div>
        <p class="teacher-name">${account.nickName}</p>
        <div class="teacher-tool">
          <!--<a href="register-teacher.html"><span class="glyphicon glyphicon-user"></span>(申请教师)</a>-->
         <%-- <a href="<%=request.getContextPath()%>/RegisterTeacher"><img src="<%=request.getContextPath()%>/images/Teacher_male.png">(申请教师)</a>
          <a href="<%=request.getContextPath()%>/RegisterTeacher"><img src="<%=request.getContextPath()%>/images/Teacher_female.png">(申请教师)</a>
          <a href="javascript:;" class="js-teacher-entrance">(教师入口)</a>
          <span class="teacher-option">
                            <a href="<%=request.getContextPath()%>/TeacherIndex">个人信息维护</a>
                            <a href="<%=request.getContextPath()%>/Upload">上传案例</a>
                            <a href="<%=request.getContextPath()%>/MySlide">我的案例</a>
                        </span>
          <a href="javascript:;">后台审核中</a>
          <a href="javascript:;">申请教师失败(失败原因: XXXXXXXXXXX),点击重新申请</a>--%>
          <p class="score"><span class="glyphicon glyphicon-gift"></span>积分: ${account.integral}</p>
          <p class="grade"><span class="glyphicon glyphicon-star"></span>等级: 初级</p>
        </div>
      </div>
      <p>上次登录时间: ${account.lastLogin}</p>
      <a href="<%=request.getContextPath()%>/UserInfo">点击编辑信息</a>
      <a href="#" data-toggle="modal" data-target="#changePassword">修改密码</a>
      <a href="<%=request.getContextPath()%>/MySlide">我的案例</a>
      <div class="clearboth"></div>
    </div>
    <div class="modal fade btn-modal" id="changePassword" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
          </div>
          <div class="modal-body text-center">
            <div>
              <label>密码</label>
              <span><input type="password" class="form-control" placeholder="请输入密码" id="oldPwd"/></span>
            </div>
            <div>
              <label>确认密码</label>
              <span><input type="password" class="form-control" placeholder="请再次输入密码" id="reoldPwd"/></span>
            </div>
            <p class="text-center alert-red" id="reerror"></p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changePwd()">确定</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="person">
      <div class="my-div">
        <a href="<%=request.getContextPath()%>/UserCollect"><h4>我的收藏</h4></a>
        <div class="case-list">
          <c:forEach items="${userCollectList}" var="UserCollect" >
            <a href="<%=request.getContextPath()%>/Case?id=${UserCollect.slide.sId}"><div class="panel case-item">
              <div class="panel-heading">
                <div class="eye">
                  <span class="love"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞"/>${UserCollect.slide.zanCount}</span>
                  <span class="click"><img src="<%=request.getContextPath()%>/images/eye2.png" alt="查看"/>${UserCollect.slide.viewCount}</span>
                </div>
              </div>
              <div class="panel-body">
                <p class="title">${UserCollect.slide.title}</p>
                <p class="label">${UserCollect.slide.tTag.replace(","," ")==""?"&nbsp":UserCollect.slide.tTag.replace(","," ")}</p>
              </div>
              <div class="panel-footer">
                <img class="float-left teacher-head-sm" src="<%=request.getContextPath()%>/${UserCollect.slide.teacher.headPath}" alt="头像"/>
                <span>${UserCollect.slide.teacher.nickName}</span>
                <span class="float-right">上传日期：${UserCollect.slide.formatTimestamp}</span>
              </div>
            </div>
            </a>
         </c:forEach>
          <div class="clearboth"></div>
        </div>
      </div>
      <div class="my-div">
        <a href="<%=request.getContextPath()%>/UserZan"><h4>我的点赞</h4></a>
        <div class="case-list">
          <c:forEach items="${userZanList}" var="UserZan" >
            <a href="<%=request.getContextPath()%>/Case?id=${UserZan.slide.sId}"><div class="panel case-item">
              <div class="panel-heading">
                <div class="eye">
                  <span class="love"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞"/>${UserZan.slide.zanCount}</span>
                  <span class="click"><img src="<%=request.getContextPath()%>/images/eye2.png" alt="查看"/>${UserZan.slide.viewCount}</span>
                </div>
              </div>
              <div class="panel-body">
                <p class="title">${UserZan.slide.title}</p>
                <p class="label">${UserZan.slide.teacherTag}</p>
              </div>
              <div class="panel-footer">
                <img class="float-left teacher-head-sm" src="<%=request.getContextPath()%>/${UserZan.slide.teacher.headPath}" alt="头像"/>
                <span>${UserZan.slide.teacher.nickName}</span>
                <span class="float-right">上传日期：${UserZan.slide.formatTimestamp}</span>
              </div>
            </div>
            </a>
          </c:forEach>
          <div class="clearboth"></div>
        </div>
      </div>
      <div class="my-div">
        <a href="<%=request.getContextPath()%>/UserDown"><h4>我的下载</h4></a>
        <div class="case-list">
          <c:forEach items="${userDownList}" var="UserDown" >
            <a href="<%=request.getContextPath()%>/Case?id=${UserDown.slide.sId}"><div class="panel case-item">
              <div class="panel-heading">
                <div class="eye">
                  <span class="love"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞"/>${UserDown.slide.zanCount}</span>
                  <span class="click"><img src="<%=request.getContextPath()%>/images/eye2.png" alt="查看"/>${UserDown.slide.viewCount}</span>
                </div>
              </div>
              <div class="panel-body">
                <p class="title">${UserDown.slide.title}</p>
                <p class="label">${UserDown.slide.teacherTag}</p>
              </div>
              <div class="panel-footer">
                <img class="float-left teacher-head-sm" src="<%=request.getContextPath()%>/${UserDown.slide.teacher.headPath}" alt="头像"/>
                <span>${UserDown.slide.teacher.nickName}</span>
                <span class="float-right">上传日期：${UserDown.slide.formatTimestamp}</span>
              </div>
            </div>
            </a>
          </c:forEach>
          <div class="clearboth"></div>
        </div>
      </div>
    </div>
    <%--<div class="recommend">
      <a href="case-list.html"><h4 class="float-left">精彩推荐</h4></a>
      <a href="case.html"><div class="panel case-item">
        <div class="panel-heading">
          <div class="eye">
            <span class="love"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞"/>10</span>
            <span class="click"><img src="<%=request.getContextPath()%>/images/eye2.png" alt="查看"/>200</span>
          </div>
        </div>
        <div class="panel-body">
          <p class="title">《鼎氏汉语》第23课</p>
          <p class="label">标签1 标签2 标签3</p>
        </div>
        <div class="panel-footer">
          <img class="float-left teacher-head-sm" src="<%=request.getContextPath()%>/images/head3.png" alt="头像"/>
          <span>鲍钰</span>
          <span class="float-right">上传日期：2016/2/12</span>
        </div>
      </div>
      </a>
      <a href="case.html"><div class="panel case-item">
        <div class="panel-heading">
          <div class="eye">
            <span class="love"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞"/>10</span>
            <span class="click"><img src="<%=request.getContextPath()%>/images/eye2.png" alt="查看"/>200</span>
          </div>
        </div>
        <div class="panel-body">
          <p class="title">《鼎氏汉语》第23课</p>
          <p class="label">标签1 标签2 标签3</p>
        </div>
        <div class="panel-footer">
          <img class="float-left teacher-head-sm" src="<%=request.getContextPath()%>/images/head3.png" alt="头像"/>
          <span>鲍钰</span>
          <span class="float-right">上传日期：2016/2/12</span>
        </div>
      </div>
      </a>
      <a href="case.html"><div class="panel case-item">
        <div class="panel-heading">
          <div class="eye">
            <span class="love"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞"/>10</span>
            <span class="click"><img src="<%=request.getContextPath()%>/images/eye2.png" alt="查看"/>200</span>
          </div>
        </div>
        <div class="panel-body">
          <p class="title">《鼎氏汉语》第23课</p>
          <p class="label">标签1 标签2 标签3</p>
        </div>
        <div class="panel-footer">
          <img class="float-left teacher-head-sm" src="<%=request.getContextPath()%>/images/head3.png" alt="头像"/>
          <span>鲍钰</span>
          <span class="float-right">上传日期：2016/2/12</span>
        </div>
      </div>
      </a>
    </div>--%>
    <div class="clearboth"></div>
  </div>
</div>

<jsp:include page="../public/viewFooter.jsp"></jsp:include>
<script type="text/javascript">
  function changePwd(){
    var oldPwd=document.getElementById("oldPwd")
    var reoldPwd=document.getElementById("reoldPwd")
    if(oldPwd.value==""){
      oldPwd.focus()
      $("#reerror").html("密码不能为空")
      return false
    }
    if(reoldPwd.value==""){
      reoldPwd.focus()
      $("#reerror").html("密码不能为空")
      return false
    }
    if(oldPwd.value!=reoldPwd.value){
      reoldPwd.focus()
      $("#reerror").html("两次密码输入不一致")
      return false
    }
    $.ajax({
      url:"<%=request.getContextPath()%>/PasswordManage",
      type:"post",
      data:{newPwd:oldPwd.value},
      success: function (data) {
        location.href="<%=request.getContextPath()%>/Login";
      }
    })
  }
  $('.js-teacher-entrance').click(function() {
    $('.teacher-option').fadeToggle();
  });
</script>
</body>
</html>