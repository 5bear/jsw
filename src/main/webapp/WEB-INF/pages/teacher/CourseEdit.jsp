<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/7/23
  Time: 17:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<jsp:include page="../public/backHead.jsp"></jsp:include>

<body>

<div id="wrapper">

  <!-- Sidebar -->
  <jsp:include page="../public/teacherNavi.jsp">
    <jsp:param name="pageName" value="CourseMaintain"></jsp:param>
  </jsp:include>

  <div id="page-wrapper">

    <div id="label-section">
      <div class="row">
        <div class="col-lg-12 time-row">
          <a href="javascript:history.back();" class="operation"><< 返回</a>
        </div>
        <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3">
          <form accept-charset="utf-8" name="myForm" action="" method="post" enctype="multipart/form-data">
            <input type="text" hidden="hidden"  name="sId" value="${slide.sId}"/>
            <table class="table vertical-table">
              <tbody v-cloak>
              <tr>
                <td>案例名称</td>
                <td><input type="text" id="title" class="table-input" name="title" value="${slide.title}"/></td>
              </tr>
              <tr>
                <td>案例分类</td>
                <td>
                  <select name="type" id="sort"  class="table-input">
                  </select>
                </td>
              </tr>
              <tr>
                <td>二级分类(可选)</td>
                <td>
                  <select name="secondtype" id="subSort" class="table-input"></select>
                </td>
              </tr>
              <tr>
                <td>案例标签<p>以顿号(、)连接</p></td>
                <td><input type="text" name="tTag" class="table-input" value="${slide.tTag}"/></td>
              </tr>
              <tr>
                <td>案例描述</td>
                <td>
                  <textarea name="description" placeholder="请输入50字到100字的案例描述，可以从国别地区，入库时间，教学时间，教学地点，课堂规模，教学手段，年龄层次，汉语水平，专业背景，家庭背景，宗教背景等方面进行叙述。" maxlength="100">${slide.description}</textarea>
                </td>
              </tr>
              <tr>
                <td>案例预览图</td>
                <td><input type="file" name="previewPic" accept="image/*" multiple onchange="preview(this)"/><div id="preview"><c:forEach items="${slidePics}" var="pic">
                  <img width="300px" height="180px" src="${pic.picPath}">
                </c:forEach></div></td>
              </tr>
              <tr>
                <td>上传案例</td>
                <td><a href="<%=request.getContextPath()%>/${slide.filePath}" target="_self">${slide.fileName}</a><input type="file"id="file"name="file" accept="application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.openxmlformats-officedocument.presentationml.presentation,application/pdf,application/vnd.ms-powerpoint,application/vnd.ms-powerpoint,application/vnd.ms-powerpoint"/></td>
              </tr>
              </tbody>
            </table>
            <div class="row">
              <div class="col-lg-6 col-lg-offset-3 col-md-4 col-md-offset-3 col-sm-4 col-sm-offset-3">
                <button class="btn btn-default" type="button" onclick="checkForm()">提交</button>
              </div>
            </div>
          </form>
        </div>
      </div>


    </div>


  </div><!-- /#wrapper -->

  <!-- JavaScript -->
  <jsp:include page="../public/backFooter.jsp"></jsp:include>
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
          temp += "<option></option>";
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
    function preview(file)
    {
      var prevDiv = $("#preview")
      prevDiv.empty()
      if (file.files)
      {
        if(file.files[0]){
          var reader = new FileReader();
          reader.onload = function(evt){
            prevDiv.append( '<img width="300px" height="180px" src="' + evt.target.result + '" />')
          }
          reader.readAsDataURL(file.files[0]);
        }
        else
        {
          prevDiv.append( '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>')
        }
        if(file.files[1]){
          var reader = new FileReader();
          reader.onload = function(evt){
            prevDiv.append( '<img width="300px" height="180px" src="' + evt.target.result + '" />')
          }
          reader.readAsDataURL(file.files[1]);
        }
        else
        {
          prevDiv.append( '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>')
        }
      }

    }
    function checkForm(){
      var title=$("#title").val()
      if(title==""){
        alert("案例名不能为空")
        return false
      }
      var file=document.getElementById("file")
      if(!file.files){
        alert("请选择案例")
        return false
      }
      var myform=document.getElementsByName("myForm")[0]
      myform.submit()
    }
  </script>
</body>
</html>

