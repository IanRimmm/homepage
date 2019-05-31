<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_all.jsp" %>
<jsp:useBean id="dao" class="guestbook.GuestbookDAO" />
<%
   int no = Integer.parseInt(request.getParameter("no"));
   GuestbookDTO dto = dao.read(no);
   String part = dto.getPartstr();
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
  <h1 class="col-sm-offset-2 col-sm-10">블로그 수정</h1>
  
  <form class="form-horizontal" method="post" action="updateproc.jsp">
    
    <input type="hidden" name="no" value="<%=dto.getNo() %>">
    <div class="form-group">
      <label class="control-label col-sm-2" for="name">이름</label>
      <div class="col-sm-5">
        <%=dto.getName() %>
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="title">제목</label>
      <div class="col-sm-5">
        <input type="text" class="form-control" id="title" value="<%=dto.getTitle()%>" name="title">
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="content">내용</label>
      <div class="col-sm-5 row-sm-5">
        <textarea rows="5" cols="5" id="content" name="content" class="form-control"></textarea>
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2">여행지</label>
      <div class="col-sm-10">
      <label  class="checkbox-inline">
        <input type="checkbox" name="attractions" value="일본"
        <% if(part.indexOf("일본") != -1) out.print("checked"); %>>일본
      </label>
      <label  class="checkbox-inline">
        <input type="checkbox" name="attractions" value="일본"
        <% if(part.indexOf("중국") != -1) out.print("checked"); %>>중국
      </label>
      <label  class="checkbox-inline">
        <input type="checkbox" name="attractions" value="일본"
        <% if(part.indexOf("미국") != -1) out.print("checked"); %>>미국
      </label>
      <label  class="checkbox-inline">
        <input type="checkbox" name="attractions" value="일본"
        <% if(part.indexOf("영국") != -1) out.print("checked"); %>>영국
      </label>
      <label  class="checkbox-inline">
        <input type="checkbox" name="attractions" value="일본"
        <% if(part.indexOf("독일") != -1) out.print("checked"); %>>독일
      </label>
      <label  class="checkbox-inline">
        <input type="checkbox" name="attractions" value="일본"
        <% if(part.indexOf("기타") != -1) out.print("checked"); %>>기타
      </label>
      </div>
    </div>
    
    <div class="form-group">
    <div class="col-sm-offset-2 col-sm-5">
      <button class="btn">수정</button>
      <button type="reset" class="btn">취소</button>
      <button type="reset" class="btn" onclick="history.back()">뒤로가기</button>
    </div>
    </div>
    
  </form>
</div>
</body> 
</html> 