<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Modify overall description page</title>
<script type="text/javascript">
function go_parents(){
	var asset_name = document.getElementById("asset_name").value;
	window.opener.document.location.reload();	// Reload parents windows
	window.close();								// Close pop-up
}
</script>
</head>
<body onunload = "javascript:go_parents();">
<%
	request.setCharacterEncoding("euc-kr");
	String asset_name = request.getParameter("asset_name");
	String required_libraries_name = request.getParameter("required_libraries_name");

	String DB_URL = "jdbc:mysql://localhost/reuse";
	String DB_USER="root";
	String DB_PASSWORD="qwer1234";
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		// 1.JDBC Drive loading
		Class.forName("org.gjt.mm.mysql.Driver");
		
		// 2. Connection to DB
		conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		stmt = conn.createStatement();
		int updatecount = 0;
		updatecount = stmt.executeUpdate("UPDATE required_libraries SET required_libraries_name = '"+ required_libraries_name +"' WHERE asset_name = '" + asset_name + "'");
		if( updatecount == 0)
		{
			stmt.executeUpdate( "INSERT INTO required_libraries(required_libraries_name, asset_name) VALUES ( '" 
					+ required_libraries_name + "', '" + asset_name + "')");
		}
	} catch(SQLException e) {
		out.println(e.getMessage());
	}
	finally {
		if( stmt != null ) try{ stmt.close(); } catch(SQLException e){}
		if( conn != null ) try{ conn.close(); } catch(SQLException e){}
	}
%>
 	<script type="text/javascript">
 	//alert("Update completion");
 	window.opener.document.location.reload();	// Reload parents windows
 	window.close();								// Close pop-up
 	</script>
</body>
</html>

