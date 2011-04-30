<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>

<!-- JSP 선언문: 드라이버 로딩 콜백메소드인 init을 1회 실행하며 setConnection메소드를 등록 -->
<%!
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String DB_URL = "jdbc:mysql://localhost/reuse";
	String DB_USER="root";
	String DB_PASSWORD="qwer1234";

	
	public void init()
	{
		try{ Class.forName("org.gjt.mm.mysql.Driver"); }
		catch (ClassNotFoundException e) {e.printStackTrace();}
	}
	public void setConnection()
	{
		try{
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			stmt = conn.createStatement();
		} catch (SQLException e) {e.printStackTrace();}
	}
%>
<%
	// 데이터 받아오기
	String asset_name = request.getParameter("asset_name");
	// db-select
	try{
		this.setConnection();
		String sql = "select * from asset where asset_name=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, asset_name);
		rs = pstmt.executeQuery();		
	} catch(SQLException e) {e.printStackTrace();}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script>
function check_asset_close(asset_name)
{
	opener.reuse_information.asset_name.value = asset_name;
	window.close();
	opener.reuse_information.overall_description.focus();
}
</script>
<style type="text/css">
	body {font-size: 12pt}
</style>
</head>
<body>
	<form method="post" action="check_assetname.jsp">
	<%
		try {
			if(rs.next() || (asset_name == null))
			{
	%>
			Current asset name(<%=asset_name %>) is invalid<br></br>
			Asset name: <input type="text" name="asset_name"></input>
			<input type="submit" name="asset check"></input>
	<%
			}
			else
			{
	%>
			Current asset name(<%=asset_name %>) is valid
			<a href="check_assetname.jsp">Change another asset name</a><br></br>
			<input type="button" value="Use current asset name" onclick="javascript:check_asset_close('<%=asset_name %>')" check"></input>
	<%	
			}
		} catch (SQLException e) {e.printStackTrace();}
		finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(SQLException e) {e.printStackTrace();}
		}
	%>
	</form>
</body>
</html>