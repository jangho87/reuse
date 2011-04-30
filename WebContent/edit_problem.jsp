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
	  if ( input.problem_type.value == "" ||
			  input.problem_subtype.value == "" ||
			  input.problem_detail_description.value == "" )
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

		String Query = "select * from problem where asset_name = '" + asset_name +"'";
		
		// 3. SQL execute(select table)
		// asset
		rs = stmt.executeQuery(Query);
%>	
		<form id = "input" method="get" action="x_edit_problem.jsp" onSubmit="JavaScript:return CheckFields(this)" enctype="text/plain">
		<p><b>Add Problem information</b></p>
		<table width = "800" cellspacing = "0" cellpadding = "0" border = "1" >
		<tbody>
		<tr >
			<td class="label required">Type :</td>
			<td class="required"><select
				name="problem_type" id="problem_type" >
					<option value="">-- Choose from List --</option>
					<option value="reliability">Reliability</option>
					<option value="compatibility">Compatibility</option>
					<option value="interoperability">Interoperability</option>
					<option value="incompleteness">Incompleteness</option>
					<option value="visualization">Visualization</option>
			</select>
			</td>
			<td class="label required">Sub type:</td>
			<td class="required"><select
				name="problem_subtype"
				id="problem_subtype" >
					<option value="">-- Choose from List --</option>
					<option value="control_problem">Control problem</option>
					<option value="code_failure">Code failure</option>
					<option value="function_failure">Function failure</option>
					<option value="">------------------</option>
					<option value="domain_constraint">Domain constraint</option>
					<option value="environmental_constraints">Environmental constraints</option>
					<option value="version_problem">Version problem</option>
					<option value="interface_problem">Interface problem</option>
					<option value="standardization_problem">Standardization problem</option>
					<option value="">------------------</option>
					<option value="dependency_problem">Dependency problem</option>
					<option value="version_problem">Version problem</option>
					<option value="interface_problem">Interface problem</option>
					<option value="message_problem">Message problem</option>
					<option value="synchronization_problem">Synchronization problem</option>
					<option value="">------------------</option>
					<option value="incomplete_package">Incomplete package</option>
					<option value="incomplete_function">Incomplete function</option>
					<option value="">------------------</option>
					<option value="readability">Readability</option>
					<option value="usability">Usability</option>
			</select>
			</td>
			<td class="label required">Detail description</td>
			<td class="required"><input type="text"
				name="problem_detail_description" size="60" id="problem_detail_description" >
			</td>
		</tr>
		</tbody>
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

