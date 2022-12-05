<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java"
     import = "java.text.*,java.sql.*"
     import = "java.sql.Connection"
     import = "java.time.LocalDate"
     import = "java.time.format.DateTimeFormatter"
     %>
     <%!
	     public static void LOG_IN(Connection conn, String id, String pw) throws SQLException {
	 		//아이디, 비밀번호 입력
	 		
	 		System.out.print(id + pw);

	 		/*
	 		if( status.equals("CAR_INSERT")){
	 			CAR_INSERT(conn, id);
	 	    }
	 	    else if( status.equals("CAR_SEARCH")){
	 	    	CAR_SEARCH(conn);
	 	    }*/
	 	}
     %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>LOGIN_POST</title>
</head>
<body>
	<%
		String serverIP = "localhost";
		String strSID = "orcl";
		String portNum = "1521";
		String user = "project";
		String pass = "project";
		String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
		Connection conn = null;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
	%>	

	<%
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		LOG_IN(conn, id, pw);
	%>
</body>
</html>