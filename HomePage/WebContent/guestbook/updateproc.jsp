<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_all.jsp" %>
<jsp:useBean id="dao" class="guestbook.GuestbookDAO" />
<jsp:useBean id="dto" class="guestbook.GuestbookDTO" />
<jsp:setProperty name="dto" property="*"/>
<% 
   boolean flag = dao.update(dto);
%>
<!DOCTYPE html> 
<html> 
<head>
  <title>블로그 수정</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  
</head>
<body> 

<div class="container">
  <fieldset>
    <legend>블로그 수정</legend>
    <%
      if(flag){
        out.print("블로그 수정에 성공했습니다.");
      }else{
        out.print("블로그 수정에 실패했습니다.");
      }
    %>
  </fieldset>
  <button type="button" class="btn" onclick="location.href='./createform.jsp'">다시등록</button> 
  <button type="button" class="btn" onclick="location.href='./list.jsp'">목록</button>
  
  <!--link는 ./18createform.jsp이지만,
  onclick의 경우 javascript가 와야하기 때문에 loaction.href=라는 코드가 필요하다!-->
</div>

</body> 
</html> 