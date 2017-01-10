<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 11369
  Date: 2016/6/20
  Time: 23:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../public/viewHead.jsp">
  <jsp:param name="pageName" value="case"></jsp:param>
</jsp:include>
<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
    <div class="case-info">
        <h2 class="case-info-title">
           ${slide.title}
        </h2>
        <div class="upload-info">
            <div class="upload-teacher-info text-center">
                <a href="<%=request.getContextPath()%>/Teacher/${slide.teacher.aId}"><img class="teacher-head-sm" src="<%=request.getContextPath()%>/${slide.teacher.headPath}" alt="头像"/></a>
                <a href="<%=request.getContextPath()%>/Teacher/${slide.teacher.aId}"><p>${slide.teacher.nickName}</p></a>
            </div>
            <div class="eye">
                <span class="love"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞"/><span id="zan2">${slide.zanCount}</span></span>
                <span class="click"><img src="<%=request.getContextPath()%>/images/eye2.png" alt="查看"/>${slide.viewCount}</span>
            </div>
            <div class="download">
                <a href="#" onclick="down('${slide.sId}','${account.aId}')">下载</a>
            </div>
            <div>上传日期：${slide.formatTimestamp}</div>
            <div id="ckepop">
                <span class="jiathis_txt">分享到：</span>
                <a class="jiathis_button_weixin">微信</a>
                <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank">更多</a>
                <a class="jiathis_counter_style"></a>
            </div>
        </div>
       <c:if test="${slide.fileType=='video'}">
           <video width="900" height="500" class="player-box" controls="controls">
               <source src="<%=request.getContextPath()%>/${slide.filePath}" >
           </video>
       </c:if>
        <c:if test="${slide.fileType=='pdf'||slide.fileType=='image'}">
            <iframe class="preview-frame" src = "<%=request.getContextPath()%>/${slide.filePath}" width='950' height='665' allowfullscreen webkitallowfullscreen></iframe>
        </c:if>
        <p class="description">${slide.description}</p>
        <a class="case-operation"><img src="<%=request.getContextPath()%>/images/eye2.png">点击(${slide.viewCount})</a>
        <a class="case-operation"><img src="<%=request.getContextPath()%>/images/like-star.png">收藏(<span id="collect1">${slide.collectCount}</span>)</a><br/>
        <button class="btn btn-default" id="download-btn" onclick="down('${slide.sId}','${account.aId}',${slide.state})"><span class="glyphicon glyphicon-save"></span>下载(${slide.downCount})</button>
        <button class="btn btn-default" onclick="collect('${slide.sId}','${account.aId}',${slide.state})">收藏(<span id="collect2">${slide.collectCount}</span>)</button>
        <div class="row love-row" id="zanAccount">
            <a href="javascript:void(0);" onclick="uZan('${slide.sId}','${account.aId}',${slide.state})"  class="favour-btn"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞" class="teacher-detail-icon"/>点赞（<span id="zan1">${slide.zanCount}</span>）</a>
            <c:forEach items="${accountList}" var="account">
                <img src="<%=request.getContextPath()%>/${account.headPath}" alt="头像"/>
            </c:forEach>
        </div>
    </div>
    <div class="case-label">
        <h3 class="case-sm-title">添加标签</h3>
        <div>
            <div class="case-label-list">
                <c:forEach items="${constTags}" var="tag">
                    <div class="items">
                        <a class="btn btn-success">${tag.utag}</a>
                    </div>
                </c:forEach>
                <div class="clearboth"></div>
            </div>
        </div>
        <div>
            <div class="case-label-list">
                <c:forEach items="${userTags}" var="tag">
                    <div class="items">
                        <a class="btn btn-success">${tag.utag}</a>
                    </div>
                </c:forEach>
                <div class="items">
                    <input type="text" placeholder="请输入标签" id="tag"/>
                </div>
                <div class="add-items">
                    <a class="btn add-items-btn" onclick="addLabel('${slide.sId}')">+</a>
                </div>
                <div class="clearboth"></div>
            </div>
<%--
            <p class="case-label-hint">标签添加成功! 等待后台审核……</p>
--%>
        </div>
    </div>
    <!--<div>-->
    <!--<h3 class="case-sm-title">案例评论</h3>-->
    <!--<div class="case-comment-list">-->
    <!--<div class="case-comment-item">-->
    <!--<div class="left text-center">-->
    <!--<img src="../images/head2.png" class="teacher-head-md" alt="头像"/>-->
    <!--<p class="text-center">李白</p>-->
    <!--</div>-->
    <!--<div class="right">-->
    <!--<p>老师您讲的真好。</p>-->
    <!--<a class="float-right" href="#">删除</a>-->
    <!--</div>-->
    <!--<div class="clearboth"></div>-->
    <!--</div>-->
    <!--<div class="case-comment-item">-->
    <!--<div class="left text-center">-->
    <!--<img src="../images/head3.png" class="teacher-head-md" alt="头像"/>-->
    <!--<p class="text-center">杜甫</p>-->
    <!--</div>-->
    <!--<div class="right">-->
    <!--<p>我还有一点地方不清，这里是怎么回事呢。</p>-->
    <!--<a class="float-right" href="#">删除</a>-->
    <!--</div>-->
    <!--<div class="clearboth"></div>-->
    <!--</div>-->
    <!--<div class="case-comment-item">-->
    <!--<div class="left text-center">-->
    <!--<img src="../images/head4.png" class="teacher-head-md" alt="头像"/>-->
    <!--<p class="text-center">白居易</p>-->
    <!--</div>-->
    <!--<div class="right">-->
    <!--<textarea name="" id=""></textarea>-->
    <!--<a class="float-right" href="#">回复</a>-->
    <!--</div>-->
    <!--<div class="clearboth"></div>-->
    <!--</div>-->
    <!--</div>-->
    <!--</div>-->
    <div class="case-recommend">
        <h3>可能感兴趣的</h3>
        <c:forEach items="${likeList}" var="slide">
            <a href="<%=request.getContextPath()%>/Case?id=${slide.sId}"><div class="panel case-item">
                <div class="panel-heading">
                    <div class="eye">
                        <span class="love"><img src="<%=request.getContextPath()%>/images/good2.png" alt="点赞"/>${slide.zanCount}</span>
                        <span class="click"><img src="<%=request.getContextPath()%>/images/eye2.png" alt="查看"/>${slide.viewCount}</span>
                    </div>
                </div>
                <div class="panel-body">
                    <p class="title">${slide.title}</p>
                    <p class="label">${slide.tTag.replace(',',' ')==""?"&nbsp":slide.tTag.replace(',',' ')}</p>
                </div>
                <div class="panel-footer">
                    <img class="float-left teacher-head-sm" src="<%=request.getContextPath()%>/${slide.teacher.headPath}" alt="头像"/>
                    <span>${slide.teacher.nickName}</span>
                    <span class="float-right">上传日期：${slide.formatTimestamp}</span>
                </div>
            </div>
            </a>
        </c:forEach>
        <div class="clearboth"></div>
    </div>
</div>

<jsp:include page="../public/viewFooter.jsp"></jsp:include>
<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jia.js?uid=1337866939353544" charset="utf-8"></script>
<script>
  var zanCount=${slide.zanCount}
  var collectCount=${slide.collectCount}
  function uZan(sid,aid,status){
      if(status<5){
          alert("审核状态，无法操作")
          return false
      }
    if(aid==undefined||aid==""){
      alert("请先登录")
      return false
    }
    $.ajax({
      url:"<%=request.getContextPath()%>/Zan",
      type:"post",
      data:{sId:sid,aId:aid},
      success: function (data) {
        if(data=="success"){
            ++zanCount
          $("#zan1").html(zanCount<0?0:zanCount)
            $("#zan2").html(zanCount<0?0:zanCount)
          var zanAccount=document.getElementById("zanAccount")
          var img=document.createElement("img");
          img.src="<%=request.getContextPath()%>/${account.headPath}";
          zanAccount.appendChild(img)
        }else{
        --zanCount
            $("#zan1").html(zanCount<0?0:zanCount)
            $("#zan2").html(zanCount<0?0:zanCount)
          var zanAccount=document.getElementById("zanAccount")
          var nodes=zanAccount.getElementsByTagName("img")
          zanAccount.removeChild(nodes[nodes.length-1])
        }
      }
    })
  }
  function collect(sid,aid,status){
      if(status<5){
          alert("审核状态，无法操作")
          return false
      }
    if(aid==undefined||aid==""){
      alert("请先登录")
      return false
    }
    $.ajax({
      url:"<%=request.getContextPath()%>/Collect",
      type:"post",
      data:{sId:sid,aId:aid},
      success: function (data) {
        if(data=="success"){
            ++collectCount
         $("#collect1").html(collectCount<0?0:collectCount)
            $("#collect2").html(collectCount<0?0:collectCount)
        }else{
            --collectCount
            $("#collect1").html(collectCount<0?0:collectCount)
            $("#collect2").html(collectCount<0?0:collectCount)

        }
      }
    })
  }
  function down(sid,aid,status){
      if(status<5){
          alert("审核状态，无法操作")
          return false
      }
    if(aid==undefined||aid==""){
      alert("请先登录")
      return false
    }
    $.ajax({
      url:"<%=request.getContextPath()%>/Down",
      type:"post",
      data:{sId:sid,aId:aid},
      success: function (data) {
        $("#down").html('${slide.downCount+1}')
        window.open(data)
      }
    })
  }
  function  addLabel(sid) {
      var tag=$("#tag").val()
      $.ajax({
          url:"<%=request.getContextPath()%>/addTag",
          type:"post",
          data:{slide:sid,t:tag},
          success: function (data) {
              $("#tag").val("")
              alert(data)
          }
      })
  }
  function checkTag(){
    var tag=document.getElementById("tag")
    if(tag.value==""){
      alert("输入不能为空")
      return false
    }
    return true
  }
</script>
</body>
</html>
