<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Modify interface page</title>
<%
request.setCharacterEncoding("euc-kr");
String asset_name = request.getParameter("asset_name");	
%>
<script type="text/javascript">
function CheckFields(pform) {
	// 공백란 체크
	  if ( input.required_interface.value == "" ||
			  input.provided_interface.value == "" ||
			  input.interface_upload.value == "" )
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

		String interfaceQuery = "select * from interface where asset_name = '" + asset_name +"'";
		
		// 3. SQL execute(select table)
		// interface
		rs = stmt.executeQuery(interfaceQuery);
		if( rs.next())
		{
			String required_interface = rs.getString("required_interface");
			String provided_interface = rs.getString("provided_interface");
			String interface_upload = rs.getString("interface_upload");
%>
	<form id = "input" method="post" action="x_edit_interfaces.jsp" onSubmit="JavaScript:return CheckFields(this)" enctype="multipart/form-data">
		<p><b>Edit interface information</b></p>
		<table width = "500" cellspacing = "0" cellpadding = "0" border = "1" >
		<tr >
			<td>Required interface :</td>
			<td><input type="text" name="required_interface" size="50" id="required_interface" value="<%=required_interface %>"></td>
		</tr>
		<tr>
			<td>Provided interface :</td>
			<td><input type="text" name="provided_interface" size="50" id="provided_interface" value="<%=provided_interface %>"></td>
		</tr>
		<tr>
			<td>Interface upload file</td>
			<td><input type="file" name="interface_upload" size="50" id="interface_upload" value="<%=interface_upload %>"></td>
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

