<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%!
	String asset_name;
	String required_interface;
	String provided_interface;
	String interface_upload;

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Modify interface page</title>
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
	//request.setCharacterEncoding("euc-kr");

	String DB_URL = "jdbc:mysql://localhost/reuse";
	String DB_USER="root";
	String DB_PASSWORD="qwer1234";
	String SAVE_PATH = "C:\\Users\\daehee\\workspace\\reuse\\WebContent\\files";
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		// 1.JDBC Drive loading
		Class.forName("org.gjt.mm.mysql.Driver");
		
		// 2. Connection to DB
		conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		stmt = conn.createStatement();
		
		String charset = "euc-kr";
		int maxSize = 1024*1024*1024;
		MultipartRequest multi = null;
		multi = new MultipartRequest(request, SAVE_PATH, maxSize, charset, new DefaultFileRenamePolicy());

		Enumeration<String> params = multi.getParameterNames();
		Enumeration<String> files = multi.getFileNames();

		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			String filename1 = multi.getFilesystemName(name);
			String original1 = multi.getOriginalFileName(name);
			String contentType = multi.getContentType(name);

			if ( name.equals("interface_upload") == true ){
				interface_upload = multi.getOriginalFileName(name);
		    } else {
					out.println("none file type!");
			}
		 }
		while( params.hasMoreElements()){
			String name = params.nextElement();
			if( name.equals("asset_name") == true ){
				asset_name = multi.getParameter(name);
			} else if ( name.equals("required_interface") == true ){
				required_interface = multi.getParameter(name);
			} else if ( name.equals("provided_interface") == true ){
				required_interface = multi.getParameter(name);
			} else {
				out.println("none file type!");	
			}
		}
		
		//out.println("required_interface: " + required_interface);
		//out.println("required_interface: " + required_interface);
		//out.println("interface_upload: " + interface_upload);
		
		int updatecount = 0;
		updatecount = stmt.executeUpdate("UPDATE interface SET required_interface = '"+ required_interface +"'," + " provided_interface = '" + provided_interface + "'," + " interface_upload = '" + interface_upload +"' WHERE asset_name = '" + asset_name + "'");
		//out.println("updatecount : " + updatecount);
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

