<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_all.jsp" %>
<jsp:useBean id="dao" class="guestbook.GuestbookDAO" />
<%
   int no = Integer.parseInt(request.getParameter("no"));
   GuestbookDTO dto = dao.readReply(no);
   
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
  #need{
  color:red;
  }
  </style>
  
  <script type="text/javascript">
  function incheck(f){
  if(f.name.value==''){
    alert('이름을 입력하세요');
    f.name.focus();
    return false;
  }
  if(f.title.value==''){
    alert('제목을 입력하세요');
    f.title.focus();
    return false;
  }
  if(f.content.value==''){
    alert('내용을 입력하세요');
    f.content.focus();
    return false;
  }
  if(f.passwd.value==''){
    alert('비밀번호을 입력하세요');
    f.passwd.focus();
    return false;
  }
}
</script>

</head>
<body> 

<div class="container">
<h1 class="col-sm-offset-2 col-sm-10">메모 답변 등록</h1>
 
<form class="form-horizontal" action="replyproc.jsp" method="post" onsubmit="return incheck(this)">

  <input type="hidden" name="no" value="<%=dto.getNo()%>">
  <input type="hidden" name="grpno" value="<%=dto.getGrpno()%>">
  <input type="hidden" name="indent" value="<%=dto.getIndent()%>">
  <input type="hidden" name="ansnum" value="<%=dto.getAnsnum()%>">

  <div class="form-group">
    <label class="control-label col-sm-2" for="name" >이름<span id="need">*</span></label>
      <div class="col-sm-6">
        <input type="text" name="name" id="name" class="form-control" value="<%=dto.getTitle()%>">
      </div>
  </div>
 
  <div class="form-group">
    <label class="control-label col-sm-2">성별</label>
      <div class="col-sm-10">
        <label class="radio-inline">
          <input type="radio" name="gender" value="남자" checked>남자
        </label> <label class="radio-inline"> 
          <input type="radio" name="gender" value="여자">여자
        </label>
      </div>
  </div>
 
  <div class="form-group">
    <label class="control-label col-sm-2" for="title" >제목<span id="need">*</span></label>
      <div class="col-sm-6">
        <input type="text" name="title" id="title" class="form-control">
      </div>
  </div>
 
  <div class="form-group">
    <label class="control-label col-sm-2" for="content" >내용<span id="need">*</span></label>
      <div class="col-sm-6">
        <textarea rows="5" cols="5" id="content" name="content" class="form-control"></textarea>
      </div>
  </div>
 
  <div class="form-group">
    <label class="control-label col-sm-2">구분</label>
      <div class="col-sm-10">
        <label class="checkbox-inline">
          <input type="checkbox" name="part" value="공지" checked>공지
        </label>
        <label class="checkbox-inline">
          <input type="checkbox" name="part" value="질문">질문
        </label>
        <label class="checkbox-inline">
          <input type="checkbox" name="part" value="불만">불만
        </label>
        <label class="checkbox-inline">
          <input type="checkbox" name="part" value="안부">안부
        </label>
      </div>
  </div>
  
  <div class="form-group">
    <label class="control-label col-sm-2" for="passwd">비밀번호<span id="need">*</span></label>
      <div class="col-sm-6">
        <input type="text" name="passwd" id="passwd" class="form-control">
      </div>
  </div>

  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-5">
      <button class="btn">등록</button>
      <button type="reset" class="btn">취소</button>
      <button type="reset" class="btn" onclick="history.back()">뒤로가기</button>
    </div>
  </div>
  
</form>
</div>

</body> 
</html>