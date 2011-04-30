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
	  if ( input.project_name.value == "" ||
			input.project_description.value == "" ||
			input.project_institute.value == "" ||
			input.project_duration.value == "" )
		{
	     alert( "Please check your information" );
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

		String projectQuery = "select * from project where asset_name = '" + asset_name +"'";
		
		// 3. SQL execute(select table)
		// asset
		rs = stmt.executeQuery(projectQuery);
%>	
		<form id = "input" method="get" action="x_edit_project.jsp" onSubmit="JavaScript:return CheckFields(this)" enctype="text/plain">
		<p><b>Edit project information</b></p>
	
<%			
		if( rs.next())
		{
			String project_name = rs.getString("project_name");
			String project_description = rs.getString("project_description");
			String project_institute = rs.getString("project_institute");
			String project_duration = rs.getString("project_duration");
%>
		<table width = "500" cellspacing = "0" cellpadding = "0" border = "1" >
		<tbody>
		<tr >
			<td>Name</td>
			<td><input type="text" name="project_name" size="50" id="project_name" value="<%=project_name %>"></td>
			<td>Description</td>
			<td><input type="text" name=project_description size="50" id="project_description" value="<%=project_description %>"></td>
		</tr>
		<tr>
			<td>Institute</td>
			<td><input type="text" name="project_institute" size="50" id="project_institute" value="<%=project_institute %>"></td>
			<td>Duration</td>
			<td><input type="text" name="project_duration" size="50" id="project_duration" value="<%=project_duration %>"></td>
		</tr>
		</tbody>
		</table>
		<input type="hidden" name="asset_name" id="asset_name" value="<%=asset_name %>">
		<input type="submit" value="Submit form" style="height: 25px; width: 100px" > 
		<br/>
	</form>
<%
		}
	} finally {
		
	}
%>
</body>
</html>

