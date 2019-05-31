<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>

<% request.setCharacterEncoding("utf-8");
   
   String url = "jdbc:oracle:thin:@127.0.0.1:1521:XE";  // (1) url을  Constant.java의 url에 넣어주도록 한다.
   String user = "soldesk";
   String password = "1234";
   String driver = "oracle.jdbc.driver.OracleDriver"; // (2) driver를 Constant.java의 driver에 넣어주도록 한다.
   
   Class.forName(driver); //TryCatch 안한다. 미리 오류를 잡고 올려야 하기 때문에
   
   Connection con = DriverManager.getConnection(url, user, password);
   
   StringBuffer sql = new StringBuffer();
   
   PreparedStatement pstmt = null;
   
   ResultSet rs = null;
   
%>