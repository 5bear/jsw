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
    <jsp:param name="pageName" value="TeacherMaintain"></jsp:param>
  </jsp:include>

  <div id="page-wrapper">
    <form name="teacherForm" action="" method="post" accept-charset="UTF-8">
    <div class="row">
      <div class="col-lg-6 col-lg-offset-3 text-center time-row">
        个人信息维护
      </div>
      <div class="col-lg-6 col-lg-offset-3">
        <table class="table vertical-table">
          <tbody>
          <tr hidden="hidden">
            <td>id</td>
            <td><input type="text" name="tId" class="table-input" readonly="readonly" value="${editor.id}"/></td>
          </tr>
        <%--  <tr>
            <td>头像</td>
            <td class="text-left"><img src="<%=request.getContextPath()%>/${account.headPath}" style="width: 50px;height: 50px"><a class="btn btn-default" data-toggle="modal" data-target="#head">修改头像</a></td>
          </tr>--%>
          <tr>
            <td>姓名</td>
            <td><input type="text" class="table-input" name="nickName" value="${editor.username}"/></td>
          </tr>
          <tr>
            <td>工号</td>
            <td><input type="text" class="table-input" name="no"  value="${editor.no}"/></td>
          </tr>
          <tr>
              <td>备注</td>
              <td><input type="text" class="table-input" name="remark"  value="${editor.remark}"/></td>
          </tr>
          </tbody>
        </table>

      </div>
    </div>
    </form>
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
<script src="<%=request.getContextPath()%>/script/cropbox.js"></script>
<script type="text/javascript">
  $(window).load(function() {
    var options =
    {
      thumbBox: '.thumbBox',
      spinner: '.spinner'
    }
    var cropper = $('.imageBox').cropbox(options);
    var img="";
    $('#upload-file').on('change', function(){
      var reader = new FileReader();
      reader.onload = function(e) {
        options.imgSrc = e.target.result;
        cropper = $('.imageBox').cropbox(options);
      }
      reader.readAsDataURL(this.files[0]);
      $('#btnCrop').click();
    })
    $('#btnCrop').on('click', function(){
      img = cropper.getDataURL();
      $('.cropped').html('');
      /*
       $('.cropped').append('<img src="'+img+'" align="absmiddle" style="width:64px;margin-top:4px;border-radius:64px;box-shadow:0px 0px 12px #7E7E7E;" ><p>64px*64px</p>');
       */
      $('.cropped').append('<img src="'+img+'" align="absmiddle" style="width:128px;margin-top:4px;border-radius:128px;box-shadow:0px 0px 12px #7E7E7E;"><p>128px*128px</p>');
      /*
       $('.cropped').append('<img src="'+img+'" align="absmiddle" style="width:180px;margin-top:4px;border-radius:180px;box-shadow:0px 0px 12px #7E7E7E;"><p>180px*180px</p>');
       */
    })
    function getImg(){
      return cropper.getBase64()
    }
    $('#btnZoomIn').on('click', function(){
      cropper.zoomIn();
    })
    $('#btnZoomOut').on('click', function(){
      cropper.zoomOut();
    })
    $('#headSubmit').on('click', function(){
      $("#headPath").val(getImg())
    })
  });
  function checkForm(){
    var teacherForm=document.getElementsByName("teacherForm");
    teacherForm[0].submit()
  }
</script>
</body>
</html>