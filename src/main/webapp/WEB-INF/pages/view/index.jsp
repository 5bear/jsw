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
  <jsp:param name="pageName" value="index"></jsp:param>
</jsp:include>
<body>
<jsp:include page="../public/viewNavi.jsp"></jsp:include>
<div class="wrapper">
  <div class="slide">
    <div id="slide" class="slideBox">
      <ul class="items">
        <li><a href="#" title="全球汉语教师网1"><img src="<%=request.getContextPath()%>/images/slide-img.png"></a></li>
        <li><a href="#" title="全球汉语教师网2"><img src="<%=request.getContextPath()%>/images/slide-img.png"></a></li>
        <li><a href="#" title="全球汉语教师网3"><img src="<%=request.getContextPath()%>/images/slide-img.png"></a></li>
      </ul>
    </div>
  </div>
  <div class="content">
    <h1 class="top-title">最新资讯</h1>
    <div class="content-left">
      <div class="top-section">
        <div class="section-time">
          <p class="time-large">20</p>
          <p>July</p>
        </div>
        <div class="section-title">
          <p class="title-top">全球视野下的教育者123456789123456789</p>
          <p class="title-bottom">Sunday | 9:30am</p>
        </div>
        <div class="section-button"><button class="btn">MORE</button></div>
        <div class="clearboth"></div>
      </div>
      <div class="top-section">
        <div class="section-time">
          <p class="time-large">20</p>
          <p>July</p>
        </div>
        <div class="section-title">
          <p class="title-top">全球视野下的教育者123456789123456789</p>
          <p class="title-bottom">Sunday | 9:30am</p>
        </div>
        <div class="section-button"><button class="btn">MORE</button></div>
        <div class="clearboth"></div>
      </div>
      <div class="top-section">
        <div class="section-time">
          <p class="time-large">20</p>
          <p>July</p>
        </div>
        <div class="section-title">
          <p class="title-top">全球视野下的教育者</p>
          <p class="title-bottom">Sunday | 9:30am</p>
        </div>
        <div class="section-button"><button class="btn">MORE</button></div>
        <div class="clearboth"></div>
      </div>
      <div class="case-section">
        <div class="case-section-left"><img src="<%=request.getContextPath()%>/images/left-page.png" alt="左页" class="page"/></div>
        <div class="case-section-center">
          <div class="small-case">
            <img src="<%=request.getContextPath()%>/images/case1.png" alt="图片"/>
            <div class="blue-tool">
              <span>精彩案例</span>
              <a href="#"><img src="<%=request.getContextPath()%>/images/arrow.png" alt="进入"/></a>
            </div>
            <div class="case-info">
              <p>人文讲座</p>
              <p>2016</p>
              <p>03－18</p>
              <p>DORA E.ANGELAKI院士中山北路理科大楼A510</p>
              <a href="#"><img src="<%=request.getContextPath()%>/images/Plus.png" alt="增加"/></a>
              <a href="#"><img src="<%=request.getContextPath()%>/images/Heart.png" alt="喜欢"/></a>
            </div>
          </div>
          <div class="small-case">
            <img src="<%=request.getContextPath()%>/images/case2.png" alt="图片"/>
            <div class="case-info">
              <p>人文讲座</p>
              <p>2016</p>
              <p>03－18</p>
              <p>DORA E.ANGELAKI院士中山北路理科大楼A510</p>
              <a href="#"><img src="<%=request.getContextPath()%>/images/Plus.png" alt="增加"/></a>
              <a href="#"><img src="<%=request.getContextPath()%>/images/Heart.png" alt="喜欢"/></a>
            </div>
          </div>
          <div class="small-case">
            <img src="<%=request.getContextPath()%>/images/case2.png" alt="图片"/>
            <div class="case-info">
              <p>人文讲座</p>
              <p>2016</p>
              <p>03－18</p>
              <p>DORA E.ANGELAKI院士中山北路理科大楼A510</p>
              <a href="#"><img src="<%=request.getContextPath()%>/images/Plus.png" alt="增加"/></a>
              <a href="#"><img src="<%=request.getContextPath()%>/images/Heart.png" alt="喜欢"/></a>
            </div>
          </div>
          <div class="small-case">
            <img src="<%=request.getContextPath()%>/images/case2.png" alt="图片"/>
            <div class="case-info">
              <p>人文讲座</p>
              <p>2016</p>
              <p>03－18</p>
              <p>DORA E.ANGELAKI院士中山北路理科大楼A510</p>
              <a href="#"><img src="<%=request.getContextPath()%>/images/Plus.png" alt="增加"/></a>
              <a href="#"><img src="<%=request.getContextPath()%>/images/Heart.png" alt="喜欢"/></a>
            </div>
          </div>
        </div>
        <div class="case-section-right"><img src="<%=request.getContextPath()%>/images/right-page.png" alt="右页" class="page"/></div>
        <div class="clearboth"></div>
      </div>
    </div>
    <div class="content-right">
      <div class="right-section">
        <div class="small-course">
          <img src="<%=request.getContextPath()%>/images/case3.png" alt="图片"/>
          <div class="green-tool">
            <span>在线课程</span>
            <a href="#"><img src="<%=request.getContextPath()%>/images/arrow.png" alt="进入"/></a>
          </div>
          <div class="case-info">
            <p>人文讲座</p>
            <p>2016</p>
            <p>03－18</p>
            <p>DORA E.ANGELAKI院士中山北路理科大楼A510</p>
          </div>
        </div>
        <p>www.quanqiuhaiyu.com</p>
        <div class="small-course">
          <img src="<%=request.getContextPath()%>/images/case4.png" alt="图片"/>
          <div class="case-info">
            <p>人文讲座</p>
            <p>2016</p>
            <p>03－18</p>
            <p>DORA E.ANGELAKI院士中山北路理科大楼A510</p>
          </div>
        </div>
        <p>www.quanqiuhaiyu.com</p>
        <div class="small-course">
          <img src="<%=request.getContextPath()%>/images/case5.png" alt="图片"/>
          <div class="case-info">
            <p>人文讲座</p>
            <p>2016</p>
            <p>03－18</p>
            <p>DORA E.ANGELAKI院士中山北路理科大楼A510</p>
          </div>
        </div>
        <p>www.quanqiuhaiyu.com</p>
        <div class="clearboth"></div>
      </div>
    </div>
    <div class="clearboth"></div>
  </div>
</div>
<jsp:include page="../public/viewFooter.jsp"></jsp:include>
<script>
  jQuery(function($){
    $('#slide').slideBox({
      duration : 0.3,//滚动持续时间，单位：秒
      easing : 'linear',//swing,linear//滚动特效
      delay : 4,//滚动延迟时间，单位：秒
      hideClickBar : false,//不自动隐藏点选按键
      clickBarRadius : 10
    });
  });
</script>
</body>
</html>
