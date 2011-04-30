<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="org.apache.catalina.connector.Request"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.sql.*" %>
<%!
	// 일단 절대 경로 이용(Server 설치시 변경)
	String filepath = "C:\\Users\\daehee\\workspace\\reuse\\WebContent\\files\\";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Expires" content="-1"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Cache-Control" content="No-Cache"/>
<meta http-equiv="content-type" content="text/html; charset=euc-kr"/>
<%
 //로그인 했는지 확인
 if(session.getAttribute("user")==null){
%>
 <script>
  //location.href("/login/Login.jsp");
 </script>
<%}%>
<title>View reuse page</title>
<script type="text/javascript">
function edit_overall_description(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_overall_description.jsp" + "?" + param.join("&");
	window.open(URL, "edit_overall_description","top=100px, left=100px, height=300px, width=800px, menubar=no, status=no, toolbar=no");
}

function edit_domain(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_domain.jsp" + "?" + param.join("&");
	window.open(URL, "edit_domain","top=100px, left=100px, height=300px, width=800px, menubar=no, status=no, toolbar=no");
}

function edit_project(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_project.jsp" + "?" + param.join("&");
	window.open(URL, "edit_project","top=100px, left=100px, height=300px, width=800px, menubar=no, status=no, toolbar=no");
}

function edit_relevant_assets(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_relevant_assets.jsp" + "?" + param.join("&");
	window.open(URL, "edit_relevant_assets","top=100px, left=100px, height=300px, width=900px, menubar=no, status=no, toolbar=no");
}

function edit_interfaces(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_interfaces.jsp" + "?" + param.join("&");
	window.open(URL, "edit_interfaces","top=100px, left=100px, height=300px, width=800px, menubar=no, status=no, toolbar=no");
}

function edit_version(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_version.jsp" + "?" + param.join("&");
	window.open(URL, "edit_version","top=100px, left=100px, height=300px, width=800px, menubar=no, status=no, toolbar=no");
}

function edit_operation_environment(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_operation_environment.jsp" + "?" + param.join("&");
	window.open(URL, "edit_operation_environment","top=100px, left=100px, height=300px, width=900px, menubar=no, status=no, toolbar=no");
}

function edit_required_libraries(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_required_libraries.jsp" + "?" + param.join("&");
	window.open(URL, "edit_required_libraries","top=100px, left=100px, height=300px, width=900px, menubar=no, status=no, toolbar=no");
}

function edit_reuse_guidance(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_reuse_guidance.jsp" + "?" + param.join("&");
	window.open(URL, "edit_reuse_guidance","top=100px, left=100px, height=300px, width=900px, menubar=no, status=no, toolbar=no");
}

function edit_related_knowledge(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_related_knowledge.jsp" + "?" + param.join("&");
	window.open(URL, "edit_related_knowledge","top=100px, left=100px, height=300px, width=900px, menubar=no, status=no, toolbar=no");
}

function edit_alternative_assets(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_alternative_assets.jsp" + "?" + param.join("&");
	window.open(URL, "edit_alternative_assets","top=100px, left=100px, height=300px, width=900px, menubar=no, status=no, toolbar=no");
}

function edit_problem(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_problem.jsp" + "?" + param.join("&");
	window.open(URL, "edit_problem","top=100px, left=100px, height=300px, width=900px, menubar=no, status=no, toolbar=no");
}

function edit_reuse_history(){
    var asset_name = document.getElementById("asset_name").value;
	var param = new Array();
	param.push("asset_name="+asset_name);
	
	var URL = "edit_reuse_history.jsp" + "?" + param.join("&");
	window.open(URL, "edit_reuse_history","top=100px, left=100px, height=300px, width=900px, menubar=no, status=no, toolbar=no");
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
	//filepath = request.getContextPath() + "/files/";
	try {
		// 1.JDBC Drive loading
		Class.forName("org.gjt.mm.mysql.Driver");
		// 2. Connection to DB
		conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		stmt = conn.createStatement();
		request.setCharacterEncoding("euc-kr");
		String asset_name = request.getParameter("asset_name");
		
		String assetQuery = "select * from asset where asset_name = '" + asset_name +"'";
		String domainQuery = "select * from domain where asset_name = '" + asset_name +"'";
		String projectQuery = "select * from project where asset_name = '" + asset_name +"'";
		String relevanct_assetQuery = "select * from relevant_asset where asset_name = '" + asset_name +"'";
		String interfaceQuery = "select * from interface where asset_name = '" + asset_name +"'";
		String versionQuery = "select * from version where asset_name = '" + asset_name +"'";
		String operation_environmentQuery = "select * from operation_environment where asset_name = '" + asset_name +"'";
		String required_librariesQuery = "select * from required_libraries where asset_name = '" + asset_name +"'";
		String reuse_guidanceQuery = "select * from reuse_guidance where asset_name = '" + asset_name +"'";
		String related_knowledgeQuery = "select * from related_knowledge where asset_name= '" + asset_name +"'";
		String alternatives_assetQuery = "select * from alternatives_asset where asset_name = '" + asset_name +"'";
		String problemQuery = "select * from problem where asset_name = '" + asset_name +"'";
		String reuse_historyQuery = "select * from reuse_history where asset_name = '" + asset_name +"'";
		
		// 3. SQL execute(select table)
		// asset
		rs = stmt.executeQuery(assetQuery);
		if( !rs.next())
		{
			out.println("There is no reuse information. Go to create page!");
			response.sendRedirect("error.html");
		} else {
			String overall_description = rs.getString("overall_description");
			// TO DO LIST
			String overall_description_file = rs.getString("overall_description_file");
%>
		<center>
			<h2><%= rs.getString("asset_name") %></h2>
		</center>
		<input type="hidden" name="asset_name" id="asset_name" value="<%= rs.getString("asset_name") %>">
		<table class="info_table" width=100% border="1">
			<tr>
				<td>
		 			<div> <b>Description</b></div>
					<table class="asset_form" id="asset_form" width="100%" border="1">
						<tbody>
							<tr class="section">
								<td colspan="2"><b>Overall Description</b><input type='button' value='Edit' onclick = 'edit_overall_description();'></td>
							</tr>
							<tr valign="top" height="100px">
								<td class="required" width="70%"><%= overall_description %></td>
<%
		if( overall_description_file.length() != 0 )
		{
%>
			<td class="required"><img src="<%= filepath + overall_description_file %> " id="overall_description_file" ></td>
<%
}
%> 
							</tr>
						</tbody>
					</table>
<%
		}
		// domain
		rs = stmt.executeQuery(domainQuery);
%>		
					<table class="domain_form" width=100% border="1">
						<tbody>
							<tr class="section">
								<td colspan="2"><b>Domain</b><input type='button' value='Edit' onclick = 'edit_domain();'></td>
							</tr>
<%
		if( rs.next() )
		{
             String domain_type = rs.getString("domain_type");
             String domain_name = rs.getString("domain_name");
%>
							<tr valign="top">
								<td class="label required" width="30%">Type :<%= domain_type %> </td>
								<td class="label required" >Domain Name : <span id = "domain_name"><%= domain_name %></span> </td>
							</tr>
<%             
		 }
%>
						</tbody>
					</table>
					<table class="project_form" width=100% border="1">
						<tbody>
							<tr class="section">
								<td colspan="2"><b>Project</b><input type='button' value='Edit' onclick = 'edit_project();'></td>
							</tr>
<%
		// project
		rs = stmt.executeQuery(projectQuery);
		 if(rs.next()){
             String project_name = rs.getString("project_name");
             String project_description = rs.getString("project_description");
             String project_institute = rs.getString("project_institute");
             String project_duration = rs.getString("project_duration");
%>
							<tr valign="top">
								<td class="label required" width="50%">Name :<%= project_name %> </td>
								<td class="label required" width="50%">Descriptions : <%= project_description %></td>
							</tr>
							<tr valign="top">
								<td class="label required">Institute :<%= project_institute %> </td>
								<td class="label required">Durations : <%= project_duration %></td>
							</tr>
<%             
		 }
%>
						</tbody>
					</table>
					<table class="relevant_form" width=100% border="1">
						<tbody>
							<tr class="section">
								<td colspan="2"><b>Relevant Assets</b><input type='button' value='Add' onclick = 'edit_relevant_assets();'></td>
							</tr>
<%
		// relevant assets
		rs = stmt.executeQuery(relevanct_assetQuery);
		while(rs.next()){
    		String relevanct_asset_type = rs.getString("relevanct_asset_type");
    		String relevanct_asset_file = rs.getString("relevanct_asset_file");
%>
							<tr valign="top">
								<td class="label required" width="30%">Name :<%= relevanct_asset_type %> </td>
								<td class="label required" >Descriptions : <a href="file_down.jsp?file_name=<%=relevanct_asset_file%>"><%=relevanct_asset_file%></a></td>
							</tr>
<%
}
%>			
						</tbody>
					</table>
					
					<table class="interface_form" width=100% border="1">
						<tbody>
							<tr class="section">
								<td colspan="3"><b>Interfaces</b><input type='button' value='Edit' onclick = 'edit_interfaces();'></td>
							</tr>					
<%		
		// interface
		rs = stmt.executeQuery(interfaceQuery);
		while(rs.next()){
    		String required_interface = rs.getString("required_interface");
    		String provided_interface = rs.getString("provided_interface");
    		String interface_upload = rs.getString("interface_upload");
%> 
							<tr valign="top">
								<td class="label required" >Required Interface :<%= required_interface %> </td>
								<td class="label required" >Provided Interface : <%= provided_interface %></td>
<%
		if( interface_upload.length() != 0 )
		{
%>
			<td class="label required" ><img src="<%= filepath + interface_upload %>" ></td>
<%
}
%> 								
								
							</tr>
<%
}
%>
						</tbody>
					</table>
					<table class="version_form" width=100% border="1">
						<tbody>
							<tr class="section">
								<td colspan="3"><b>Version</b><input type='button' value='Edit' onclick = 'edit_version();'></td>
							</tr>					
<%		
		// version
		rs = stmt.executeQuery(versionQuery);
		while(rs.next()){
    		String version_name = rs.getString("version_name");
%> 
							<tr valign="top">
								<td class="label required">Name :<a href="file_down.jsp?file_name=<%=version_name%>"><%=version_name%></a></td>
							</tr>
<%
}
%>
						</tbody>
					</table>
					
					<table class="operation_form" width=100% border="1">
						<tbody>
							<tr class="section">
								<td colspan="3"><b>Operation Environment</b><input type='button' value='Edit' onclick = 'edit_operation_environment();'></td>
							</tr>
<%		
		// operation_environmentQuery
		rs = stmt.executeQuery(operation_environmentQuery);
		while(rs.next()){
    		String operation_env_pro_lang = rs.getString("operation_env_pro_lang");
    		String operation_env_oper_system = rs.getString("operation_env_oper_system");
    		String operation_env_minimal_hw_spec = rs.getString("operation_env_minimal_hw_spec");
    		String operation_env_compatible = rs.getString("operation_env_compatible");
%> 
							<tr valign="top">
								<td class="required" >Programming language : <%= operation_env_pro_lang %> </td>
								<td class="required" >Operating system : <%= operation_env_oper_system %></td>
							</tr>
							<tr valign="top">
								<td class="required" >Minimal HW spec : <%= operation_env_minimal_hw_spec %> </td>
								<td class="required" >Compatible : <%= operation_env_compatible %></td>
							</tr>
<%
}
%>
						</tbody>
					</table>
					<table class="library_form" width=100% border="1">
						<tbody>
							<tr class="section">
								<td colspan="3"><b>Required Libraries</b><input type='button' value='Edit' onclick = 'edit_required_libraries();'></td>
							</tr>
						
<%		
		// Required Libraries
		rs = stmt.executeQuery(required_librariesQuery);
		while(rs.next()){
    		String required_libraries_name = rs.getString("required_libraries_name");
%> 
							<tr valign="top">
								<td class="label required">Name :<%= required_libraries_name %> </td>
							</tr>
<%
}
%>
						</tbody>
					</table>
					<div> <b> Reuse Knowledge</b> </div>
					<table class="knowledge_form" width=100% border="1">
						<tbody>
							<tr class="section">
								<td colspan="3"><b>Reuse Guidance</b><input type='button' value='Add' onclick = 'edit_reuse_guidance();'></td>
							</tr>					
<%
		// Reuse Guidance
		rs = stmt.executeQuery(reuse_guidanceQuery);
		while(rs.next()){
    		String reuse_guidance_type = rs.getString("reuse_guidance_type");
    		String reuse_guidance_link = rs.getString("reuse_guidance_link");
%> 
							<tr valign="top">
								<td class="label required" >Type :<%= reuse_guidance_type %> </td>
								<td class="label required" >Link :<%= reuse_guidance_link %> </td>
							</tr>
<%
}
%>
						</tbody>
					</table>
					<table class="related_form" width=100% border="1">
						<tbody>
							<tr class="section">
								<td colspan="0"><b>Related knowledge</b><input type='button' value='Edit' onclick = 'edit_related_knowledge();'></td>
							</tr>
<%		
		// Related Knowledge
		rs = stmt.executeQuery(related_knowledgeQuery);
		while(rs.next()){
    		String related_knowledge_name = rs.getString("related_knowledge_name");
%> 
							<tr valign="top">
								<td class="label required">Name :<%= related_knowledge_name %> </td>
							</tr>
<%
}
%>
						</tbody>
					</table>
					<table class="alternative_form" width=100% border="1">
						<tbody>
							<tr class="section">
								<td colspan="2"><b>Alternative Assets</b><input type='button' value='Add' onclick = 'edit_alternative_assets();'></td>
							</tr>
<%		
		// Alternative asset
		rs = stmt.executeQuery(alternatives_assetQuery);
		while(rs.next()){
    		String alternatives_asset_type = rs.getString("alternatives_asset_type");
    		String alternatives_asset_files = rs.getString("alternatives_asset_files");
%> 
							<tr valign="top">
								<td class="label required" >Type :<%= alternatives_asset_type %> </td>
								<td class="label required" >File :<a href="file_down.jsp?file_name=<%=alternatives_asset_files%>"><%=alternatives_asset_files%></a></td>
							</tr>
<%
}
%>
						</tbody>
					</table>
					<table class="problem_form" width=100% border="1">
						<tbody>
							<tr class="section">
								<td colspan="3"><b>Problem</b><input type='button' value='Add' onclick = 'edit_problem();'></td>
							</tr>						
<%		
		// Problem
		rs = stmt.executeQuery(problemQuery);
		while(rs.next()){
    		String problem_type = rs.getString("problem_type");
    		String problem_subtype = rs.getString("problem_subtype");
    		String problem_detail_description = rs.getString("problem_detail_description");
%> 
							<tr valign="top">
								<td class="label required" >Type :<%= problem_type %> </td>
								<td class="label required" >SubType :<%= problem_subtype %> </td>
								<td class="label required" >Detail Description :<%= problem_detail_description %> </td>
							</tr>
<%
}
%>
						</tbody>
					</table>
					<table class="history_form" width=100% border="1">
						<tbody>
							<tr class="section">
								<td colspan="3"><b>Reuse history</b><input type='button' value='Edit' onclick = 'edit_reuse_history();'/></td>
							</tr>						
<%		
		// Reuse history
		rs = stmt.executeQuery(reuse_historyQuery);
		while(rs.next()){
    		int reuse_history_count = rs.getInt("reuse_history_count");
    		String reuse_history_domain = rs.getString("reuse_history_domain");
    		String reuse_history_project = rs.getString("reuse_history_project");
%> 
							<tr valign="top">
								<td class="label required" >Reuse count :<%= reuse_history_count %> </td>
								<td class="label required" >Reuse Domain :<%= reuse_history_domain %> </td>
								<td class="label required" >Reuse Project :<%= reuse_history_project %> </td>
							</tr>
<%
}
%>
						</tbody>
					</table>
<%
	} catch(Exception e) {
		out.println(e.getMessage());
	} finally {
		if( stmt != null ) try{ stmt.close(); } catch(SQLException e){}
		if( conn != null ) try{ conn.close(); } catch(SQLException e){}
	}
%>
			</td>
		</tr>
	</table>
</body>
</html>