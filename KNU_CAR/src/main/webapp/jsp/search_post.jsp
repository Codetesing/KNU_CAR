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
     %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN_POST</title>
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
		search_menu = request.getParameter("search_menu");
		search_value = request.getParameter("search_value");
		car_type = request.getParameter("car_type");
		user_id = request.getParameter("user_id");
		
		//test_value
		if(car_type == null)
			car_type = "normal";
		if(user_id == null)
			user_id = "private";
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
		            <option>변속기</option>
		            <option>연식</option>
		            <option>가격</option>
		            <option>지역</option>
		            <option>판매상태</option>
		        </select>
		        <input class="search_value_form" type="text" name="search_value">
		        <input class='search_btn' type='submit' value='검색'>
		    </div>
	    </form>
	</div>
</body>
</html>