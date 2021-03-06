<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/10/17
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int totalPage= (Integer) request.getAttribute("totalPage");
    int currentPage= (Integer) request.getAttribute("currentPage");
    Integer status= (Integer) request.getAttribute("status");
    if(status==null)
        status=0;
    String si= (String) request.getAttribute("si")==null?"":(String) request.getAttribute("si");
    String url=status==null?request.getContextPath()+"/MySlide?":request.getContextPath()+"/MySlide?status="+status+"&&si="+si+"&&";
%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/viewHead.jsp">
    <jsp:param name="pageName" value="teacher-list"></jsp:param>
</jsp:include>

<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
    <div id="page-wrapper">
        <form action="" method="get">
        <div class="row course-status">
            <a href="javascript:history.back(-1)" class="back">< 返回</a>
            <input type="text" name="si" class="search" placeholder="搜索"/>
            <label for="status">状态: </label>
            <select class="form-control" name="status" id="status">
                <option value="0" <%=status==0?"selected":""%>>全部案例</option>
                <option value="5" <%=status==5?"selected":""%>>审核通过</option>
                <option value="6" <%=status==6?"selected":""%>>退回修改</option>
                <option value="4" <%=status==4?"selected":""%>>拒绝录用</option>
                <option value="3" <%=status==3?"selected":""%>>正在编审</option>
                <option value="2" <%=status==2?"selected":""%>>提交待审</option>
                <option value="1" <%=status==1?"selected":""%>>我的草稿</option>
            </select>
            <button class="btn btn-default" type="submit">搜索</button>
        </div>
        </form>
        <div class="row table-row">
            <table class="table course-table">
                <thead>
                <tr>
                    <th>案例名称</th>
                    <th style="width: 105px;">案例分类</th>
                    <th>二级分类</th>
                    <th>案例标签</th>
                   <%-- <th>管理员标签</th>
                    <th>用户标签</th>--%>
                    <th>上传文件</th>
                    <th>上传时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="slide">
                    <tr>
                        <td class=""><a href="<%=request.getContextPath()%>/Case?id=${slide.sId}" target="_blank">${slide.title}</a>
                        </td>
                        <td>${slide.type}</td>
                        <td>${slide.secondtype}</td>
                        <td>${slide.tTag}</td>
                       <%-- <td>${slide.aTag}</td>
                        <td>${slide.uTag}</td>--%>
                        <td><a class="course-preview" href="<%=request.getContextPath()%>/${slide.filePath}">${slide.fileName}</a></td>
                        <td>${slide.formatTimestamp}</td>
                        <td class="passed"><script>
                            if('${slide.state}'=="1"){
                                document.write("我的草稿")
                            }else if('${slide.state}'=="2"){
                                document.write("提交待审")
                            }else if('${slide.state}'=="3"){
                                document.write("正在编审")
                            }else if('${slide.state}'=="4"){
                                document.write("拒绝录用")
                            }else if('${slide.state}'=="5"){
                                document.write("审核通过")
                            }else if('${slide.state}'=="6"){
                                document.write("退回修改"+"<a href='#' data-toggle='modal' data-target='#refuse${slide.sId}'>(原因)</a>")
                            }
                        </script></td>
                        <div class="modal fade" id="delete${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                                        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="deleteSlide(${slide.sId})">确定</button>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div><!-- /.modal -->


                        <c:choose>
                            <c:when test="${slide.state==1}">
                                <td style="max-width: 170px;">
                                    <a href="<%=request.getContextPath()%>/EditCourse/${slide.sId}">编辑</a>
                                    <a href="#" onclick="changeStatus(2,'${slide.sId}')">提交</a>
                                    <a href="#" data-toggle="modal" data-target="#delete${slide.sId}">删除</a>
                                    <a href="javascript:getLog(${slide.sId})">历史记录</a>
                                </td>
                            </c:when>
                            <c:when test="${slide.state==2}">
                                <td style="max-width: 170px;">
                                    <a href="<%=request.getContextPath()%>/EditCourse/${slide.sId}">查看</a>
                                    <a href="#" data-toggle="modal" data-target="#delete${slide.sId}">删除</a>
                                    <a href="javascript:getLog(${slide.sId})">历史记录</a>
                                </td>
                            </c:when>
                            <c:when test="${slide.state==3}">
                                <td style="max-width: 170px;">
                                    <a href="<%=request.getContextPath()%>/EditCourse/${slide.sId}">查看</a>
                                    <a href="#" onclick="deleteSlide('${slide.sId}')">删除</a>
                                    <a href="javascript:getLog(${slide.sId})">历史记录</a>
                                </td>
                            </c:when>
                            <c:when test="${slide.state==4}">
                                <td style="max-width: 170px;">
                                    <a href="<%=request.getContextPath()%>/EditCourse/${slide.sId}">查看</a>
                                    <a href="#" data-toggle="modal" data-target="#delete${slide.sId}">删除</a>
                                    <a href="javascript:getLog(${slide.sId})">历史记录</a>
                                </td>
                            </c:when>
                            <c:when test="${slide.state==5}">
                                <td style="max-width: 170px;">
                                    <a href="<%=request.getContextPath()%>/EditCourse/${slide.sId}">查看</a>
                                    <a href="#" onclick="deleteSlide('${slide.sId}')">删除</a>
                                    <a href="javascript:getLog(${slide.sId})">历史记录</a>
                                </td>
                            </c:when>
                            <c:when test="${slide.state==6}">
                                <td style="max-width: 170px;">
                                    <a href="<%=request.getContextPath()%>/EditCourse/${slide.sId}">编辑</a>
                                    <a href="#" onclick="changeStatus(2,'${slide.sId}')">提交</a>
                                    <a href="#" data-toggle="modal" data-target="#delete${slide.sId}">删除</a>
                                    <a href="javascript:getLog(${slide.sId})">历史记录</a>
                                </td>
                            </c:when>
                        </c:choose>
                        <div class="modal fade btn-modal" id="refuse${slide.sId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title">退回意见</h4>
                                    </div>
                                    <div class="modal-body text-center">
                                        <p>${slide.opinion}</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div><!-- /.modal -->
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <jsp:include page="../public/page.jsp">
            <jsp:param name="url" value="<%=url%>"></jsp:param>
            <jsp:param name="totalPage" value="<%=totalPage%>"></jsp:param>
            <jsp:param name="currentPage" value="<%=currentPage%>"></jsp:param>
        </jsp:include>

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

        <div class="modal fade btn-modal" id="refuse" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">退回意见</h4>
                    </div>
                    <div class="modal-body text-center">
                        <p>这里是退回意见</p>
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
    function deleteSlide(sId) {
        $.ajax({
            url:"deleteSlide",
            type:"post",
            data:{sid:sId},
            success: function (data) {
                if(data=="success")
                    location.reload(true)
                else{
                    alert("删除失败")
                }
            }
        })
    }
    function changeStatus(status,sId){
        var opinion=document.getElementById("opinion"+sId)
        $.ajax({
            url:"filterCourse",
            type:"post",
            data:{status:status,sId:sId,opinion:opinion==undefined?"":opinion.value},
            success: function (data) {
                location.reload(true)
            }
        })
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