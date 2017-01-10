<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/10/25
  Time: 13:57
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
    <form accept-charset="utf-8" name="myForm" action="<%=request.getContextPath()%>/CourseEdit" method="post" enctype="multipart/form-data">
        <div class="upload-section">
            <div class="info-table">
                <a href="<%=request.getContextPath()%>/MySlide" class="back">< 返回</a>
                <input type="text" hidden="hidden"  name="sId" value="${slide.sId}"/>
                <h1>上传案例</h1>
                <div>
                    <span>案例名称</span>
                    <span><input type="text" name="title" value="${slide.title}" id="title" class="table-input"/></span>
                </div>
                <div>
                    <span>案例分类(必填)</span>
                    <span>
                        <select class="form-control"  name="type" id="sort"></select>
                    </span>
                </div>
                <div>
                    <span>二级分类(可选)</span>
                    <span>
                        <select class="form-control" name="secondtype" id="subSort"></select>
                    </span>
                </div>
                <div>
                    <span>案例标签<br/>任意标点符号分隔</span>
                    <span><textarea type="text" name="tTag" class="table-input">${slide.tTag}</textarea></span>
                </div>
                <div>
                    <span>案例描述</span>
                    <span><textarea type="text" name="description" class="table-input">${slide.description}</textarea></span>
                </div>
                <div>
                    <span>上传预览图</span>
                    <span>
                        <button class="btn btn-default js-upload-image" type="button">上传</button>
                        <p class="image-name"></p>
                        <input type="file" name="previewPic" class="upload-image"/>
                         <c:forEach items="${slidePics}" var="pic">
                             <img class="preview-img" src="<%=request.getContextPath()%>/${pic.picPath}" alt="预览图片">
                         </c:forEach>
                    </span>
                </div>
                <div>
                    <span>上传案例</span>
                    <span>
                        <button class="btn btn-default js-upload-file" type="button">上传</button>
                        <a class="to-preview" href="<%=request.getContextPath()%>/Preview/${slide.sId}"><p class="file-name">${slide.fileName}</p></a>
                        <input type="file" id="file" name="file" class="upload-file"/>
                    </span>
                </div>
                <input name="flag" id="flag" hidden>
                <%--<p class="text-center alert-red">请填写所有必填的选项</p>--%>
            </div>

            <div class="row btn-row">
                <div class="text-center">
                    <button class="btn btn-default" type="button" onclick="checkForm()">提交</button>
                    <button class="btn btn-default" type="button" onclick="javascript:location.reload(true)">取消</button>
                </div>
            </div>
        </div>
    </form>
</div>

<jsp:include page="../public/viewFooter.jsp"></jsp:include>

<script>
    var data;

    $.getJSON("<%=request.getContextPath()%>/json/sort.json", function(json) {
        data = json;
        var temp = "";
        for (var i in data) {
            if(i=="${slide.type}")
                temp += "<option selected value='" + i + "'>" + i + "</option>";
            else
                temp += "<option value='" + i + "'>" + i + "</option>";
        }
        $("#sort").append(temp);
        var obj = $("#sort option:selected").text();
        selectSubSort(obj);
    })

    $("#sort").change(function(){
        var obj = $("#sort option:selected").text();
        selectSubSort(obj);
    });

    function selectSubSort(obj) {
        var sub, temp;
        for (var i in data) {
            if (i == obj) {
                sub = data[i];
                temp += "<option>(全部)</option>";
                for (var j in sub) {
                    if(sub[j]=="${slide.secondtype}")
                        temp += "<option selected>" + sub[j] + "</option>";
                    else
                        temp += "<option>" + sub[j] + "</option>";
                }
                $("#subSort").empty();
                $("#subSort").append(temp);
                break;
            }
        }
    }

    $(function() {
        if ($('.file-name').text()) {
            $('.to-preview').show();
        }
    });
    $('.js-upload-file').on('click', function() {
        $('.upload-file').click();
    });

    $('.upload-file').on('change', function() {
        $('.file-name').text($('.upload-file').val());
        $('.to-preview').show();
    });

    $('.js-upload-image').on('click', function() {
        $('.upload-image').click();
    })

    $('.upload-image').on('change', function() {
        $('.image-name').text($('.upload-image').val());
    })
    function checkForm(){
        var title=$("#title").val()
        if(title==""){
            alert("案例名不能为空")
            return false
        }
       /* var file=document.getElementById("file")
        if(!file.files){
            alert("请选择案例")
            return false
        }*/
        var myform=document.getElementsByName("myForm")[0]
        myform.submit()
    }

</script>
</body>
</html>
