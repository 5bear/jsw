<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <jsp:param name="pageName" value="TeacherManage"></jsp:param>
  </jsp:include>

  <div id="page-wrapper">

    <div class="row">
      <div class="col-lg-12">
        <div class="row">
          <div class="col-lg-12 time-row">
            <a href="<%=request.getContextPath()%>/TeacherManageEdit" class="add-operation"><label><img src="<%=request.getContextPath()%>/images/add1.png" alt="增加"/>新增教师</label></a>
          </div>
          <div class="col-lg-12 text-center">
            <table class="table">
              <thead>
              <tr>
                <th>教师姓名</th>
                <th>头像</th>
                <th>工号</th>
                <th>工作单位</th>
                <th>研究方向</th>
                <th>评分</th>
                <th>注册时间</th>
                <th>操作</th>
              </tr>
              </thead>
              <tbody>
            <c:forEach items="${list}" var="teacher">
              <tr>
                <td>${teacher.nickName}</td>
                <td><img class="head" src="<%=request.getContextPath()%>/${teacher.headPath}" alt="头像"/></td>
                <td>${teacher.no}</td>
                <td>${teacher.department}</td>
                <td>${teacher.researchArea}</td>
                <td>${teacher.score}</td>
                <td>${teacher.rDatetime}</td>
                <td><a href="<%=request.getContextPath()%>/TeacherManageEdit?id=${teacher.tId}" class="operation"><label><img src="<%=request.getContextPath()%>/images/edit.png" alt="编辑"/>编辑</label></a>
                  <a class="operation" data-toggle="modal" data-target="#delete${teacher.tId}"><label><img src="<%=request.getContextPath()%>/images/delete1.png" alt="删除"/>删除</label></a>
                </td>
              </tr>
              <div class="modal fade" id="delete${teacher.tId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h4 class="modal-title">删除提示</h4>
                    </div>
                    <div class="modal-body text-center">
                      <p>你确定要删除吗？</p>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                      <button type="button" class="btn btn-default" onclick="deleteTeacher('${teacher.aId}')">确定</button>
                    </div>
                  </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
              </div><!-- /.modal -->

            </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>


  </div><!-- /#page-wrapper -->

</div><!-- /#wrapper -->

<!-- JavaScript -->
<jsp:include page="../public/backFooter.jsp"></jsp:include>
<script>
  function deleteTeacher(id){
    $.ajax({
      url:"deleteTeacher",
      type:"post",
      data:{id:id},
      success: function (data) {
        location.reload(true)
      }
    })
  }
</script>
</body>
</html>