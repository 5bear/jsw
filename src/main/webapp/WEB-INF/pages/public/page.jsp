<%--
  Created by IntelliJ IDEA.
  User: ZhanShaoxiong
  Date: 2016/5/2
  Time: 20:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  int totalPage=(Integer) request.getAttribute("totalPage");
  int currentPage=(Integer) request.getAttribute("currentPage");
  int lastPage=1;
  int nextPage=currentPage+1;
  String url=request.getParameter("url");
  System.out.print(url);
%>
<div class="row text-right">
  <nav>
  <ul class="pagination">
    <%
      if(currentPage>1)
        lastPage=currentPage-1;
    %>
    <li><a href="<%=url%>pn=<%=lastPage%>"><span><</span></a></li>
    <%
      for(int i=1;i<=totalPage;i++){
        if(i==currentPage){
    %>
    <li class="active"><a href="<%=url%>pn=<%=currentPage%>"><%=currentPage%></a></li>
    <%
    }
      else{
    %>
    <li><a href="<%=url%>pn=<%=i%>"><%=i%></a></li>
    <%
        }
      }
    %>
    <%
      if(nextPage>totalPage)
        nextPage=totalPage;
    %>
    <li><a href="<%=url%>pn=<%=nextPage%>"><span>></span></a></li>
  </ul>
    </nav>
</div>
