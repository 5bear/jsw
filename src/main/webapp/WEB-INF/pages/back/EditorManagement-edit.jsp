<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/10/19
  Time: 22:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../css/bootstrap.css" rel="stylesheet">
    <link href="../css/sb-admin.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/end.css"/>
    <title>全球汉语教师网</title>
</head>

<body>

<div id="wrapper">

    <!-- Sidebar -->
    <jsp:include page="../public/backNavi.jsp">
        <jsp:param name="pageName" value="EditorManagement"></jsp:param>
    </jsp:include>

    <div id="page-wrapper">

        <div class="row">
            <div class="col-lg-6 col-lg-offset-3 time-row">
                <a href="javascript:history.back();" class="operation"><< 返回</a>
            </div>
            <div class="col-lg-6 col-lg-offset-3">
                <table class="table vertical-table">
                    <tbody>
                    <tr>
                        <td>编辑姓名</td>
                        <td><input type="text" value="${editor.username}" id="username" class="table-input"/></td>
                    </tr>
                    <tr>
                        <td>工号</td>
                        <td><input type="text" value="${editor.no}" id="no" class="table-input"/></td>
                    </tr>
                    <tr>
                        <td>备注</td>
                        <td><input type="text" value="${editor.remark}" id="remark" class="table-input"/></td>
                    </tr>
                    <%--<tr>
                        <td>密码设置</td>
                        <td><input type="text" value="初始密码为123456" readonly class="table-input"/></td>
                    </tr>--%>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-lg-offset-5 col-md-4 col-md-offset-5 col-sm-4 col-sm-offset-4">
                <button class="btn btn-default" data-toggle="modal" data-target="#success" onclick="updateEditor()">保存</button>
                <button class="btn btn-default">取消</button>
            </div>
        </div>

        <div class="modal fade" id="success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">提示</h4>
                    </div>
                    <div class="modal-body text-center">
                        <p>保存成功</p>
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
    function updateEditor() {
        var  id='${editor.id}'
        if(id=='')
            id=0
        var nickName=$("#username").val()
        var no=$("#no").val()
        if(nickName==""||no==""){
            alert("姓名和工号不能为空！")
            return false
        }
        var remark=$("#remark").val()
        $.ajax({
            url:"<%=request.getContextPath()%>/updateEditor",
            type:"post",
            data:{
                id:id,nickName:nickName,no:no,remark:remark
            },success:function (data) {
                location.reload(true)
            }
        })
    }
</script>
</body>
</html>