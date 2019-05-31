<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_all.jsp" %> 
<jsp:useBean id="dao" class="bbs.BbsDAO"></jsp:useBean>

<%
   int bbsno = Integer.parseInt(request.getParameter("bbsno")); //list.jsp의 url에서 넘겨준 값 받기 위함
   BbsDTO dto = dao.read(bbsno);
   
%>
<!DOCTYPE html> 
<html> 
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  
  <script type="text/javascript">
    function listM(){
      var url = "list.jsp";
      
      url += "?col=<%=request.getParameter("col")%>";
      url += "&word=<%=request.getParameter("word")%>";
      url += "&nowPage=<%=request.getParameter("nowPage")%>";
      
      location.href = url;
    }
    
    function updateM(bbsno){
      var url = "updateform.jsp";
      // url += "?bbsno=" + <=dto.getBbsno()%>; 와 동일!
      url += "?bbsno=<%=dto.getBbsno()%>";
      
      url += "&col=<%=request.getParameter("col")%>";
      url += "&word=<%=request.getParameter("word")%>";
      url += "&nowPage=<%=request.getParameter("nowPage")%>";
      
      location.href = url;
    }

    function deleteM(bbsno){
      var url = "deleteform.jsp";
      url += "?bbsno=<%=dto.getBbsno()%>";
      
      // 이것을 안 하면 목록으로 돌아갈때 오류가 나더라.. 못 불러 오더라..
      url += "&col=<%=request.getParameter("col")%>";
      url += "&word=<%=request.getParameter("word")%>";
      url += "&nowPage=<%=request.getParameter("nowPage")%>";
      
      location.href = url;
    }

    function replyM(bbsno){
      var url = "replyform.jsp";
      url += "?bbsno=<%=dto.getBbsno()%>";
      location.href = url;
    }
    
  </script>
  
</head>
<body> 

<jsp:include page="/menu/top.jsp" />
<div class="container">
  <h1>방명록 내용</h1>
  <div class="panel panel-default">
    <div class="panel-heading">번호</div>
    <div class="panel-body"><%=dto.getBbsno() %></div>
    <div class="panel-heading">이름</div>
    <div class="panel-body"><%=dto.getWname() %></div>
    <div class="panel-heading">내용</div>
    <div class="panel-body"><%=dto.getContent() %></div>
    <div class="panel-heading">조회수</div>
    <div class="panel-body"><%=dto.getViewcnt() %></div>
    <div class="panel-heading">날짜</div>
    <div class="panel-body"><%=dto.getWdate() %></div>
  </div>
  
  <button class="btn" type="button" onclick="location.href='createform.jsp'">등록</button>
  <button class="btn" type="button" onclick="updateM()">수정</button>
  <button class="btn" type="button" onclick="deleteM()">삭제</button>
  <button class="btn" type="button" onclick="replyM()">답변</button>  
  <button class="btn" type="button" onclick="listM()">목록</button>
</div>

</body> 
</html>