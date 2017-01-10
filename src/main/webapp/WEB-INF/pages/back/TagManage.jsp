<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 22:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  int totalPage=(Integer)request.getAttribute("totalPage");
  int currentPage=(Integer)request.getAttribute("currentPage");
  String status= (String) request.getAttribute("status");
  String url=status==null?request.getContextPath()+"/TagManage?":request.getContextPath()+"/TagManage?status="+status+"&&";
  if(!"0".equals(status)&&!"1".equals(status)&&!"2".equals(status))
    status="3";
%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/backHead.jsp"></jsp:include>
<body>

<div id="wrapper">

  <!-- Sidebar -->
  <jsp:include page="../public/backNavi.jsp">
    <jsp:param name="pageName" value="TagManage"></jsp:param>
  </jsp:include>

  <div id="page-wrapper">

    <div class="row">
      <div class="col-lg-12 time-row">
        审核状态
        <select onchange="filterStatus(this.options[this.options.selectedIndex].value)">
          <option <%=status.equals("3")?"selected":""%>></option>
          <option value="0" <%=status.equals("0")?"selected":""%>>未审核</option>
          <option value="1" <%=status.equals("1")?"selected":""%>>审核通过</option>
          <option value="2" <%=status.equals("2")?"selected":""%>>已驳回</option>
        </select>
      </div>
      <div class="col-lg-12 text-center">
        <table class="table">
          <thead>
          <tr>
            <th>案例名称</th>
            <th>教师</th>
            <th>原tag</th>
            <th>增加tag</th>
            <th>状态</th>
            <th>操作</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${list}" var="tag">
            <tr>
              <td>${tag.slide.title}</td>
              <td>${tag.slide.teacher.nickName}</td>
              <td class="course-tag">${tag.slide.tTag}</td>
              <td>${tag.utag}</td>
              <td class="replyed"><script>
                if('${tag.status}'=='0'){
                  document.write("未审核")
                }else if('${tag.status}'=='1'){
                  document.write("审核通过")
                } else{
                  document.write("已驳回")
                }
              </script></td>
              <td>
               <c:choose>
                 <c:when test="${tag.status==0}">
                   <a class="operation check-operation" data-toggle="modal" data-target="#success${tag.tagId}"><label><span class="glyphicon glyphicon-ok"></span> 审核通过</label></a>
                   <a class="operation check-operation" data-toggle="modal" data-target="#fail${tag.tagId}"><label><span class="glyphicon glyphicon-remove"></span> 驳回</label></a>
                   <a class="operation" data-toggle="modal" data-target="#delete${tag.tagId}"><label><img src="<%=request.getContextPath()%>/images/delete1.png" alt="删除"/>删除</label></a>
                   <div class="modal fade" id="delete${tag.tagId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">删除提示</h4>
                         </div>
                         <div class="modal-body text-center">
                           <p>确认删除？</p>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(3,'${tag.tagId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                   <div class="modal fade" id="success${tag.tagId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">审核提示</h4>
                         </div>
                         <div class="modal-body text-center">
                           <p>是否通过？</p>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(1,'${tag.tagId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->

                   <div class="modal fade" id="fail${tag.tagId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">审核提示</h4>
                         </div>
                         <div class="modal-body text-center">
                           <p>是否驳回？</p>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal"onclick="changeStatus(2,'${tag.tagId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                 </c:when>
                 <c:when test="${tag.status==1}">
                   <a class="operation check-operation" data-toggle="modal" data-target="#fail${tag.tagId}"><label><span class="glyphicon glyphicon-remove"></span> 驳回</label></a>
                   <div class="modal fade" id="fail${tag.tagId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">审核提示</h4>
                         </div>
                         <div class="modal-body text-center">
                           <p>是否驳回？</p>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal"onclick="changeStatus(2,'${tag.tagId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                   <a class="operation" data-toggle="modal" data-target="#delete${tag.tagId}"><label><img src="<%=request.getContextPath()%>/images/delete1.png" alt="删除"/>删除</label></a>
                   <div class="modal fade" id="delete${tag.tagId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">删除提示</h4>
                         </div>
                         <div class="modal-body text-center">
                           <p>确认删除？</p>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(3,'${tag.tagId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                 </c:when>
                 <c:when test="${tag.status==2}">
                   <a class="operation check-operation" data-toggle="modal" data-target="#success${tag.tagId}"><label><span class="glyphicon glyphicon-ok"></span> 审核通过</label></a>
                   <div class="modal fade" id="success${tag.tagId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">审核提示</h4>
                         </div>
                         <div class="modal-body text-center">
                           <p>是否通过？</p>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(1,'${tag.tagId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                   <a class="operation" data-toggle="modal" data-target="#delete${tag.tagId}"><label><img src="<%=request.getContextPath()%>/images/delete1.png" alt="删除"/>删除</label></a>
                   <div class="modal fade" id="delete${tag.tagId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">删除提示</h4>
                         </div>
                         <div class="modal-body text-center">
                           <p>确认删除？</p>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(3,'${tag.tagId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                 </c:when>
               </c:choose>
              </td>
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




  </div><!-- /#page-wrapper -->

</div><!-- /#wrapper -->

<!-- JavaScript -->
<jsp:include page="../public/backFooter.jsp"></jsp:include>
<script>
  function changeStatus(status,tagId){
    $.ajax({
      url:"changeStatus",
      type:"post",
      data:{status:status,tagId:tagId},
      success: function (data) {
        location.reload(true)
      }
    })
  }
  function filterStatus(status){
    location.href="<%=request.getContextPath()%>/TagManage?status="+status;
  }
</script>
</body>
</html>
