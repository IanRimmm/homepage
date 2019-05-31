<%@ page contentType="text/html; charset=UTF-8" %> 

<% //loginProc 세션에서 갖고오는 것!
   String root = request.getContextPath();
   String id = (String)session.getAttribute("id");
   String grade = (String)session.getAttribute("grade");

   String str = "기본페이지입니다아ㅏㅏ";
   if(id!=null && !grade.equals("A")){
     str = "안녕하세요"+id+"님~~";
   } else if(id!=null && !grade.equals("A")){
     str = "관리자페이지 입니다.";
   }
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
  <style type="text/css">
    #grade{
      color: graytext;
    }
  </style>
  
</head>
<body>

<div class="container">
  <div class="page-header row">
   <div class="col-sm-4">
    <img src="<%=root %>/images/cat04.JPG" class="img-responsive img-thumbnail" alt="cat" width="300">
   </div>
   
   <div class="col-sm-8"><h1>냥냥이 해적단</h1>
    <% if(id!=null){ %>
    <h2 id="grade"><%=id %>님</h2>
    <%} %>
   </div>
  
  </div>
  <ul class="nav nav-tabs">
    <li class="active"><a href="<%=root%>/index.jsp">Home</a></li>
    <li class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">게시판 <span class="caret"></span></a>
      <ul class="dropdown-menu">
        <li><a href="<%=root%>/bbs/createform.jsp">생성</a></li>
        <li><a href="<%=root%>/bbs/list.jsp">목록</a></li>                       
      </ul>
    </li>
    <li class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">메모<span class="caret"></span></a>
      <ul class="dropdown-menu">
        <li><a href="<%=root%>/memov3/createform.jsp">생성</a></li>
        <li><a href="<%=root%>/memov3/list.jsp">목록</a></li>                  
      </ul>
    </li>
    <li class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">방명록<span class="caret"></span></a>
      <ul class="dropdown-menu">
        <li><a href="<%=root%>/guestbook/createform.jsp">생성</a></li>
        <li><a href="<%=root%>/guestbook/list.jsp">목록</a></li>                        
      </ul>
    </li>
    <%if(id==null) {%>
    <li><a href="<%=root%>/member/agreement.jsp">회원가입</a></li>
    <li><a href="<%=root%>/member/loginForm.jsp">로그인</a></li>
    <%}else{ %>
    <li><a href="<%=root%>/member/read.jsp">나의정보</a></li>
    <li><a href="<%=root%>/member/updateForm.jsp">회원수정</a></li>
    <li><a href="<%=root%>/member/logout.jsp">로그아웃</a></li>
    <%} %>
  </ul>
</div>

</body> 
</html> 