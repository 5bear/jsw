<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/10/17
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/viewHead.jsp">
    <jsp:param name="pageName" value="teacher-list"></jsp:param>
</jsp:include>

<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="info-table">
                <h1>申请教师</h1>
                <div>
                    <span>工作单位</span>
                    <span><input type="text" class="table-input"/></span>
                </div>
                <div>
                    <span>研究方向</span>
                    <span><input type="text" class="table-input"/></span>
                </div>
                <div>
                    <span>昵称</span>
                    <span><input type="password" class="table-input"/></span>
                </div>
                <p class="text-center alert-red">请填写所有的选项</p>
            </div>
        </div>

        <div class="row btn-row">
            <div class="text-center">
                <button class="btn btn-default" data-toggle="modal" data-target="#success">申请</button>
                <button class="btn btn-default">取消</button>
            </div>
        </div>

        <div class="modal fade btn-modal" id="success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">申请提示</h4>
                    </div>
                    <div class="modal-body text-center">
                        <p>申请成功,等待验证。</p>
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
            spinner: '.spinner',
            imgSrc: 'images/avatar.png'
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
            this.files = [];
            $('#btnCrop').click();
        })
        $('#btnCrop').on('click', function(){
            img = cropper.getDataURL();
            $('.cropped').html('');
            $('.cropped').append('<img src="'+img+'" align="absmiddle" style="width:64px;margin-top:4px;border-radius:64px;box-shadow:0px 0px 12px #7E7E7E;" ><p>64px*64px</p>');
            $('.cropped').append('<img src="'+img+'" align="absmiddle" style="width:128px;margin-top:4px;border-radius:128px;box-shadow:0px 0px 12px #7E7E7E;"><p>128px*128px</p>');
            $('.cropped').append('<img src="'+img+'" align="absmiddle" style="width:180px;margin-top:4px;border-radius:180px;box-shadow:0px 0px 12px #7E7E7E;"><p>180px*180px</p>');
        })
        function getImg(){

        }
        $('#btnZoomIn').on('click', function(){
            cropper.zoomIn();
        })
        $('#btnZoomOut').on('click', function(){
            cropper.zoomOut();
        })
    });
</script>
</body>
</html>
