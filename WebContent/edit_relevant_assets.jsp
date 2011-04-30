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
	  if ( input.relevant_assets_type.value == "" ||
			input.relevant_assets_file.value == "" )
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

		String relevanct_assetQuery = "select * from relevant_asset where asset_name = '" + asset_name +"'";
		
		// 3. SQL execute(select table)
		// asset
		rs = stmt.executeQuery(relevanct_assetQuery);
%>	
		<form id = "input" method="get" action="x_edit_relevant_assets.jsp" onSubmit="JavaScript:return CheckFields(this)" enctype="text/plain">
		<p><b>Add Relevant Assets information</b></p>
		<table width = "800" cellspacing = "0" cellpadding = "0" border = "1" >
		<tbody>
		<tr >
			<td class="label required">Type : </td>
			<td class="required"><select
				name="relevant_assets_type"
				id="relevant_assets_type" >
					<option value="">-- Choose from List --</option>
					<option value="srs">SRS</option>
					<option value="sdd">SDD</option>
					<option value="manual">Manual</option>
					<option value="binary_file">Binary file</option>
					<option value="test_documents">Test Documents</option>
			</select>
			</td>
			<td class="label required">File to upload:</td>
			<td class="required"><input type="file"
				name="relevant_assets_file" size="50" id="relevant_assets_file" >
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

