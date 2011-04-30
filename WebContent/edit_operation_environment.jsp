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
	  if ( input.operation_env_pro_lang.value == "" ||
			input.operation_env_oper_system.value == "" ||
			input.operation_env_minimal_hw_spec.value == "" ||
			input.operation_env_compatible.value == "" )
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

		String operationenvironmentQuery = "select * from operation_environment where asset_name = '" + asset_name +"'";
		
		// 3. SQL execute(select table)
		// operation environment
		rs = stmt.executeQuery(operationenvironmentQuery);
%>	
		<form id = "input" method="get" action="x_edit_operation_environment.jsp" onSubmit="JavaScript:return CheckFields(this)" enctype="text/plain">
		<p><b>Edit Operation Environment information</b></p>
<%			
		if( rs.next())
		{
			String operation_env_pro_lang = rs.getString("operation_env_pro_lang");
			String operation_env_oper_system = rs.getString("operation_env_oper_system");
			String operation_env_minimal_hw_spec = rs.getString("operation_env_minimal_hw_spec");
			String operation_env_compatible = rs.getString("operation_env_compatible");
%>
		<table width = "500" cellspacing = "0" cellpadding = "0" border = "1" >
		<tbody>
		<tr >
			<td>Programming Language</td>
			<td><input type="text" name="operation_env_pro_lang" size="30" id="operation_env_pro_lang" value="<%=operation_env_pro_lang %>"></td>
			<td>Operating System</td>
			<td><input type="text" name=operation_env_oper_system size="30" id="operation_env_oper_system" value="<%=operation_env_oper_system %>"></td>
		</tr>
		<tr>
			<td>Minimal HW spec</td>
			<td><input type="text" name="operation_env_minimal_hw_spec" size="30" id="operation_env_minimal_hw_spec" value="<%=operation_env_minimal_hw_spec %>"></td>
			<td>Compatible</td>
			<td><input type="text" name="operation_env_compatible" size="30" id="operation_env_compatible" value="<%=operation_env_compatible %>"></td>
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

