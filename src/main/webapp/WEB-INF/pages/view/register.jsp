<%@ taglib prefix="Form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/7/11
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/viewHead.jsp">
  <jsp:param name="pageName" value="login"></jsp:param>
</jsp:include>

<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
  <div id="page-wrapper">

      <form action="" method="post" modelAttribute="account" name="accountForm" accept-charset="utf-8">
          <div class="row">
              <div class="info-table">
                  <div>
                      <span>邮箱<i class="red">*</i></span>
                      <span><input type="text" name="email" id="email" class="table-input"/></span>
                  </div>
                  <div>
                      <span>昵称<i class="red">*</i></span>
                      <span><input type="text" name="nickName" id="nickName" class="table-input"/></span>
                  </div>
                  <div hidden="hidden">
                      <span>头像</span>
                      <span><input type="text" name="headPath" id="headPath" value="heads/head.png" class="table-input"/></span>
                  </div>
                  <div>
                      <span>头像</span>
                      <span class="text-left"><a class="btn btn-default" data-toggle="modal" data-target="#head">上传头像</a></span>
                  </div>
                  <div>
                      <span>性别</span>
                            <span>
                                <label><input type="radio" name="sex" checked="checked" value="0"/> 男</label>
                                <label><input type="radio" name="sex" value="1"/> 女</label>
                            </span>
                  </div>
                  <%--<div>
                      <span>兴趣点</span>
                            <span class="register-interest">
                                <c:forEach items="${tags}" var="tag">
                                    <label><input type="checkbox" name="interests" value="${tag.tagId}"/>${tag.utag}</label>
                                </c:forEach>
                            </span>
                  </div>--%>
                  <div>
                      <span>工作单位</span>
                      <span><input type="text" name="department" id="department" class="table-input"/></span>
                  </div>
                  <div>
                      <span>备注</span>
                      <span><input type="text" id="remark" name="remark" class="table-input"/></span>
                  </div>
                  <div>
                      <span>密码<i class="red">*</i></span>
                      <span><input type="password" id="pwd" name="password" class="table-input"/></span>
                  </div>
                  <div>
                      <span>确认密码<i class="red">*</i></span>
                      <span><input type="password" id="repwd" class="table-input"/></span>
                  </div>
                  <p class="text-center alert-red" id="error"></p>
              </div>
          </div>

    <div class="row btn-row lg-btn-row">
      <div class="text-center">
        <button type="button" class="btn btn-default" onclick="checkForm()">注册</button>
        <button type="button" class="btn btn-default" onclick="undoAll()">取消</button>
      </div>
    </div>
     </form>
    <div class="modal fade btn-modal" id="head" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog" style="width: 800px;">
        <div class="modal-content">
          <div class="modal-header">
          </div>
          <div class="modal-body text-center">
            <div class="container">
              <div class="imageBox">
                <div class="thumbBox"></div>
                <div class="spinner" style="display: none">Loading...</div>
              </div>
              <div class="action">
                <!-- <input type="file" id="file" style=" width: 200px">-->
                <div class="new-contentarea tc"> <a href="javascript:void(0)" class="upload-img">
                  <label  for="upload-file">上传图像</label>
                </a>
                    <form action="/upload/fileUpload" method="post" enctype="multipart/form-data" target="myFrame" name="fileForm">
                    <input type="file" class="" name="file" id="upload-file" />
                        </form>
                </div>
                <input type="button" id="btnCrop"  class="Btnsty_peyton" value="裁切">
                <input type="button" id="btnZoomIn" class="Btnsty_peyton" value="+"  >
                <input type="button" id="btnZoomOut" class="Btnsty_peyton" value="-" >
              </div>
              <div class="cropped"></div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" id="headSubmit">确定</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="modal fade btn-modal" id="success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
<jsp:include page="../public/viewFooter.jsp"></jsp:include>
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
     /* this.files = [];*/
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
        var accountForm=document.getElementsByName("accountForm");
        var email=document.getElementById("email");
        var nickName=document.getElementById("nickName")
        var password=document.getElementById("pwd")
        var repassword=document.getElementById("repwd")
        var department=document.getElementById("department")
        var remark=document.getElementById("remark")
        var errorstr="";
        if(nickName.value==""){
            nickName.focus()
            errorstr += "昵称不能为空;"
            $("#error").html(errorstr)
            return false
        }
        if(password.value==""){
            password.focus()
            errorstr += "密码不能为空;"
            $("#error").html(errorstr)
            return false
        }
        if(repassword.value==""){
            repassword.focus()
            errorstr += "确认密码不能为空;"
            $("#error").html(errorstr)
            return false
        }
        if(password.value!=""&&repassword.value!=""&&password.value!=repassword.value){
            repassword.focus()
            errorstr += "两次密码输入不一致;"
            $("#error").html(errorstr)
            return false
        }
        if(!emailCheck()) {
            email.focus()
            errorstr += "电子邮件地址必须包括 ( @ 和 . );"
            $("#error").html(errorstr)
            return false
        }else{
            $.ajax({
                url:"checkEmail",
                type:"post",
                data:{email:email.value,id:0},
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
    function undoAll(){
        var email=document.getElementById("email");
        var nickName=document.getElementById("nickName")
        var password=document.getElementById("pwd")
        var repassword=document.getElementById("repwd")
        var department=document.getElementById("department")
        var remark=document.getElementById("remark")
        email.value=""
        nickName.value=""
        password.value=""
        repassword.value=""
        department.value=""
        remark.value=""
    }
</script>
</body>
</html>
