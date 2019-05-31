<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_all.jsp" %> 
<jsp:useBean id="dao" class="bbs.BbsDAO" />
<jsp:useBean id="dto" class="bbs.BbsDTO" />
<jsp:setProperty name="dto" property="*" />

<%
   Map map = new HashMap();
   map.put("grpno", dto.getGrpno());
   map.put("ansnum",dto.getAnsnum());
   
   dao.upAnsnum(map);
   boolean flag = dao.createReply(dto);
%>
<!DOCTYPE html> 
<html> 
<head>
  <title>게시판 답변처리</title>
  <meta charset="utf-8">
  <script type="text/javascript">
    function listM(){
      var url = "list.jsp";
      location.href = url;
    }
  
  </script>

</head>
<body> 

<jsp:include page="/menu/top.jsp" />
  <div class="container">
    <div class="well well-lg">
      <%
         if(flag){
        	 out.print("Your comment has been written.");
         } else{
        	 out.print("글 답변 실패입니다.");
         }
      %>
    </div>
      <button type="button" class="btn" onclick="listM()">목록</button>
      <button type="reset" class="btn">취소</button>
  </div>

</body> 
</html>