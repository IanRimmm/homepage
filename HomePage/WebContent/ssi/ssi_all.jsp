<%@ page contentType="text/html; charset=UTF-8" %> 

<!--  page directive를 통해 list, dao, dto를 선언하고자 한다. -->
<%@ page import = "java.util.*" %>
<%@ page import = "utility.*" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.BbsDTO" %>
<%@ page import = "guestbook.GuestbookDAO" %>
<%@ page import = "guestbook.GuestbookDTO" %>
<!-- page import = "member.MemberDAO" %> -->
<!-- page import = "member.MemberDTO" %> -->
<!-- page import = "memo.MemoDAO" %> -->
<!-- page import = "memo.MemoDTO" %> -->
<!-- page import = "team.TeamDAO" %> -->
<!-- page import = "team.TeamDTO" %> -->
<!-- page import = "org.apache.commons.fileupload.*" %> -->

<% 
   request.setCharacterEncoding("utf-8");
   
   String root = request.getContextPath();
   String upDir = "/member/storage";
   String tempDir = "/member/temp";
   
   upDir = application.getRealPath(upDir);
   tempDir = application.getRealPath(tempDir);
%>