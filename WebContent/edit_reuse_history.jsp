<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Modify overall description page</title>
<%
request.setCharacterEncoding("euc-kr");
String asset_name = request.getParameter("asset_name");	
%>
<script type="text/javascript">
function CheckFields(pform) {
	// 공백란 체크
	  if ( input.reuse_history_domain.value == "" ||
			  input.reuse_history_project.value == "" )
		{
	     alert( "Please check your information." );
	     return false;
		}
     return true;
}

</script>
</head>
<body>
<%
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

		String Query = "select * from reuse_history where asset_name = '" + asset_name +"'";
		
		// 3. SQL execute(select table)
		// 
		rs = stmt.executeQuery(Query);
		String reuse_history_domain = null;
		String reuse_history_project = null;
		if( rs.next()) {
			reuse_history_domain = rs.getString("reuse_history_domain");
			reuse_history_project = rs.getString("reuse_history_project");
		}
%>
	<form id = "input" method="get" action="x_edit_reuse_history.jsp" onSubmit="JavaScript:return CheckFields(this)" enctype="text/plain">
		<p><b>Edit Reuse history information</b></p>
		<table width = "500" cellspacing = "0" cellpadding = "0" border = "1" >
		<tr>
			<td>Reuse Domain</td><td><input type="text" name="reuse_history_domain" size="50" id="reuse_history_domain" value="<%=reuse_history_domain %>"></td>
		</tr>			
		<tr>
			<td>Reuse Project</td><td><input type="text" name="reuse_history_project" size="50" id="reuse_history_project" value="<%=reuse_history_project %>"></td>
		</tr>
		</table>
		<br/>
		<input type="hidden" name="asset_name" id="asset_name" value="<%=asset_name %>">
		<input type="submit" value="Submit form" style="height: 25px; width: 100px" > 
	</form>
<%		
	} finally {
		
	}
%>
</body>
</html>

