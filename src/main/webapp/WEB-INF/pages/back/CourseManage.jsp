<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 22:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  int totalPage= (Integer) request.getAttribute("totalPage");
  int currentPage= (Integer) request.getAttribute("currentPage");
  String status= (String) request.getAttribute("status");
  String url=status==null?request.getContextPath()+"/CourseManage?":request.getContextPath()+"/CourseManage?status="+status+"&&";
    String redirectUrl=status==null?"/CourseManage?":"/CourseManage?status="+status+"&&";

    if(!"3".equals(status)&&!"1".equals(status)&&!"2".equals(status)&&!"4".equals(status)&&!"5".equals(status)&&!"6".equals(status))
    status="0";
%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/backHead.jsp"></jsp:include>

<body>

<div id="wrapper">

  <!-- Sidebar -->
  <jsp:include page="../public/backNavi.jsp">
    <jsp:param name="pageName" value="CourseManage"></jsp:param>
  </jsp:include>

  <div id="page-wrapper">

    <div class="row">
      <div class="col-lg-12 time-row">
        审核状态
        <select onchange="filterStatus(this.options[this.options.selectedIndex].value)">
          <option value="0" <%=status.equals("0")?"selected":""%>>全部稿件</option>
          <option value="5" <%=status.equals("5")?"selected":""%>>审核通过</option>
          <option value="4" <%=status.equals("4")?"selected":""%>>拒绝录用</option>
          <option value="6" <%=status.equals("6")?"selected":""%>>退回修改</option>
          <option value="3" <%=status.equals("3")?"selected":""%>>正在编审</option>
          <option value="2" <%=status.equals("2")?"selected":""%>>提交待审</option>
<%--
          <option value="1" <%=status.equals("1")?"selected":""%>>草稿箱</option>
--%>
        </select>
      </div>
      <div class="col-lg-12 text-center">
        <table class="table">
          <thead>
          <tr>
            <th>案例名称</th>
            <th>案例分类</th>
            <th>二级分类</th>
            <th>案例标签</th>
            <th>管理员标签</th>
            <th>用户标签</th>
            <th>上传文件</th>
            <th>上传时间</th>
            <th>教师</th>
            <th>状态</th>
            <th>操作</th>
          </tr>
          </thead>
          <tbody>
         <c:forEach items="${list}" var="slide">
           <tr>
             <td>${slide.title}</td>
             <td class="course-sort">${slide.type}</td>
             <td class="course-sort">${slide.secondtype}</td>
             <td class="course-tag">${slide.tTag}</td>
             <td class="course-tag">${slide.aTag}</td>
             <td class="course-tag">${slide.uTag}</td>
             <%--<td><a href="<%=request.getContextPath()%>/${slide.filePath}" target="_blank">${slide.fileName}</a></td>--%>
             <td style="max-width: 160px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><a class="course-preview" href="javascript:var fileType='${slide.fileType}';if(fileType=='pdf'||fileType=='video'||fileType=='image')location.href='<%=request.getContextPath()%>/Preview/${slide.sId}';else location.href='<%=request.getContextPath()%>/${slide.filePath}'">${slide.fileName}</a></td>
             <td>${slide.uploadDatetime}</td>
             <td>${slide.teacher.nickName}</td>
             <td class="replying"><script>
               if('${slide.state}'=="1"){
                 document.write("未提交")
               }else if('${slide.state}'=="2"){
                 document.write("提交待审")
               }else if('${slide.state}'=="3"){
                 document.write("正在编审")
               }else if('${slide.state}'=="4"){
                 document.write("拒绝录用")
               }else if('${slide.state}'=="5"){
                 document.write("审核通过")
               }else if('${slide.state}'=="6"){
                   document.write("退回修改")
               }
             </script></td>
             <td>
               <c:choose>
               <%--  <c:when test="${slide.state==1}">
&lt;%&ndash;
                   <a href="CourseManagement-edit.html" class="operation"><label><img src="../images/edit.png" alt="编辑"/>编辑</label></a>
&ndash;%&gt;
                   <a class="operation check-operation" data-toggle="modal" data-target="#success${slide.sId}"><label><span class="glyphicon glyphicon-ok"></span> 审核通过</label></a>
                   <div class="modal fade" id="success${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(5,'${slide.sId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                   <a class="operation check-operation" data-toggle="modal" data-target="#fail${slide.sId}"><label><span class="glyphicon glyphicon-remove"></span> 退回</label></a>
                   <div class="modal fade" id="fail${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">审核提示</h4>
                         </div>
                         <div class="modal-body text-center">
                           <textarea class="form-control" id="opinion${slide.sId}" placeholder="请输入退回意见">${slide.opinion}</textarea>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(4,'${slide.sId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                   <a class="operation check-operation" data-toggle="modal" data-target="#label${slide.sId}"><label><span class="glyphicon glyphicon-plus"></span> 新增标签</label></a>
                   <div class="modal fade" id="label${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">标签</h4>
                         </div>
                         <div class="modal-body text-center">
                           <input type="text" class="form-control" id="addLabel${slide.sId}" placeholder="请输入标签"/>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="addLabel('${slide.sId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                 </c:when>--%>
                 <c:when test="${slide.state==1}">
                   <%--<a href="CourseManagement-edit.html" class="operation"><label><img src="../images/edit.png" alt="编辑"/>编辑</label></a>--%>
                   <a class="operation check-operation" data-toggle="modal" data-target="#success${slide.sId}"><label><span class="glyphicon glyphicon-ok"></span> 审核通过</label></a>
                     <div class="modal fade" id="fail${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                         <div class="modal-dialog">
                             <div class="modal-content">
                                 <div class="modal-header">
                                     <h4 class="modal-title">审核提示</h4>
                                     <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                 </div>
                                 <div class="modal-body text-center">
                                     <textarea class="form-control advice-textarea" id="opinion${slide.sId}" placeholder="请输入退回意见">${slide.opinion}</textarea>
                                 </div>
                                 <div class="modal-footer">
                                     <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(6,'${slide.sId}')">退回修改</button>
                                     <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(4,'${slide.sId}')">拒绝录用</button>
                                 </div>
                             </div><!-- /.modal-content -->
                         </div><!-- /.modal-dialog -->
                     </div><!-- /.modal -->
                   <a class="operation check-operation" data-toggle="modal" data-target="#fail${slide.sId}"><label><span class="glyphicon glyphicon-remove"></span> 退回稿件</label></a>
                   <div class="modal fade" id="fail${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">审核提示</h4>
                           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                         </div>
                         <div class="modal-body text-center">
                           <textarea class="form-control advice-textarea" id="opinion${slide.sId}" placeholder="请输入退回意见">${slide.opinion}</textarea>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(6,'${slide.sId}')">退回修改</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(4,'${slide.sId}')">拒绝录用</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                   <a class="operation check-operation" data-toggle="modal" data-target="#label${slide.sId}"><label><span class="glyphicon glyphicon-plus"></span> 新增标签</label></a>
                   <div class="modal fade" id="label${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">标签</h4>
                         </div>
                         <div class="modal-body text-center">
                           <input type="text" class="form-control" id="addLabel${slide.sId}" placeholder="请输入标签"/>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="addLabel('${slide.sId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                     <a class="operation check-operation" href="javascript:getLog(${slide.sId})"><label><span class="glyphicon glyphicon glyphicon-list"></span> 历史记录</label></a>
                 </c:when>
                 <c:when test="${slide.state==2}">
<%--
                   <a href="CourseManagement-edit.html" class="operation"><label><img src="../images/edit.png" alt="编辑"/>编辑</label></a>
--%>
                   <a class="operation check-operation" data-toggle="modal" data-target="#success${slide.sId}"><label><span class="glyphicon glyphicon-ok"></span> 审核通过</label></a>
                     <div class="modal fade" id="success${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                                     <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(5,'${slide.sId}')">确定</button>
                                 </div>
                             </div><!-- /.modal-content -->
                         </div><!-- /.modal-dialog -->
                     </div><!-- /.modal -->                   <a class="operation check-operation" data-toggle="modal" data-target="#fail${slide.sId}"><label><span class="glyphicon glyphicon-remove"></span> 退回稿件</label></a>
                     <div class="modal fade" id="fail${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                         <div class="modal-dialog">
                             <div class="modal-content">
                                 <div class="modal-header">
                                     <h4 class="modal-title">审核提示</h4>
                                     <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                 </div>
                                 <div class="modal-body text-center">
                                     <textarea class="form-control advice-textarea" id="opinion${slide.sId}" placeholder="请输入退回意见">${slide.opinion}</textarea>
                                 </div>
                                 <div class="modal-footer">
                                     <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(6,'${slide.sId}')">退回修改</button>
                                     <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(4,'${slide.sId}')">拒绝录用</button>
                                 </div>
                             </div><!-- /.modal-content -->
                         </div><!-- /.modal-dialog -->
                     </div><!-- /.modal -->
                     <a class="operation check-operation" data-toggle="modal" data-target="#update${slide.sId}"><label><span class="glyphicon glyphicon-remove"></span> 更新文件</label></a>
                     <div class="modal fade" id="update${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                         <div class="modal-dialog">
                             <div class="modal-content">
                                 <div class="modal-header">
                                     <h4 class="modal-title">上传文件</h4>
                                 </div>
                                 <form action="<%=request.getContextPath()%>/reUpload" method="POST" enctype="multipart/form-data" id="form${slide.sId}">
                                     <div class="modal-body text-center">
                                         <input style="display: none" name="sid" value="${slide.sId}">
                                         <input style="display: none" name="redirectUrl" value="<%=redirectUrl+"pn="+currentPage%>">
                                         <input name="file" type="file" value="选择文件上传" id="file${slide.sId}">
                                     </div>
                                     <div class="modal-footer">
                                         <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                         <button type="button" class="btn btn-default" onclick="checkFile(${slide.sId})">确定</button>
                                     </div>
                                 </form>
                             </div><!-- /.modal-content -->
                         </div><!-- /.modal-dialog -->
                     </div><!-- /.modal -->
                   <a class="operation check-operation" data-toggle="modal" data-target="#label${slide.sId}"><label><span class="glyphicon glyphicon-plus"></span> 新增标签</label></a>
                   <div class="modal fade" id="label${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">标签</h4>
                         </div>
                         <div class="modal-body text-center">
                           <input type="text" class="form-control" id="addLabel${slide.sId}" placeholder="请输入标签"/>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="addLabel('${slide.sId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                     <a class="operation check-operation" href="javascript:getLog(${slide.sId})"><label><span class="glyphicon glyphicon glyphicon-list"></span> 历史记录</label></a>
                 </c:when>
                 <c:when test="${slide.state==3}">
                   <%--
                                      <a href="CourseManagement-edit.html" class="operation"><label><img src="../images/edit.png" alt="编辑"/>编辑</label></a>
                   --%>
                   <a class="operation check-operation" data-toggle="modal" data-target="#success${slide.sId}"><label><span class="glyphicon glyphicon-ok"></span> 审核通过</label></a>
                     <div class="modal fade" id="success${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                                     <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(5,'${slide.sId}')">确定</button>
                                 </div>
                             </div><!-- /.modal-content -->
                         </div><!-- /.modal-dialog -->
                     </div><!-- /.modal -->                   <a class="operation check-operation" data-toggle="modal" data-target="#fail${slide.sId}"><label><span class="glyphicon glyphicon-remove"></span> 退回</label></a>
                     <div class="modal fade" id="fail${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                         <div class="modal-dialog">
                             <div class="modal-content">
                                 <div class="modal-header">
                                     <h4 class="modal-title">审核提示</h4>
                                     <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                 </div>
                                 <div class="modal-body text-center">
                                     <textarea class="form-control advice-textarea" id="opinion${slide.sId}" placeholder="请输入退回意见">${slide.opinion}</textarea>
                                 </div>
                                 <div class="modal-footer">
                                     <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(6,'${slide.sId}')">退回修改</button>
                                     <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(4,'${slide.sId}')">拒绝录用</button>
                                 </div>
                             </div><!-- /.modal-content -->
                         </div><!-- /.modal-dialog -->
                     </div><!-- /.modal -->
                     <a class="operation check-operation" data-toggle="modal" data-target="#update${slide.sId}"><label><span class="glyphicon glyphicon-remove"></span> 更新文件</label></a>
                     <div class="modal fade" id="update${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                         <div class="modal-dialog">
                             <div class="modal-content">
                                 <div class="modal-header">
                                     <h4 class="modal-title">上传文件</h4>
                                 </div>
                                       <form action="<%=request.getContextPath()%>/reUpload" method="POST" enctype="multipart/form-data" id="form${slide.sId}">
                                 <div class="modal-body text-center">
                                     <input style="display: none" name="sid" value="${slide.sId}">
                                     <input style="display: none" name="redirectUrl" value="<%=redirectUrl+"pn="+currentPage%>">
                                     <input name="file" type="file" value="选择文件上传" id="file${slide.sId}">
                                 </div>
                                 <div class="modal-footer">
                                     <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                     <button type="button" class="btn btn-default" onclick="checkFile(${slide.sId})">确定</button>
                                 </div>
                                 </form>
                             </div><!-- /.modal-content -->
                         </div><!-- /.modal-dialog -->
                     </div><!-- /.modal -->
                     <a class="operation check-operation" data-toggle="modal" data-target="#label${slide.sId}"><label><span class="glyphicon glyphicon-plus"></span> 新增标签</label></a>
                   <div class="modal fade" id="label${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">标签</h4>
                         </div>
                         <div class="modal-body text-center">
                           <input type="text" class="form-control" id="addLabel${slide.sId}" placeholder="请输入标签"/>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="addLabel('${slide.sId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                     <a class="operation check-operation" href="javascript:getLog(${slide.sId})"><label><span class="glyphicon glyphicon glyphicon-list"></span> 历史记录</label></a>
                 </c:when>
                 <c:when test="${slide.state==4}">
                   <%--
                                      <a href="CourseManagement-edit.html" class="operation"><label><img src="../images/edit.png" alt="编辑"/>编辑</label></a>
                   --%>
                   <a class="operation check-operation" data-toggle="modal" data-target="#success${slide.sId}"><label><span class="glyphicon glyphicon-ok"></span> 审核通过</label></a>
                     <div class="modal fade" id="success${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                                     <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(5,'${slide.sId}')">确定</button>
                                 </div>
                             </div><!-- /.modal-content -->
                         </div><!-- /.modal-dialog -->
                     </div><!-- /.modal -->                     <a class="operation check-operation" data-toggle="modal" data-target="#update${slide.sId}"><label><span class="glyphicon glyphicon-remove"></span> 更新文件</label></a>
                     <div class="modal fade" id="update${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                         <div class="modal-dialog">
                             <div class="modal-content">
                                 <div class="modal-header">
                                     <h4 class="modal-title">上传文件</h4>
                                 </div>
                                 <form action="<%=request.getContextPath()%>/reUpload" method="POST" enctype="multipart/form-data" id="form${slide.sId}">
                                     <div class="modal-body text-center">
                                         <input style="display: none" name="sid" value="${slide.sId}">
                                         <input style="display: none" name="redirectUrl" value="<%=redirectUrl+"pn="+currentPage%>">
                                         <input name="file" type="file" value="选择文件上传" id="file${slide.sId}">
                                     </div>
                                     <div class="modal-footer">
                                         <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                         <button type="button" class="btn btn-default" onclick="checkFile(${slide.sId})">确定</button>
                                     </div>
                                 </form>
                             </div><!-- /.modal-content -->
                         </div><!-- /.modal-dialog -->
                     </div><!-- /.modal -->

                     <a class="operation check-operation" data-toggle="modal" data-target="#label${slide.sId}"><label><span class="glyphicon glyphicon-plus"></span> 新增标签</label></a>
                   <div class="modal fade" id="label${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">标签</h4>
                         </div>
                         <div class="modal-body text-center">
                           <input type="text" class="form-control" id="addLabel${slide.sId}" placeholder="请输入标签"/>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="addLabel('${slide.sId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                     <a class="operation check-operation" href="javascript:getLog(${slide.sId})"><label><span class="glyphicon glyphicon glyphicon-list"></span> 历史记录</label></a>
                 </c:when>
                 <c:when test="${slide.state==5}">
                   <%--
                                      <a href="CourseManagement-edit.html" class="operation"><label><img src="../images/edit.png" alt="编辑"/>编辑</label></a>
                   --%>
                   <a class="operation check-operation" data-toggle="modal" data-target="#fail${slide.sId}"><label><span class="glyphicon glyphicon-remove"></span> 退回稿件</label></a>
                     <div class="modal fade" id="fail${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                         <div class="modal-dialog">
                             <div class="modal-content">
                                 <div class="modal-header">
                                     <h4 class="modal-title">审核提示</h4>
                                     <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                 </div>
                                 <div class="modal-body text-center">
                                     <textarea class="form-control advice-textarea" id="opinion${slide.sId}" placeholder="请输入退回意见">${slide.opinion}</textarea>
                                 </div>
                                 <div class="modal-footer">
                                     <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(6,'${slide.sId}')">退回修改</button>
                                     <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(4,'${slide.sId}')">拒绝录用</button>
                                 </div>
                             </div><!-- /.modal-content -->
                         </div><!-- /.modal-dialog -->
                     </div><!-- /.modal -->
                   <a class="operation check-operation" data-toggle="modal" data-target="#label${slide.sId}"><label><span class="glyphicon glyphicon-plus"></span> 新增标签</label></a>
                   <div class="modal fade" id="label${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                     <div class="modal-dialog">
                       <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title">标签</h4>
                         </div>
                         <div class="modal-body text-center">
                           <input type="text" class="form-control" id="addLabel${slide.sId}" placeholder="请输入标签"/>
                         </div>
                         <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                           <button type="button" class="btn btn-default" data-dismiss="modal" onclick="addLabel('${slide.sId}')">确定</button>
                         </div>
                       </div><!-- /.modal-content -->
                     </div><!-- /.modal-dialog -->
                   </div><!-- /.modal -->
                     <a class="operation check-operation" href="javascript:getLog(${slide.sId})"><label><span class="glyphicon glyphicon glyphicon-list"></span> 历史记录</label></a>
                 </c:when>
                   <c:when test="${slide.state==6}">
                       <%--
                                          <a href="CourseManagement-edit.html" class="operation"><label><img src="../images/edit.png" alt="编辑"/>编辑</label></a>
                       --%>
                       <a class="operation check-operation" data-toggle="modal" data-target="#success${slide.sId}"><label><span class="glyphicon glyphicon-ok"></span> 审核通过</label></a>
                       <div class="modal fade" id="success${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                                       <button type="button" class="btn btn-default" data-dismiss="modal" onclick="changeStatus(5,'${slide.sId}')">确定</button>
                                   </div>
                               </div><!-- /.modal-content -->
                           </div><!-- /.modal-dialog -->
                       </div><!-- /.modal -->                       <a class="operation check-operation" data-toggle="modal" data-target="#update${slide.sId}"><label><span class="glyphicon glyphicon-remove"></span> 更新文件</label></a>
                       <div class="modal fade" id="update${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                           <div class="modal-dialog">
                               <div class="modal-content">
                                   <div class="modal-header">
                                       <h4 class="modal-title">上传文件</h4>
                                   </div>
                                   <form action="<%=request.getContextPath()%>/reUpload" method="POST" enctype="multipart/form-data" id="form${slide.sId}">
                                       <div class="modal-body text-center">
                                           <input style="display: none" name="sid" value="${slide.sId}">
                                           <input style="display: none" name="redirectUrl" value="<%=redirectUrl+"pn="+currentPage%>">
                                           <input name="file" type="file" value="选择文件上传" id="file${slide.sId}">
                                       </div>
                                       <div class="modal-footer">
                                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                           <button type="button" class="btn btn-default" onclick="checkFile(${slide.sId})">确定</button>
                                       </div>
                                   </form>
                               </div><!-- /.modal-content -->
                           </div><!-- /.modal-dialog -->
                       </div><!-- /.modal -->

                       <a class="operation check-operation" data-toggle="modal" data-target="#label${slide.sId}"><label><span class="glyphicon glyphicon-plus"></span> 新增标签</label></a>
                       <div class="modal fade" id="label${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                           <div class="modal-dialog">
                               <div class="modal-content">
                                   <div class="modal-header">
                                       <h4 class="modal-title">标签</h4>
                                   </div>
                                   <div class="modal-body text-center">
                                       <input type="text" class="form-control" id="addLabel${slide.sId}" placeholder="请输入标签"/>
                                   </div>
                                   <div class="modal-footer">
                                       <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                       <button type="button" class="btn btn-default" data-dismiss="modal" onclick="addLabel('${slide.sId}')">确定</button>
                                   </div>
                               </div><!-- /.modal-content -->
                           </div><!-- /.modal-dialog -->
                       </div><!-- /.modal -->
                       <a class="operation check-operation" href="javascript:getLog(${slide.sId})"><label><span class="glyphicon glyphicon glyphicon-list"></span> 历史记录</label></a>
                   </c:when>
               </c:choose>
             </td>
           </tr>
         </c:forEach>
          </tbody>
        </table>
          <div class="modal fade btn-modal" id="log" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
              <div class="modal-dialog">
                  <div class="modal-content">
                      <div class="modal-header">
                          <h4 class="modal-title log-title">历史记录</h4>
                      </div>
                      <div class="modal-body text-center" id="log_content">
                          <div class="log-item">
                              <p class="time">2017-03-04：</p>
                              <p class="content">案例被审核通过</p>
                          </div>
                          <div class="log-item">
                              <p class="time">2017-03-04：</p>
                              <p class="content">案例被审核通过</p>
                          </div>
                          <div class="log-item">
                              <p class="time">2017-03-04：</p>
                              <p class="content">案例被审核通过</p>
                          </div>
                      </div>
                      <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                      </div>
                  </div><!-- /.modal-content -->
              </div><!-- /.modal-dialog -->
          </div><!-- /.modal -->

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
  function changeStatus(status,sId){
    var opinion=document.getElementById("opinion"+sId)
    $.ajax({
      url:"filterCourse",
      type:"post",
      data:{status:status,sId:sId,opinion:opinion==undefined?"":opinion.value},
      success: function (data) {
          if(data=="success"){
              location.reload(true)
          } else if(data=="TagEmpty"){
              alert("案例标签不能为空")
              return false
          }else if(data=="FileTypeError"){
              alert("上传文件类型(非pdf/video/image)无法通过审核")
              return false
          }
          else {
              alert("案例通过失败")
              return false
          }
      }
    })
  }
  function filterStatus(status){
    location.href="<%=request.getContextPath()%>/CourseManage?status="+status;
  }
  function addLabel(sId){
    var label=$("#addLabel"+sId).val()
    $.ajax({
      url:"addAdminTag",
      type:"post",
      data:{tag:label,sId:sId},
      success: function (data) {
        location.reload(true)
      }
    })
  }
  function checkFile(sid) {
      var file=document.getElementById("file"+sid)
      if(file.files.length==0){
          alert("请上传案例")
          return false
      }
      var form=document.getElementById("form"+sid)
      form.submit()
      return true
  }
  function getLog(sId){
      $.ajax({
          url:"getLogs",
          type:"get",
          data:{sid:sId},
          dataType:"json",
          success: function (data) {
              var log_content = "";
              $(data).each(function (index, element) {
                  log_content += "<div class='log-item'>" +
                          " <p class='time'>" + element.formatTime + "：</p> " +
                          "<p class='content'>" + element.logInfo + "</p> </div>";
              })
              $("#log_content").html(log_content)
              $("#log").modal("show")
          }
      })
  }
</script>
</body>
</html>
