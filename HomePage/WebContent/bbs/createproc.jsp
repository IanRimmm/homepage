<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_all.jsp" %> 
<jsp:useBean id="dao" class="bbs.BbsDAO" />
<jsp:useBean id="dto" class="bbs.BbsDTO" />
<jsp:setProperty name="dto" property="*" />

<%
   boolean flag = dao.create(dto);
%>
<!DOCTYPE html> 
<html> 
<head>
  <title>뜽록~</title>
  <meta charset="utf-8">

</head>
<body> 

<jsp:include page="/menu/top.jsp" />
  <div class="container">
    <div class="well well-lg">
      <%
         if(flag){
        	 out.print("미션 성공~");
         } else{
        	 out.print("미션 실패!");
         }
      %>
    </div>
      <button class="btn">등록</button>
      <button type="reset" class="btn">취소</button>
  </div>

</body> 
</html>