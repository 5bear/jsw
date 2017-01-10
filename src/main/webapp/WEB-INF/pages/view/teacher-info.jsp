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
                <a href="../html/user-index.html" class="back">< 返回</a>
                <h1>个人信息维护</h1>
                <div>
                    <span>注册时间</span>
                    <span><input type="text" class="table-input" value="2016-02-05" readonly/></span>
                </div>
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
                <div>
                    <span>评分</span>
                    <span>
                                <input type="text" class="table-input" value="4.65" readonly/>
                            </span>
                </div>
                <p class="text-center alert-red">请填写所有的选项</p>
            </div>
        </div>

        <div class="row btn-row">
            <div class="text-center">
                <button class="btn btn-default" data-toggle="modal" data-target="#success">修改</button>
                <button class="btn btn-default">取消</button>
            </div>
        </div>

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

</body>
</html>
