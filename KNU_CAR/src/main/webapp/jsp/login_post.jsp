<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java"
     import = "java.text.*,java.sql.*"
     import = "java.sql.Connection"
     import = "java.time.LocalDate"
     import = "java.time.format.DateTimeFormatter"
     import = "javax.swing.JOptionPane;"
     %>
     <%!
	     public static void LOG_IN(Connection conn, String id, String pw) throws SQLException {
	 		//아이디, 비밀번호 입력
	 		
	 		System.out.println(id + pw);
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
<meta charset="UTF-8">
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
		
		String query;
		PreparedStatement pstmt;
 		ResultSet rs;
	%>	

	<%
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		query = "SELECT COUNT(*) FROM USER_ WHERE id = " + id + "and pw = " + pw;
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		int num = rs.getInt(1); //존재하는 아이디인지 검증 
		if(num != 0) {
			LOG_IN(conn, id, pw);
		}
		else{
			//아이디, 비밀번호를 확인해주세요!
			JOptionPane.showMessageDialog(null, "아이디, 비밀번호를 확인해주세요!");
			response.sendRedirect("login_post.jsp");
		}
	%>
</body>
</html>