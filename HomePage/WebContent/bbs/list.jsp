<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_all.jsp" %> 
<jsp:useBean id="dao" class="bbs.BbsDAO" />

<%
   //검색 관련-----------------------
   String col = Utility.checkNull(request.getParameter("col"));
   String word = Utility.checkNull(request.getParameter("word"));
   
   if(col.equals("total")) word= "";
   
   //페이지 관련---------------------
   //처음 페이지가 열렸을 때는 1이지만, 
   int nowPage = 1; //현재 보고 있는 페이지 
   if(request.getParameter("nowPage")!=null){ //클라이언트가 번호를 눌렀을 경우 
	   nowPage = Integer.parseInt(request.getParameter("nowPage"));
   }
   
   int recordPerPage = 10; //한 페이지 당 보여줄 record 수
   
   //DB에서 가져올 순번---------------
   int sno = ((nowPage-1)*recordPerPage) + 1; //이 계산식이 list에서 보여지는 방식이므로 중요하다!
   int eno = nowPage * recordPerPage;
   
   Map map = new HashMap();
   map.put("col", col);
   map.put("word", word);
   map.put("sno", sno);
   map.put("eno", eno);
   
   int total = dao.total(col,word); //col, word에서 마이바티스에서 map으로 바뀔 것..?
   
   List<BbsDTO> list = dao.list(map);
%>

<!DOCTYPE html> 
<html> 
<head>
  <title>목록</title>
  <meta charset="utf-8">
  <script type="text/javascript">
    function read(bbsno){ //read('<dto.getBbsno')에서 getBbsno가 실변수이고, 여기 bbsno가 가변수이다
      var url = "read.jsp";
      url += "?bbsno="+bbsno;   // bbsno = javascript 변수
                                // <> col,word,nowPage는 jsp변수      
      url += "&col=<%=col%>";   
      url += "&word=<%=word%>";
      url += "&nowPage=<%=nowPage%>";
      
      location.href = url;
    }
    
    //내용을 보고 풀리지 않게 하기 위해서 col같은 것을 갖고 간다?
  </script>
  
</head>
<body>

<jsp:include page="/menu/top.jsp" />

<div class="container">
  <h1 class="col-sm-offset-2 col-sm-10">게시판 목록</h1>
  <form class="form-inline" action="./list.jsp">
    <div class="form-group">
      <select class="fomr-control" name="col">
        <option value="wname"<% if(col.equals("wname")) out.print("selected");%>>성명</option>
        <option value="title"<% if(col.equals("title")) out.print("selected");%>>제목</option>
        <option value="content"<% if(col.equals("content")) out.print("selected");%>>내용</option>
        <option value="title_content"<% if(col.equals("title_content")) out.print("selected");%>>제목+내용</option>
        <option value="total"<% if(col.equals("total")) out.print("selected");%>>전체출력</option>
      </select>
    </div>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Enter 검색어"
            name="word" value="<%=word %>">
    </div>
      <button type="submit" class="btn btn-default">검색</button> 
      <button type="button" class="btn btn-default" onclick="location.href='createform.jsp'">등록</button> 
  </form>
  
  <table class="table table-stiped">
    <thead>
      <tr>
        <th>번호</th>
        <th>이름</th>
        <th>제목</th> 
        <th>부모글 번호</th>
        <th>답변 여부</th>
        <th>답변 순서</th>
      </tr>
    </thead>
    <tbody>
      <%
         if(list.size()==0){
        	 
         } else {
        	 for(int i=0; i < list.size(); i++){
        		 BbsDTO dto = list.get(i);
      %>
      <tr>
        <td><%=dto.getBbsno() %></td>
        <td><%=dto.getWname() %></td>
        <td>
        <!-- 들여쓰기 -->
        <%
          for(int r=0; r<dto.getIndent(); r++){
        	  out.print("&nbsp;&nbsp;"); // &nbsp : 한 칸
          }
          if(dto.getIndent()>0){
        	  out.print("<img src='../images/re.jpg'>");
          }
        %>
        <a href="javascript:read('<%=dto.getBbsno() %>')"><%=dto.getTitle() %></a>
        <% if(Utility.compareDay(dto.getWdate())) { %>
        <img src="../images/new.gif">  <!-- 스크립틀릿이 아니니까..?? -->
        <% } %>
        </td>
        <td><%=dto.getGrpno() %></td>   <!-- 글과 답변을 하나로 묶어주기 위해서 groupnumber를 사용! -->
        <td><%=dto.getIndent() %></td>  <!-- indent : 답변의 깊이(에 따른 들여쓰기!) -->
        <td><%=dto.getAnsnum() %></td>  <!-- ansnum : 답변의 순서 / 새로운 답변 글이 항상 위로 오게 하기 위해 사용 -->
      </tr>
      <%
           }
         }
      %>
    </tbody>
  </table>
    <%=Utility.paging(total, nowPage, recordPerPage, col, word) %> <!-- uitlity가 갖고 있는 paging안에서 처리하는 것! -->
    <!-- 밑에 줄의 등록의 윗줄의 Utility로 변경! -->                      <!-- 검색한 것을 유지하기 위해서 col, word를 갖고 감! --> 
    <!-- <button class="btn" type="button" onclick="location.href='./createform.jsp'">등록</butto> -->
</div>
  
</body> 
</html>