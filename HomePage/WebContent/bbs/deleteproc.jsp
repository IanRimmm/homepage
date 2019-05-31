<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_all.jsp" %> 
<jsp:useBean id="dao" class="bbs.BbsDAO" />

<%
   int bbsno = Integer.parseInt(request.getParameter("bbsno")); //deleteform.jsp의 hidden 값을 받아오기 위함
   String passwd = request.getParameter("passwd");
   
   //패스워드 검증할 때, 비밀번호&pk가 필요하다
   Map map = new HashMap();
   map.put("bbsno", bbsno);
   map.put("passwd", passwd);
   
   boolean flag = false;
   boolean pflag = dao.passwdCheck(map);
   
   if(pflag){
     flag = dao.delete(bbsno);
   }
%>
<!DOCTYPE html> 
<html> 
<head>
  <title>게시판 삭제</title>
  <meta charset="utf-8">
  
  <script type="text/javascript">
    function listM(){
      var url = "list.jsp";
      
      url += "?col=<%=request.getParameter("col")%>";
      url += "&word=<%=request.getParameter("word")%>";
      url += "&nowPage=<%=request.getParameter("nowPage")%>";
      
      location.href = url;
    }
  </script>

</head>
<body> 

<jsp:include page="/menu/top.jsp" />
  <div class="container">
    <div class="well well-lg">
      <%
         if(!pflag){
           out.print("잘못된 비밀번호 입니다.");
         } else if(flag){
           out.print("글 삭제를 성공했습니다.");
         } else{
           out.print("글 삭제를 실패했습니다.");
         }
      %>
    </div>
    <% if(!pflag) {%>
      <button class="btn" onclick="history.back()'">다시  시도</button>
    <% } %>
      <button class="btn" onclick="location.href='createform.jsp'">다시 등록</button>
      <button class="btn" type="button" onclick="listM()">목록</button>
  </div>

</body> 
</html>