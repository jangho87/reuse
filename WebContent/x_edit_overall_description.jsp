<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%!
	String asset_name;
	String overall_description;
	String overall_description_file;
%>
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

			if ( name.equals("overall_description_file") == true ){
				overall_description_file = multi.getOriginalFileName(name);
		    } else {
					out.println("none file type!");
			}
		 }
		while( params.hasMoreElements()){
			String name = params.nextElement();
			if( name.equals("asset_name") == true ){
				asset_name = multi.getParameter(name);
			} else if ( name.equals("overall_description") == true ){
				overall_description = multi.getParameter(name);
			} else {
				out.println("none file type!");	
			}
		}
		out.println("overall_description: " + overall_description);
		out.println("overall_description_file: " + overall_description_file);
		
		int updatecount = 0;
		if( overall_description_file != null ){
			updatecount = stmt.executeUpdate("UPDATE asset SET overall_description = '"+ overall_description +"'," + " overall_description_file = '" + overall_description_file + "' WHERE asset_name = '" + asset_name + "'"); 
		} else {
			updatecount = stmt.executeUpdate("UPDATE asset SET overall_description = '"+ overall_description +"' WHERE asset_name = '" + asset_name + "'"); 
		}
		out.println("updatecount : " + updatecount);
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

