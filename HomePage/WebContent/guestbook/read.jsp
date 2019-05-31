<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_all.jsp" %> 
<jsp:useBean id="dao" class="guestbook.GuestbookDAO" />
<%
    int no = Integer.parseInt(request.getParameter("no"));  //number값을 읽어오기 위해 request.getParameter를 통해 가져왔고,
    GuestbookDTO dto = dao.read(no);  //dao연결
    String content = dto.getContent().replaceAll("\r\n", "<br>");
%>
 
<!DOCTYPE html> 
<html> 
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">
    function update(no){
      var url = "updateform.jsp";
      url += "?no="+<%=dto.getNo()%>;
      // url += "?bbsno=" + <=dto.getBbsno()%>; 와 동일!
      location.href = url;
    }

    function del(no){
      var url = "deleteproc.jsp";
      url += "?no="+<%=dto.getNo()%>;
      location.href = url;
    }

    function reply(no){
      var url = "replyform.jsp";
      url += "?no="+<%=dto.getNo()%>;
      location.href = url;
    }
    
  </script>

</head>
<body>

<jsp:include page="/menu/top.jsp" />

<div class="container">
  <h2>방명록 내용</h2>
  <div class="panel panel-default">
       <div class="panel-heading">번호</div>
       <div class="panel-body"><%=dto.getNo() %></div>
       <div class="panel-heading">이름</div>
       <div class="panel-body"><%=dto.getGender() %></div>
       <div class="panel-heading">성별</div>
       <div class="panel-body"><%=dto.getGender() %></div>
       <div class="panel-heading">제목</div>
       <div class="panel-body"><%=dto.getTitle() %></div>
       <div class="panel-heading">내용</div>
       <div class="panel-body"><%=dto.getContent() %></div>
       <div class="panel-heading">날짜</div>
       <div class="panel-body"><%=dto.getRegdate() %></div>
       <div class="panel-heading">분야</div>
       <div class="panel-body"><%=dto.getPartstr() %></div>
 
  </div>
  <button class="btn" type="button" onclick="location.href='createform.jsp'">등록</button>
  <button class="btn" type="button" onclick="update()">수정</button>
  <button class="btn" type="button" onclick="del()">삭제</button>
  <button class="btn" type="button" onclick="reply()">답변</button>  
  <button class="btn" type="button" onclick="location.href='list.jsp'">목록</button>
  
</div>
</body> 
</html> 
