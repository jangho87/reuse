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
	  if ( input.overall_description.value == "" )
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

		String assetQuery = "select * from asset where asset_name = '" + asset_name +"'";
		
		// 3. SQL execute(select table)
		// asset
		rs = stmt.executeQuery(assetQuery);
		if( !rs.next())
		{
			out.println("There is no reuse information. Go to create page!");
			%>
			<jsp:forward page="reuse_mainframe_noframe.html"></jsp:forward>
			<%
		} else {
			String overall_description = rs.getString("overall_description");
			// TO DO LIST
			String overall_description_file = rs.getString("overall_description_file");
			//String overall_description_file = "0";
%>
	<form id = "input" method="post" action="x_edit_overall_description.jsp" onSubmit="JavaScript:return CheckFields(this)" enctype="multipart/form-data">
		<p><b>Edit overall information</b></p>
		<table width = "500" cellspacing = "0" cellpadding = "0" border = "1" >
		<tr >
			<td>overall description (*)</td>
			<td><input type="text" name="overall_description" size="50" id="overall_description" value="<%=overall_description %>"></td>
		</tr>
		<tr>
			<td>overall description file</td>
			<td><input type="file" name="overall_description_file" size="50" id="overall_description_file" ></td>
		</tr>
		</table>
		<br/>
		<input type="hidden" name="asset_name" id="asset_name" value="<%=asset_name %>">
		<input type="submit" value="Submit form" style="height: 25px; width: 100px" > 
	</form>
<%
		}
	} finally {
		
	}
%>
</body>
</html>

