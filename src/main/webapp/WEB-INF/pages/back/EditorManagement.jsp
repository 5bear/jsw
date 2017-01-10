<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/10/19
  Time: 22:00
  To change this template use File | Settings | File Templates.
--%>
<%
    String url=request.getContextPath()+"/EditorManagement?";
    int totalPage= (Integer) request.getAttribute("totalPage");
    int currentPage= (Integer) request.getAttribute("currentPage");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/backHead.jsp"></jsp:include>
<body>

<div id="wrapper">

    <!-- Sidebar -->
    <jsp:include page="../public/backNavi.jsp">
        <jsp:param name="pageName" value="EditorManagement"></jsp:param>
    </jsp:include>

    <div id="page-wrapper">

        <div class="row">
            <div class="col-lg-12">
                <div class="row">
                    <div class="col-lg-12 time-row">
                        <a href="<%=request.getContextPath()%>/EditorManagement/0" class="add-operation"><label><img src="<%=request.getContextPath()%>/images/add1.png" alt="增加"/>新增编辑</label></a>
                    </div>
                    <div class="col-lg-12 text-center">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>编辑姓名</th>
                                <th>工号</th>
                                <th>备注</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                          <c:forEach items="${list}" var="editor">
                              <tr>
                                  <td>${editor.username}</td>
                                  <td>${editor.no}</td>
                                  <td>${editor.remark}</td>
                                  <td><a href="#" onclick="resetPWD(${editor.id})" class="operation"><label style="width: 80px"><img src="<%=request.getContextPath()%>/images/edit.png"  alt="重置密码"/>重置密码</label></a>
                                      <a class="operation" data-toggle="modal" data-target="#delete${editor.id}"><label><img src="<%=request.getContextPath()%>/images/delete1.png" alt="删除"/>删除</label></a>
                                  </td>
                                  <div class="modal fade" id="delete${editor.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                                                  <button type="button" class="btn btn-default" data-dismiss="modal" onclick="deleteEditor(${editor.id})">确定</button>
                                              </div>
                                          </div><!-- /.modal-content -->
                                      </div><!-- /.modal-dialog -->
                                  </div><!-- /.modal -->
                              </tr>
                          </c:forEach>
                            </tbody>
                        </table>
                        <jsp:include page="../public/page.jsp">
                            <jsp:param name="url" value="<%=url%>"></jsp:param>
                            <jsp:param name="totalPage" value="<%=totalPage%>"></jsp:param>
                            <jsp:param name="currentPage" value="<%=currentPage%>"></jsp:param>
                        </jsp:include>
                    </div>
                </div>
            </div>
        </div>


    </div><!-- /#page-wrapper -->

</div><!-- /#wrapper -->

<!-- JavaScript -->
<jsp:include page="../public/backFooter.jsp"></jsp:include>
<script>
    function  deleteEditor(id) {
        $.ajax({
            url:"deleteEditor",
            type:"post",
            data:{id:id},
            success:function(data){
                if(data=="fail"){
                    alert("操作失败");
                    return false
                }
                location.reload(true)
            }
        })
    }
    function resetPWD(id) {
        $.ajax({
            url:"resetPWD",
            type:"post",
            data:{id:id},
            success:function(data){
                if(data=="fail"){
                    alert("操作失败");
                    return false
                }
                location.reload(true)
            }
        })
    }
</script>
</body>
</html>
