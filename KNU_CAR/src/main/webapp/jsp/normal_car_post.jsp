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
		String mileage;
		String gearbox;
		String fuel;
		String manufacturer;
		String car_model;
	    String enrolled_date;
		String maked_date;
		String[] option;
		String[] agreements;
     	
     	String user_id;
     	String car_id;
     %>
     
     <%!
     public void NORMAL_CAR_INSERT(Connection conn, String id, String cid) throws SQLException {
	    	PreparedStatement pstmt;
	 		ResultSet rs;
	 		
	 		String query;
	 		int num;
	 		
 			query = "SELECT COUNT(*) FROM NORMAL_CAR";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1) + 1;
				int normal_id = num;
				String normal_car_id = car_id;
				String normal_user_id = user_id;
				
				
				//쿼리생성 차량 기본정보  
				query = "INSERT INTO NORMAL_CAR VALUES ('"
						+ normal_id + "','"
						+ normal_car_id + "','"
						+ normal_user_id + "','"
						+ mileage + "','"
						+ gearbox + "','"
						+ fuel + "','" 
						+ manufacturer + "','"
						+ car_model + "','"
						+ enrolled_date + "','"
						+ maked_date + "')";
				
				//System.out.println(query);
				pstmt = conn.prepareStatement(query);
				rs = pstmt.executeQuery();
				
				//쿼리생성 차량 기본옵션
				
				if(option != null && option.length > 0) {
					query = "SELECT COUNT(*) FROM NORMAL_CAR_OPTION";
					pstmt = conn.prepareStatement(query);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						num = rs.getInt(1) + 1;
						for(int i = 0; i < option.length; i++) {
							String opt = option[i];
							query = "INSERT INTO NORMAL_CAR_OPTION VALUES ('" + normal_id + "','" + normal_car_id + "','"
									+ normal_user_id + "','" + opt + "')";
							
							//System.out.println(query);
							pstmt = conn.prepareStatement(query);
							rs = pstmt.executeQuery();
						}
					}
				}
				
				if(agreements != null && agreements.length > 0) {
					for(int i = 0; i < agreements.length; i++) {
							query = "SELECT COUNT(*) FROM NORMAL_CAR_ACCIDENT_HISTORY";
							pstmt = conn.prepareStatement(query);
							rs = pstmt.executeQuery();
							
							if(rs.next()) {
								num = rs.getInt(1) + 1;
							
							// test_data
							int accident_id = num;
							int insurance_accident = 1;
							int waterlogged = 2;
							int stolen = 3;
							int total_loss = 4;
							
							query = "INSERT INTO NORMAL_CAR_ACCIDENT_HISTORY VALUES ("+ 
							accident_id + ", '"+ normal_id + "','" + normal_car_id + "','" + normal_user_id + "'," + 
							insurance_accident + ", " + waterlogged + ", " + stolen + ", " + total_loss + ")";
							
							//System.out.println(query);
							pstmt = conn.prepareStatement(query);
							rs = pstmt.executeQuery();
						}
					}
				}
	 		}
	 		else {
	 			System.out.println("SYSDB Error");
	 			return;
	 		}
 	 }
     %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNU CAR</title>
<script src="../javascript/noback.js"></script>
</head>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
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
		
		mileage = request.getParameter("mileage");
		gearbox = request.getParameter("gearbox");
		fuel = request.getParameter("fuel");
		manufacturer = request.getParameter("manufacturer");
		car_model = request.getParameter("car_model");
	    enrolled_date = request.getParameter("enrolled_date");
		maked_date = request.getParameter("maked_date");
		option = request.getParameterValues("car_option");
		agreements = request.getParameterValues("car_accident");
		user_id = (String)session.getAttribute("user_id");
		car_id = (String)session.getAttribute("car_id");
		
		// user_id, car_id 입력 받아야함.
		NORMAL_CAR_INSERT(conn, user_id, car_id);
		
		response.sendRedirect("../jsp/search_post.jsp");
	%>
</body>
</html>