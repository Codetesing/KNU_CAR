<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java"
     import = "java.text.*,java.sql.*"
     import = "java.sql.Connection"
     import = "java.time.LocalDate"
     import = "java.time.format.DateTimeFormatter"
     import = "java.utill.*"
     %>
     
     <%!
     	String id;
     	String pw;
     	String name;
		String ssn;
		String sex;
		String email;
		String phone;
		String city;
		String addr;
		String birth;
		String user_type = "business";
     %>
     
     <%!
     public void SIGN_IN(Connection conn) throws SQLException {
 		PreparedStatement pstmt;
 		ResultSet rs;
 		
 		String query;
 		//회원정보 입력 
 		
 		query = "INSERT INTO USER_ VALUES ('"
 				+ id + "','"
 				+ pw + "','"
 				+ name + "','"
 				+ phone + "','"
 				+ email + "','"
 				+ city + "','" 
 				+ addr + "','"
 				+ birth + "','"
 				+ sex + "','"
 				+ user_type + "')";
 		
 		//System.out.println(query);
 		
 		pstmt = conn.prepareStatement(query);
 		rs = pstmt.executeQuery();
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
		request.setCharacterEncoding("UTF-8");
		id = request.getParameter("id");
		query = "SELECT COUNT(*) FROM USER_ WHERE id = " + id;
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		int num = rs.getInt(1); //존재하는 아이디인지 검증 
		if(num == 0) {
		
			pw = request.getParameter("pw");
			name = request.getParameter("name");
			birth = request.getParameter("birth");
			String sex_temp = request.getParameter("sex");
			if(sex_temp.equals("1") || sex_temp.equals("3"))
				sex = "M";
			else
				sex = "W";
			email = request.getParameter("email");
			phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
			city = request.getParameter("city");
			addr = request.getParameter("addr");
		}
		else{
			//이미 존재하는 아이디 입니다. 
			response.sendRedirect("register_business_post.jsp");
		}
		
		SIGN_IN(conn);
		
	%>
</body>
</html>