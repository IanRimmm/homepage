<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_all.jsp" %> 
<jsp:useBean id="dao" class="guestbook.GuestbookDAO" />

<%
   //in JSP
   String col = Utility.checkNull(request.getParameter("col")); // utility-ssi연결
   String word = Utility.checkNull(request.getParameter("word")); // & null값 입력 방지
   
   if(col.equals("total")) word = "";
   
   //relate to Paging
   int nowPage = 1;
   if(request.getParameter("nowPage")!=null){ //클라이언트가 번호를 클릭할 때마다 실행된다.
      nowPage = Integer.parseInt(request.getParameter("nowPage"));
   }
   
   int recordPerPage = 3;
   
   int sno = ((nowPage-1)*recordPerPage)+1;
   int eno = nowPage * recordPerPage;
   
   //in DB
   Map map = new HashMap();
   map.put("col", col); // key, value
   map.put("word", word);
   map.put("sno", sno);
   map.put("eno", eno);
   
   int total = dao.total(map);  // int total -> Utility로..
   
   List<GuestbookDTO> list = dao.list(map);  // id="dao" 명과 일치해야 함!
%>
<!DOCTYPE html> 
<html> 
<head>
  <title>방명록</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

  <script type="text/javascript">
    function read(no){
      var url = "read.jsp";
      url += "?no="+no;
      location.href=url;
    }
    function update(no){
      var url = "updateform.jsp";
      url += "?no="+no;
      location.href=url;
    }
    function del(no){
      if(confirm("정말 삭제하시겠습니까?")){
      
      var url = "deleteproc.jsp";
      url += "?no="+no;
      location.href=url;
      
      }
    }
  </script>
  
</head>
<body>

<jsp:include page="/menu/top.jsp" />

<div class="container">

  <h1 class="col-sm-offset-2 col-sm-10">Guestbook</h1>
  <form class="form-inline" action="./list.jsp">
    <div class="form-group">
      <select class="form-control" name="col">
        <option value="name" <% if(col.equals("name")) out.print("selected"); %>>성명</option>
        <option value="title" <% if(col.equals("title")) out.print("selected"); %>>제목</option>
        <option value="content" <% if(col.equals("content")) out.print("selected"); %>>내용</option>
        <option value="title_content" <% if(col.equals("title_content")) out.print("selected"); %>>제목+내용</option>
        <option value="total" <% if(col.equals("total")) out.print("selected"); %>>전체출력</option>
      </select>
    </div>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Enter 검색어 " name="word" value="<%=word %>">
    </div>
      <button type="submit" class="btn btn-default">검색</button>
      <button type="button" class="btn btn-default" onclick="location.href='createform.jsp'">등록</button>
  </form>
  
    <table class="table table-striped">
      <thead>
        <tr>
          <th>번호</th>
          <th>이름</th>
          <th>제목</th>
          <th>여행지</th>
          <th>날짜</th>
          <th>grpno</th>
          <th>indent</th>
          <th>ansnum</th>
          <th>업데이트</th>
        </tr>
      </thead>
      <tbody>
        <%
          if(list.size()==0){
        %>
        <tr>
          <td colspan="8"> 등록된 여행일지가 없습니다. </td>
        </tr>
        <%
          } else {
            for(int i=0; i< list.size(); i++){
              GuestbookDTO dto = list.get(i);
        %>
        <tr>
          <td><%=dto.getNo() %></td>
          <td>
          <%for(int r=0; r<dto.getIndent(); r++){
              out.print("&nbsp;&nbsp;");
          }
          if(dto.getIndent()>0){
              out.print("<img src='../images/re.jpg'>");
          }
         %>
          <a href="javascript:read('<%=dto.getNo() %>')"><%=dto.getName() %></a></td>
          <td><%=dto.getTitle() %></td>
          <td><%=dto.getPartstr() %></td>
          <td><%=dto.getRegdate() %></td>
          <td><%=dto.getGrpno() %></td>
          <td><%=dto.getIndent() %></td>
          <td><%=dto.getAnsnum() %></td>
          <td><a href="javascript:update('<%=dto.getNo() %>')">수정</a>/
              <a href="javascript:del('<%=dto.getNo() %>')">삭제</a></td>
        </tr>
        <%
           }
         }
        %>
      </tbody>
    </table>
    <div>
      <%=Utility.paging(total, nowPage, recordPerPage, col, word) %> <!-- 검색값을 가지고 가기 위해서 utility paging으로 보내준다? -->
      <!-- <button type="button" class="btn" onclick="location.href='./createform.jsp'">여행지등록</button> -->
    </div>
</div>
</body> 
</html> s