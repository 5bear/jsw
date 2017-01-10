<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 22:57
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
      <div class="col-lg-6 col-lg-offset-3 time-row">
        <a href="javascript:history.back();" class="operation"><< 返回</a>
      </div>
      <div class="col-lg-6 col-lg-offset-3">
        <form action="<%=request.getContextPath()%>/TeacherManageEdit" method="post" accept-charset="UTF-8" name="myForm">
        <table class="table vertical-table">
          <tbody>
          <tr>
            <td>教师姓名</td>
            <td><input type="text" name="nickName" id="nickName" value="${teacher.nickName}" class="table-input"/></td>
          </tr>
          <tr>
            <td>工号</td>
            <td><input type="text" name="no" id="no" class="table-input" value="${teacher.no}"/></td>
          </tr>
          <tr>
            <td>工作单位</td>
            <td><input type="text" id="department" name="department" class="table-input" value="${teacher.department}"/></td>
          </tr>
          <tr>
            <td>研究方向</td>
            <td><input type="text" id="researchArea" name="researchArea" class="table-input" value="${teacher.researchArea}"/></td>
          </tr>
          </tbody>
        </table>
        </form>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-4 col-lg-offset-5 col-md-4 col-md-offset-5 col-sm-4 col-sm-offset-4">
        <button class="btn btn-default" onclick="ensure()">确认</button>
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
  function ensure(){
    if('${teacher.tId}'=="") {
      var myForm = document.getElementsByName("myForm")[0];
      myForm.submit()
    }else{
      var nickName=document.getElementById("nickName").value
      var no=document.getElementById("no").value
      var department=document.getElementById("department").value
      var researchArea=document.getElementById("researchArea").value
      $.ajax({
        url:"TeacherEdit",
        type:"post",
        data:{id:'${teacher.tId}',nickName:nickName,no:no,department:department,researchArea:researchArea},
        success: function (data) {
          $("#success").modal("show")
        }
      })
    }
  }
</script>
</body>
</html>
