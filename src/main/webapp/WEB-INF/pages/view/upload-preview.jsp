<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/10/17
  Time: 14:54
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
    <div class="upload-section preview-section">
        <div class="info-table">
            <a href="../html/user-index.html" class="back">< 返回</a>
            <h1>案例查看</h1>
            <div>
                <span>案例名称</span>
                <span><input type="text" class="table-input" readonly/></span>
            </div>
            <div>
                <span>案例分类</span>
                <span><input type="text" class="table-input" readonly/></span>
            </div>
            <div>
                <span>二级分类</span>
                <span><input type="text" class="table-input" readonly/></span>
            </div>
            <div>
                <span>案例标签</span>
                <span><textarea type="text" class="table-input" readonly></textarea></span>
            </div>
            <div>
                <span>上传案例</span>
                <span>
                        <a href="../html/live-preview.html" class="btn btn-default">预览</a>
                        <input type="text" class="table-input file-name" readonly/>
                    </span>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../public/viewFooter.jsp"></jsp:include>

<script>
    var data;

    $.getJSON("../json/sort.json", function(json) {
        data = json;
        var temp = "";
        for (var i in data) {
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
                    temp += "<option>" + sub[j] + "</option>";
                }
                $("#subSort").empty();
                $("#subSort").append(temp);
                break;
            }
        }
    }

    $('.js-upload-file').on('click', function() {
        $('.upload-file').click();
    })

    $('.upload-file').on('change', function() {
        $('.file-name').val($('.upload-file').val());
    })


</script>
</body>
</html>
