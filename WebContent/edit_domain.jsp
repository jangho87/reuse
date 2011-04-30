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

		String domainQuery = "select * from domain where asset_name = '" + asset_name +"'";
		
		// 3. SQL execute(select table)
		// asset
		rs = stmt.executeQuery(domainQuery);
%>	
		<form id = "input" method="get" action="x_edit_domain.jsp" onSubmit="JavaScript:return CheckFields(this)" enctype="text/plain">
		<p><b>Edit domain information</b></p>
	
<%			
		if( rs.next())
		{
			String domain_type = rs.getString("domain_type");
			String domain_name = rs.getString("domain_name");
%>
		<table width = "500" cellspacing = "0" cellpadding = "0" border = "1" >
		<tbody>
		<tr >
			<td class="label required">Type : </td>
			<td class="required"><select
				name="domain_type"
				id="domain_type" >
					<option value="">-- Choose from List --</option>
					<option value="http_server">HTTP server</option>
					<option value="ftp_server">FTP server</option>
					<option value="indexing_search">Indexing / Search</option>
					<option value="semantic_web">--Semantic web</option>
					<option value="site_management">Site management</option>
					<option value="webpage_management">--Web page management</option>
					<option value="database_management">--Database management</option>
					<option value="rss">--RSS</option>
					<option value="browsers">Browsers</option>
					<option value="plugin_addons">--Plugins and add-ons</option>
					<option value="Dynamic_contents">Dynamic contents</option>
					<option value="page_countes">--Page Counters</option>
					<option value="wikis">--Wikis</option>
					<option value="message_boards">--Message Boards</option>
					<option value="blogging">--Blogging</option>
					<option value="cgitools_libraries">--CGI Tools / Libraries</option>
					<option value="social_networking">--Social Networking</option>
					<option value="cms_systems">--CMS Systems</option>
					<option value="groupsware">--Groupsware</option>
					<option value="ticketing_system">--Ticketing Systems</option>																																	
					<option value="user_interfaces">User interfaces</option>
					<option value="usability">Usability</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Domain name</td>
			<td><input type="text" name="domain_name" size="50" id="domain_name" value="<%=domain_name %>"></td>
		</tr>
		</tbody>
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

