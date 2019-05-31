<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_all.jsp" %>
<jsp:useBean id="dao" class="guestbook.GuestbookDAO"></jsp:useBean>
<jsp:useBean id="dto" class="guestbook.GuestbookDTO"></jsp:useBean>
<jsp:setProperty name="dto" property="*" />
<%
   boolean flag = dao.create(dto);
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
  
</head>
<body>

  <div class="container">
    <div class="well well-lg">
      <%
      if(flag){
    	   out.print("방명록을 등록했습니다.");
    	  }else{
    		 out.print("방명록등록이 실패했습니다.");
    	}
      %>  
  </div>
  <br><button type="button" value="계속 등록" onclick="location.href='./createform.jsp'">다시등록</button>
      <button type="button" value="목록" onclick="location.href='./list.jsp'">목록</button>
  </div>
  
</body>
</html>