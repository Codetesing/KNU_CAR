<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java"
     import = "java.text.*,java.sql.*"
     import = "java.sql.Connection"
     import = "java.time.LocalDate"
     import = "java.time.format.DateTimeFormatter"
     %>
     <%!
	    String search_menu;
     	String search_value;
     	String car_type;
     	String user_id;
     	
     	int total_page;
     	int cur_page;
     	
     	static ResultSet rs;
     	static ResultSet rs2;
     	static ResultSetMetaData rsmd;
     	static ResultSetMetaData rsmd2;
     %>
     
     <%!
     
     	public static void CAR_INFORM(Connection conn, String car_id, String user_id, String car_type) throws SQLException {
     	
    	 	PreparedStatement pstmt;
	 		String query = "";
	 		
	 		if(car_type.equals("normal")) {
	 			query = "SELECT MANUFACTURER, CAR_MODEL, MAKED_DATE, FUEL FROM NORMAL_CAR "
	 					+ "WHERE NORMAL_CAR_ID = '" + car_id + "' AND NORMAL_USER_ID = '" + user_id + "'";
	 		}
	 		
	 		else if(car_type.equals("special")) {
	 			query = "SELECT MANUFACTURER, CAR_MODEL, MAKED_DATE, FUEL FROM SPECIAL_CAR "
	 					+ "WHERE SPECIAL_CAR_ID = '" + car_id + "' AND SPECIAL_USER_ID = '" + user_id + "'";
	 		}
	 		
			if(query == "")
				return;
	 		
	 		pstmt = conn.prepareStatement(query);
			rs2 = pstmt.executeQuery();
			rsmd2 = rs.getMetaData();
     	}
     
     
	     public static void CAR_SEARCH(Connection conn, String car_type, String menu, String value) throws SQLException {
	 		PreparedStatement pstmt;
	 		String query = "";
	 		
	 		if(menu == null || value == null) {
	 			query = "SELECT * FROM CAR WHERE CAR_TYPE = '"
	 					+ car_type + "' ORDER BY REGISTRATION_DATE DESC";
	 		}
	 		
	 		else {
		 		if (car_type.equals("normal")){
		 			//-----일반차량  중에서 검색 
		 			
		 			if(menu.equals("제조사")) {
			 			query = "SELECT * FROM CAR, NORMAL_CAR " +
			 					"WHERE CAR_id = NORMAL_CAR_ID AND " +
			 					"MANUFACTURER LIKE '%" + value + "%' " +
			 					"ORDER BY REGISTRATION_DATE DESC";
		 			}
		 			else if(menu.equals("모델")) {
			 			query = "SELECT * FROM CAR, NORMAL_CAR " +
			 					"WHERE CAR_id = NORMAL_CAR_ID AND " +
			 					"CAR_MODEL LIKE '%" + value + "%' " +
			 					"ORDER BY REGISTRATION_DATE DESC";
			 		}
		 			else if(menu.equals("연료 종류")) {
			 			query = "SELECT * FROM CAR, NORMAL_CAR " +
			 					"WHERE CAR_id = NORMAL_CAR_ID AND " +
			 					"FUEL LIKE '%" + value + "%' " +
			 					"ORDER BY REGISTRATION_DATE DESC";
			 		}
		 			else if(menu.equals("판매상태")) {
			 			query = "SELECT * FROM CAR " +
			 					"WHERE CAR_TYPE = 'normal' AND " +
	 							"SELLING_STATE = '" + value + "' " +
			 					"ORDER BY REGISTRATION_DATE DESC";
			 		}
		 		}
		 		
		 		else if (car_type.equals("special")){
		 			//-----특수차량  중에서 검색 
		 			
		 			if(menu.equals("제조사")) {
			 			query = "SELECT * FROM CAR, SPECIAL_CAR " +
			 					"WHERE CAR_id = SPECIAL_CAR_ID AND " +
			 					"MANUFACTURER LIKE '%" + value + "%' " +
			 					"ORDER BY REGISTRATION_DATE DESC";
		 			}
		 			else if(menu.equals("모델")) {
			 			query = "SELECT * FROM CAR, SPECIAL_CAR " +
			 					"WHERE CAR_id = SPECIAL_CAR_ID AND " +
			 					"CAR_MODEL LIKE '%" + value + "%' " +
			 					"ORDER BY REGISTRATION_DATE DESC";
			 		}
		 			else if(menu.equals("연료 종류")) {
			 			query = "SELECT * FROM CAR, SPECIAL_CAR " +
			 					"WHERE CAR_id = SPECIAL_CAR_ID AND " +
			 					"FUEL LIKE '%" + value + "%' " +
			 					"ORDER BY REGISTRATION_DATE DESC";
			 		}
		 			else if(menu.equals("판매상태")) {
			 			query = "SELECT * FROM CAR " +
			 					"WHERE CAR_TYPE = 'special' AND " +
	 							"SELLING_STATE = '" + value + "' " +
			 					"ORDER BY REGISTRATION_DATE DESC";
			 		}
		 		}
	 		}
	 		
			if(query == "")
				return;
	 		
	 		pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 			rs = pstmt.executeQuery();
 			rsmd = rs.getMetaData();
	 	}
     %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNU CAR</title>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/search_post.css">
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
	
		search_menu = request.getParameter("search_menu");
		search_value = request.getParameter("search_value");
		car_type = request.getParameter("car_type");
		user_id = (String)session.getAttribute("user_id");
		
		//test_value
		if(car_type == null)
			car_type = "normal";
		
		CAR_SEARCH(conn, car_type, search_menu, search_value);
		
		
		rs.last();
		total_page = ((rs.getRow() - 1) / 10) + 1;
		rs.beforeFirst();
		
		String t = request.getParameter("cur_page");
		
		if(t == null)
			cur_page = 1;
		else
			cur_page = Integer.parseInt(t);
		
		for(int i = 0; i < (cur_page - 1) * 10; i++) {
			rs.next();
		}
	%>
	
	<div class = 'wrapper'>
	    <div class="logo_title">
	        <span id="title">KNU CAR</span>
	        <span style="margin-left: 10px;">차량 검색</span>
	    </div>
	    <div class="search_tab_form">
		    <form class="search_tab_form" method="post" action='../jsp/search_post.jsp'>
		    	<%
		    		if(car_type.equals("normal")) {
		    			out.print(
		    					"<input class='search_tab_selected_form' type='button' id='normal' value='일반 차량'>"
		    					+ "|<input class='search_tab_unselected_form' type='submit' id='special' value='특수 차량'>"
		    					+ "<input type='hidden' id='car_type' name='car_type' value='special'>");
		    		}
		    		else {
		    			out.print(
		    					"<input class='search_tab_unselected_form' type='submit' id='normal' value='일반 차량'>"
		    					+ "|<input class='search_tab_selected_form' type='button' id='special' value='특수 차량'>"
		    					+ "<input type='hidden' id='car_type' name='car_type' value='normal'>");
		    		}
		    	%>
		    	<input class='sell_btn' type='button' value='차량 판매' onclick="location.href='../html/car_sell_notice.html'">
	    	</form>
	    </div>
	    <form class="search_tab_form" method="post" action='../jsp/search_post.jsp'>
		    <div class="search_menu_form">
		        <select class="info_select" name="search_menu" style="margin-left: -2%;">
		            <option value="" disabled selected>카테고리 선택</option>
		            <option>제조사</option>
		            <option>모델</option>
		            <option>연료 종류</option>
		            <option>판매상태</option>
		        </select>
		        <input class="search_value_form" type="text" name="search_value">
		        <input class='search_btn' type='submit' value='검색'>
		        <%
		        	out.print("<input type='hidden' id='car_type' name='car_type' value='"+ car_type + "'>");
		        %>
		    </div>
	    </form>
	    
	    <%
			int cnt = rsmd.getColumnCount();
			int row_cnt = 0;
			
			
			while(rs.next() && row_cnt < 10){
				
				CAR_INFORM(conn, rs.getString(1), rs.getString(2), rs.getString(3));
				
				if(car_type.equals("normal"))
					out.print("<form action='../jsp/normal_car_detail_info.jsp' method='POST' id='" + rs.getString(1) + "'>");
				else if(car_type.equals("special"))
					out.print("<form action='../jsp/special_car_detail_info.jsp' method='POST' id='" + rs.getString(1) + "'>");
				
				out.print("<input type='hidden' id='selected_car_id' name='selected_car_id' value='"+ rs.getString(1) + "'>");
				out.print("<input type='hidden' id='selected_user_id' name='selected_user_id' value='"+ rs.getString(2) + "'>");
				
				if(row_cnt == 0)
					out.println("<table class='contents_table' style='margin-top: 100px;' onclick='detail_info(event)' id='" + rs.getString(1) + "'>");
				else
					out.println("<table class='contents_table' onclick='detail_info(event)' id='" + rs.getString(1) + "'>");
				
				out.println("<tr>");
				
				out.println("<td style='width:200px'>"+rs.getString(8)+"</td>");
				out.println("<td>");
				out.println("<table class='table_tabs'>");
				
				if(rs2.next()) {
					out.println("<td style='width:20%'>"+rs2.getString(1)+"</td>");
					out.println("<td style='width:20%'>"+rs2.getString(2)+"</td>");
					out.println("<td style='width:20%'>"+rs2.getString(3).substring(2, 4));%>년식</td><%;
					out.println("<td style='width:20%'>"+rs2.getString(4)+"</td>");
					out.println("<td style='width:20%'>"+rs.getString(1)+"</td>");
				}
				out.println("</table></td>");
				out.println("<td style='width:200px'>"+rs.getString(5));%>만원</td><%;
				out.println("</tr>");
				out.println("</table>");
				out.println("</form>");
				row_cnt++;
			}
	    %>
	</div>
	
	<div>
		<form class='paging' method="post" action='../jsp/search_post.jsp' id='paging'>
			<%
				for(int i = 1; i <= total_page; i++) {
					if(i == cur_page) {
						out.print("<button class='cur_page' type='button' value='" + i + "'>"+ i +"</button>");
					}
					else {
						out.print("<button class='not_cur_page' type='button' value='" + i + "' onclick='next_page(event)'>"+ i +"</button>");
					}
				}
			%>
			<input type='hidden', id='search_value', name='search_value' <% out.print("value='" + search_value + "'"); %>>
			<input type='hidden', id='search_menu', name='search_menu' <% out.print("value='" + search_menu + "'"); %>>
			<input type='hidden', id='next_page_num', name='cur_page' <% out.print("value='" + cur_page + "'"); %>>
			<input type='hidden', id='car_type', name='car_type' <% out.print("value='" + car_type + "'"); %>>
		</form>
	</div>
	
	<script src="../javascript/paging.js"></script>
</body>
</html>