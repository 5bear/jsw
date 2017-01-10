<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 22:55
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
    <jsp:param name="pageName" value="CourseManage"></jsp:param>
  </jsp:include>

  <div id="page-wrapper">
    <div id="label-section">
      <div class="row">
        <div class="col-lg-6 col-lg-offset-1 col-md-6 col-md-offset-1 time-row">
          <a href="javascript:history.back();" class="operation"><< 返回</a>
        </div>
        <div class="col-lg-6 col-lg-offset-1 col-md-6 col-md-offset-1">
          <table class="table vertical-table">
            <tbody v-cloak>
            <tr>
              <td>案例名称</td>
              <td><input type="text" class="table-input"/></td>
            </tr>
            <tr>
              <td>案例背景</td>
              <td class="label-td">
                <a v-for="background in backgrounds" class="btn btn-danger" data-field="category" onclick="deleteBG(this)"> <span class="js-cate-content"><span>{{ background.title }}</span>-<span>{{ background.sub }}</span></span> <span class="glyphicon glyphicon-remove"></span></a>
              </td>
            </tr>
            <tr>
              <td>案例分类</td>
              <td>
                <a v-for="sort in sorts" class="btn btn-danger" data-field="category" onclick="deleteSort(this)"> <span class="js-cate-content"><span>{{ sort.title }}</span>-<span>{{ sort.sub }}</span></span> <span class="glyphicon glyphicon-remove"></span></a>
              </td>
            </tr>
            <tr>
              <td>案例标签<p>以顿号(、)连接</p></td>
              <td><input type="text" class="table-input"/></td>
            </tr>
            <tr>
              <td>上传案例</td>
              <td><input type="file"/></td>
            </tr>
            </tbody>
          </table>
          <div class="row">
            <div class="col-lg-4 col-lg-offset-3 col-md-4 col-md-offset-3 col-sm-4 col-sm-offset-3">
              <button class="btn btn-default" data-toggle="modal" data-target="#delete">回复</button>
              <button class="btn btn-default">取消</button>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-md-4" style="height: 600px; overflow-y: auto">
          <div>
            <ul class="nav nav-tabs" role="tablist">
              <li role="presentation" class="active"><a href="#background" aria-controls="background" role="tab" data-toggle="tab">案例背景</a></li>
              <li role="presentation"><a href="#sort" aria-controls="sort" role="tab" data-toggle="tab">案例分类</a></li>
            </ul>

            <div class="tab-content">
              <div role="tabpanel" class="tab-pane fade active in" id="background">
                <div class="tree">
                  <ul>
                    <li>
                      <label>案例背景</label>
                      <ul class="main-tree" id="background-case">
                      </ul>
                    </li>
                  </ul>
                </div>
              </div>
              <div role="tabpanel" class="tab-pane fade" id="sort">
                <div class="tree">
                  <ul>
                    <li>
                      <label>国际汉语教育案例库</label>
                      <ul class="main-tree" id="sort-case">
                      </ul>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">回复提示</h4>
            </div>
            <div class="modal-body text-center">
              <p>回复成功</p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div><!-- /.modal -->
    </div>
  </div><!-- /#page-wrapper -->

</div><!-- /#wrapper -->

<!-- JavaScript -->
<jsp:include page="../public/backFooter.jsp"></jsp:include>
</body>
</html>
