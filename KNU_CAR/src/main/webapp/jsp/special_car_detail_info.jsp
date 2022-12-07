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
     	String user_id;
     	String price;
     	String ma;
     	String mo;
     	String f;
     	String g;
     	String d;
     	String m;
     	String r;
		String n;
		String we;
		String u;
		
     	static ResultSet rs;
     	static ResultSet rs2;
     	static ResultSet rs3;
     	static ResultSet rs4;
     %>

     <%!
	     public void SEARCH(Connection conn, String car_id, String user_id) throws SQLException {
	 		PreparedStatement pstmt;
	 		
	 		String query;
	 		
	 		query = "SELECT * FROM CAR WHERE car_id='" + car_id + "' AND " + "USER_ID='" + user_id + "'";
	 		pstmt = conn.prepareStatement(query);
	 		rs = pstmt.executeQuery();
	 		
	 		query = "SELECT * FROM SPECIAL_CAR WHERE special_car_id='" + car_id + "' AND " + "special_user_id='" + user_id + "'";
	 		pstmt = conn.prepareStatement(query);
	 		rs2 = pstmt.executeQuery();
	 		
	 		query = "SELECT * FROM SPECIAL_CAR_OPTION WHERE sspecial_car_id='" + car_id + "' AND " + "sspecial_user_id='" + user_id + "'";
	 		pstmt = conn.prepareStatement(query);
	 		rs3 = pstmt.executeQuery();

	 		query = "SELECT * FROM SPECIAL_CAR_ACCIDENT_HISTORY WHERE accident_special_car_id='" + car_id + "' AND " + "accident_special_user_id='" + user_id + "'";
	 		pstmt = conn.prepareStatement(query);
	 		rs4 = pstmt.executeQuery();
	 		
	 		if(rs.next()) {
	 			price = rs.getString(5);
	 			n = rs.getString(7);
	 		}
	 		if(rs2.next()) {
	 			ma = rs2.getString(7);
	 			mo = rs2.getString(8);
	 			f = rs2.getString(6);
	 			g = rs2.getString(5);
	 			d = rs2.getString(4);
	 			m = rs2.getString(10).substring(2, 4);
	 			r = rs2.getString(9).substring(0, 4) + "년 " + rs2.getString(9).substring(5, 7) + "월 " + rs2.getString(9).substring(8, 10) + "일";	
	 			we = rs2.getString(12);
	 			u = rs2.getString(13);
	 		}
	 	}
     %>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/car_detail_info.css">
<title>KNU CAR</title>
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
	
		car_id = request.getParameter("selected_car_id");
		user_id = request.getParameter("selected_user_id");
		
		SEARCH(conn, car_id, user_id);
	%>

<div class="wrapper">
    <div class="logo_title">
        <span id="title">KNU CAR</span>
        <span style="margin-left: 10px;">차량 상세 정보</span>
    </div>
    <div class="format">

        <div class="reg_form" style="align-items:flex-start;">

            <li class="contents_name">차량 종류</li>
            <div class="info_form"> 일반 차량 </div>
            <li class="contents_name">차량 번호</li>
            <div class="info_form"> <% out.print(car_id); %> </div>
            <li class="contents_name">희망 가격</li>
            <div class="info_form"><% out.print(price); %>만원</div>
            <li class="contents_name">제조사</li>
            <div class="info_form"> <%out.print(ma);%> 
        	</div>
            <li class="contents_name">모델명</li>
            <div class="info_form"> <% out.print(mo);%></div>
            <li class="contents_name">연료 종류</li>
            <div class="info_form"> <%out.print(f);%>  </div>
        </div>

        <div class="reg_form" style="align-items:flex-end;">
            <div>
            <li class="contents_name">변속기</li>
            <div class="info_form"> <%out.print(g);%>  </div>
            <li class="contents_name">운행 거리</li>
            <div class="info_form"> <%out.print(d);%> Km</div>
            <li class="contents_name">차량 연식</li>
            <div class="info_form"> <%out.print( m);%> 년식</div>
            <li class="contents_name">등록 일자</li>
            <div class="info_form"> <%out.print(r);%></div>
            <li class="contents_name">허용 중량</li>
            <div class="info_form"> <%out.print(we);%> Kg </div>
            <li class="contents_name">사용 용도</li>
            <div class="info_form"> <%out.print(u);%> </div>
            </div>
        </div>
    </div>
    <div class="contents_name">선택된 옵션</div>
        <div class="option_group">
        	<%
        		while(rs3.next()) {
        			out.print("<div class='option_form'>" + rs3.getString(4) + "</div>");
        		}
        	
        		if(rs4.next()) {
        			out.print("<div class='option_form'>" + "사고기록 제공" + "</div>");
        		}
        		else {
        			out.print("<div class='option_form'>" + "사고기록 미제공" + "</div>");
        		}
        	%>
        </div>

    <div class="contents_name">세부 사항</div>
    <div class="notice_form"><%out.print(n = rs.getString(7));%></div>

</div>
</body>
</html>