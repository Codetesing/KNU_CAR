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
     	String car_id;
     	String sell_price;
     	String sell_notice;
     	String car_type;
     	
     	// 수정 요망
     	// test = private
     	String user_id = "private";
     	
     	// 구현은 일단 일반만
     	String sell_type = "일반";
		String selling_state = "판매중";
		String registration_date;
     %>
     
     <%!
     public void CAR_INSERT(Connection conn, String id) throws SQLException {
    	 PreparedStatement pstmt;
 		ResultSet rs;
 		
 		String query;
 		int num;
 		
 		LocalDate now = LocalDate.now();
 	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
 	    String registration_date = now.format(formatter);//현재날짜 
 		
 		query = "SELECT COUNT(*) FROM CAR WHERE car_id='" + car_id + "'";
 		pstmt = conn.prepareStatement(query);
 		rs = pstmt.executeQuery();
 		
 		if(rs.next()) {
 			num = rs.getInt(1);
 			if(num == 0) {
 				query = "INSERT INTO CAR VALUES ('"
 		 				+ car_id + "','"
 		 				+ user_id + "','"
 		 				+ car_type + "','"
 		 				+ sell_type + "','"
 		 				+ sell_price + "','"
 		 				+ registration_date + "','" 
 		 				+ sell_notice + "','"
 		 				+ selling_state + "')";
 			}
 			else {
	 			//UPDATE
	 			query = "UPDATE CAR SET " + 
	 			"user_id = '"  + user_id + "'," + 
	 			"sell_price = '"  + sell_price + "'," + 
	 			"sell_notice = '"  + sell_notice + "'," +
	 			"registration_date = '"  + registration_date +  "' " + 
	 			"WHERE car_id='" + car_id + "'"; 
 			}
 		}
 		else {
 			query = "Error";
 		}
 		//System.out.println(query);
 	    pstmt = conn.prepareStatement(query);
 		rs = pstmt.executeQuery();
 	}
     %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CAR_POST</title>
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
		request.setCharacterEncoding("UTF-8");
		
		car_id = request.getParameter("car_id");
	 	sell_price = request.getParameter("sell_price");
	 	sell_notice = request.getParameter("sell_notice");
	 	car_type = request.getParameter("car_type");
		
		CAR_INSERT(conn, user_id);
		
		// car_type == normal -> normal_car_sell_notice
		// car_type == special -> special_car_sell_notice 
		// get 형태로 parameter user_id, car_id 전송
	%>
</body>
</html>