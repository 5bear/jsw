<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/10/17
  Time: 15:11
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
        <jsp:param name="pageName" value="TeacherCheck"></jsp:param>
    </jsp:include>

    <div id="page-wrapper">

        <div class="row">
            <div class="col-lg-12">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>教师姓名</th>
                                <th>头像</th>
                                <th>注册时间</th>
                                <th>工作单位</th>
                                <th>研究方向</th>
                                <th>昵称</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>XXX</td>
                                <td><img class="head" src="../images/head1.png" alt="头像"/></td>
                                <td>2016-04-01</td>
                                <td>工作单位</td>
                                <td>研究方向</td>
                                <td>XXXXXXX</td>
                                <td>
                                    <a class="operation"><label><span class="glyphicon glyphicon-ok"></span>通过</label></a>
                                    <a class="operation" data-toggle="modal" data-target="#refuse-modal"><label><span class="glyphicon glyphicon-remove"></span>拒绝</label></a>
                                </td>
                            </tr>
                            <tr>
                                <td>XXX</td>
                                <td><img class="head" src="../images/head1.png" alt="头像"/></td>
                                <td>2016-04-01</td>
                                <td>工作单位</td>
                                <td>研究方向</td>
                                <td>XXXXXXX</td>
                                <td>
                                    <a class="operation"><label><span class="glyphicon glyphicon-ok"></span>通过</label></a>
                                    <a class="operation" data-toggle="modal" data-target="#refuse-modal"><label><span class="glyphicon glyphicon-remove"></span>拒绝</label></a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="refuse-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">拒绝</h4>
                    </div>
                    <div class="modal-body text-center">
                        <textarea class="form-control" id="opinion" placeholder="请输入拒绝原因"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">确定</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->


    </div><!-- /#page-wrapper -->

</div><!-- /#wrapper -->

<!-- JavaScript -->
<jsp:include page="../public/backFooter.jsp"></jsp:include>
</body>
</html>
