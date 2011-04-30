<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileUpload" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%!String asset_name;
	String overall_description;
	String overall_description_file = "";

	String domain_type;
	String domain_name;

	String project_name;
	String project_description;
	String project_institute;
	String project_duration;

	String relevant_assets_type;
	String relevant_assets_file = "";

	String required_interfaces;
	String provided_interfaces;
	String interfaces_image = "";

	String version_file = "";

	String operation_env_program_language;
	String operation_env_operating_system;
	String operation_env_minimal_hw_spec;
	String operation_env_compatible;

	String required_libraries;

	String reuse_guidance_type;
	String reuse_guidance_link;

	String related_knowledge;

	String alternatives_assets_type;
	String alternatives_assets_file = "";

	String problem_type;
	String problem_subtype;
	String problem_detail_description;

	String reuse_history_count;
	String reuse_history_domain;
	String reuse_history_project;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<%
	//로그인 했는지 확인
	if (session.getAttribute("user") == null) {
%>
 <script>
  //location.href("/login/Login.jsp");
 </script>
<%
	}
%>

<title>Insert title here</title>
</head>
<body>

<%
	// No cache configuration for test
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");

	// input type=file value reset for refresh action
	overall_description_file = "";
	relevant_assets_file = "";
	interfaces_image = "";
	version_file = "";
	alternatives_assets_file = "";

	String DB_URL = "jdbc:mysql://localhost/reuse";
	String DB_USER = "root";
	String DB_PASSWORD = "qwer1234";
	String SAVE_PATH = "C:\\Users\\daehee\\workspace\\reuse\\WebContent\\files";

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		// 1.JDBC Drive loading
		Class.forName("org.gjt.mm.mysql.Driver");

		// 2. Connection to DB
		conn = DriverManager
				.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		stmt = conn.createStatement();

		String charset = "euc-kr";
		int maxSize = 1024 * 1024 * 1024;

		MultipartRequest multi = null;
		multi = new MultipartRequest(request, SAVE_PATH, maxSize,
				charset, new DefaultFileRenamePolicy());

		Enumeration<String> params = multi.getParameterNames();
		Enumeration<String> files = multi.getFileNames();

		try {
			while (files.hasMoreElements()) {
				String name = (String) files.nextElement();
				String filename1 = multi.getFilesystemName(name);
				String original1 = multi.getOriginalFileName(name);
				String contentType = multi.getContentType(name);
				out.println("name:" + name + "<br>");
				out.println("file:" + filename1 + "<br>");
				out.println("orig:" + original1 + "<br>");
				out.println("content:" + contentType + "<br>");
				out.println("----------------------------<br>");

				if ((filename1 != null) && (filename1.length() != 0)) {
					if (name.equals("overall_description_file") == true) {
						overall_description_file = multi
								.getFilesystemName(name);
					} else if (name.equals("relevant_assets_file") == true) {
						relevant_assets_file = multi
								.getFilesystemName(name);
					} else if (name.equals("version_file") == true) {
						version_file = multi.getFilesystemName(name);
					} else if (name.equals("alternatives_assets_file") == true) {
						alternatives_assets_file = multi
								.getFilesystemName(name);
					} else if (name.equals("interfaces_image") == true) {
						interfaces_image = multi
								.getFilesystemName(name);
					} else {
						out.println("none file type!<br>");
					}
				}
			}

			while (params.hasMoreElements()) {
				String name = params.nextElement();
				if (name.equals("asset_name") == true) {
					asset_name = multi.getParameter(name);
				} else if (name.equals("overall_description") == true) {
					overall_description = multi.getParameter(name);
				} else if (name.equals("domain_type") == true) {
					domain_type = multi.getParameter(name);
				} else if (name.equals("domain_name") == true) {
					domain_name = multi.getParameter(name);
				} else if (name.equals("project_name") == true) {
					project_name = multi.getParameter(name);
				} else if (name.equals("project_description") == true) {
					project_description = multi.getParameter(name);
				} else if (name.equals("project_institute") == true) {
					project_institute = multi.getParameter(name);
				} else if (name.equals("project_duration") == true) {
					project_duration = multi.getParameter(name);
				} else if (name.equals("relevant_assets_type") == true) {
					relevant_assets_type = multi.getParameter(name);
				} else if (name.equals("required_interfaces") == true) {
					required_interfaces = multi.getParameter(name);
				} else if (name.equals("provided_interfaces") == true) {
					provided_interfaces = multi.getParameter(name);
				} else if (name
						.equals("operation_env_program_language") == true) {
					operation_env_program_language = multi
							.getParameter(name);
				} else if (name
						.equals("operation_env_operating_system") == true) {
					operation_env_operating_system = multi
							.getParameter(name);
				} else if (name.equals("operation_env_minimal_hw_spec") == true) {
					operation_env_minimal_hw_spec = multi
							.getParameter(name);
				} else if (name.equals("operation_env_compatible") == true) {
					operation_env_compatible = multi.getParameter(name);
				} else if (name.equals("required_libraries") == true) {
					required_libraries = multi.getParameter(name);
				} else if (name.equals("reuse_guidance_type") == true) {
					reuse_guidance_type = multi.getParameter(name);
				} else if (name.equals("reuse_guidance_link") == true) {
					reuse_guidance_link = multi.getParameter(name);
				} else if (name.equals("related_knowledge") == true) {
					related_knowledge = multi.getParameter(name);
				} else if (name.equals("alternatives_assets_type") == true) {
					alternatives_assets_type = multi.getParameter(name);
				} else if (name.equals("problem_type") == true) {
					problem_type = multi.getParameter(name);
				} else if (name.equals("problem_subtype") == true) {
					problem_subtype = multi.getParameter(name);
				} else if (name.equals("problem_detail_description") == true) {
					problem_detail_description = multi
							.getParameter(name);
				} else if (name.equals("reuse_history_count") == true) {
					//reuse_history_count = 0;
				} else if (name.equals("reuse_history_domain") == true) {
					reuse_history_domain = multi.getParameter(name);
				} else if (name.equals("reuse_history_project") == true) {
					reuse_history_project = multi.getParameter(name);
				} else {
					String value = multi.getParameter(name);
					out.println(name + ":" + value);
				}

			}

			// 3. SQL execute(insert table)
			out.println("asset_name:" + asset_name + "<br>");
			out.println("overall_description:" + overall_description
					+ "<br>");
			out.println("overall_description_file:"
					+ overall_description_file + "<br>");

			out.println("domain_type:" + domain_type + "<br>");
			out.println("domain_name:" + domain_name + "<br>");

			out.println("project_name:" + project_name + "<br>");
			out.println("project_description:" + project_description
					+ "<br>");
			out.println("project_institute:" + project_institute
					+ "<br>");
			out.println("project_duration:" + project_duration + "<br>");

			out.println("relevant_assets_type:" + relevant_assets_type
					+ "<br>");
			out.println("relevant_assets_file:" + relevant_assets_file
					+ "<br>");

			out.println("required_interfaces:" + required_interfaces
					+ "<br>");
			out.println("provided_interfaces:" + provided_interfaces
					+ "<br>");
			out.println("interfaces_image:" + interfaces_image + "<br>");

			out.println("version_file:" + version_file + "<br>");

			out.println("operation_env_program_language:"
					+ operation_env_program_language + "<br>");
			out.println("operation_env_operating_system:"
					+ operation_env_operating_system + "<br>");
			out.println("operation_env_minimal_hw_spec:"
					+ operation_env_minimal_hw_spec + "<br>");
			out.println("operation_env_compatible:"
					+ operation_env_compatible + "<br>");

			out.println("required_libraries:" + required_libraries
					+ "<br>");

			out.println("reuse_guidance_type:" + reuse_guidance_type
					+ "<br>");
			out.println("reuse_guidance_link:" + reuse_guidance_link
					+ "<br>");

			out.println("related_knowledge:" + related_knowledge
					+ "<br>");

			out.println("alternatives_assets_type:"
					+ alternatives_assets_type + "<br>");
			out.println("alternatives_assets_file:"
					+ alternatives_assets_file + "<br>");

			out.println("problem_type:" + problem_type + "<br>");
			out.println("problem_subtype:" + problem_subtype + "<br>");
			out.println("problem_detail_description:"
					+ problem_detail_description + "<br>");

			out.println("reuse_history_count:" + reuse_history_count
					+ "<br>");
			out.println("reuse_history_domain:" + reuse_history_domain
					+ "<br>");
			out.println("reuse_history_project:"
					+ reuse_history_project + "<br>");

			if (asset_name != null) {
				stmt.executeUpdate("INSERT INTO asset(asset_name, overall_description, overall_description_file) VALUES ( '"
						+ asset_name
						+ "', '"
						+ overall_description
						+ "', '" + overall_description_file + "')");
			}

			if (domain_name != null) {
				stmt.executeUpdate("INSERT INTO domain(domain_type, domain_name, asset_name) VALUES ( '"
						+ domain_type
						+ "', '"
						+ domain_name
						+ "', '"
						+ asset_name + "')");
			}
			if (project_name != null) {
				stmt.executeUpdate("INSERT INTO project(project_name, project_description, project_institute, project_duration, asset_name) VALUES ('"
						+ project_name
						+ "', '"
						+ project_description
						+ "', '"
						+ project_institute
						+ "', '"
						+ project_duration + "', '" + asset_name + "')");
			}

			if (relevant_assets_type.length() != 0) {
				stmt.executeUpdate("INSERT INTO relevant_asset(relevanct_asset_type, relevanct_asset_file, asset_name) VALUES ('"
						+ relevant_assets_type
						+ "', '"
						+ relevant_assets_file
						+ "', '"
						+ asset_name
						+ "')");
			}

			if (required_interfaces != null) {
				stmt.executeUpdate("INSERT INTO interface(required_interface, provided_interface, interface_upload, asset_name) VALUES ('"
						+ required_interfaces
						+ "', '"
						+ provided_interfaces
						+ "', '"
						+ interfaces_image + "', '" + asset_name + "')");
			}

			if (version_file != null) {
				stmt.executeUpdate("INSERT INTO version(version_name, asset_name) VALUES ( '"
						+ version_file + "', '" + asset_name + "')");
			}

			if (operation_env_program_language != null) {
				stmt.executeUpdate("INSERT INTO operation_environment(operation_env_pro_lang, operation_env_oper_system, operation_env_minimal_hw_spec, operation_env_compatible, asset_name) VALUES ('"
						+ operation_env_program_language
						+ "', '"
						+ operation_env_operating_system
						+ "', '"
						+ operation_env_minimal_hw_spec
						+ "', '"
						+ operation_env_compatible
						+ "', '"
						+ asset_name + "')");
			}

			if (required_libraries != null) {
				stmt.executeUpdate("INSERT INTO required_libraries(required_libraries_name, asset_name) VALUES ( '"
						+ required_libraries
						+ "', '"
						+ asset_name
						+ "')");
			}

			if (reuse_guidance_type != null) {
				stmt.executeUpdate("INSERT INTO reuse_guidance(reuse_guidance_type, reuse_guidance_link, asset_name) VALUES ('"
						+ reuse_guidance_type
						+ "', '"
						+ reuse_guidance_link
						+ "', '"
						+ asset_name
						+ "')");
			}

			if (related_knowledge != null) {
				stmt.executeUpdate("INSERT INTO related_knowledge(related_knowledge_name, asset_name) VALUES ( '"
						+ related_knowledge
						+ "', '"
						+ asset_name
						+ "')");
			}

			if (alternatives_assets_type.length() != 0) {
				stmt.executeUpdate("INSERT INTO alternatives_asset(alternatives_asset_type, alternatives_asset_files, asset_name) VALUES ('"
						+ alternatives_assets_type
						+ "', '"
						+ alternatives_assets_file
						+ "', '"
						+ asset_name + "')");
			}

			if (problem_type != null) {
				stmt.executeUpdate("INSERT INTO problem(problem_type, problem_subtype, problem_detail_description, asset_name) VALUES ('"
						+ problem_type
						+ "', '"
						+ problem_subtype
						+ "', '"
						+ problem_detail_description
						+ "', '"
						+ asset_name + "')");
			}

			if (project_name != null) {
				stmt.executeUpdate("INSERT INTO reuse_history(reuse_history_count, reuse_history_domain, reuse_history_project, asset_name) VALUES ('"
						+ 0
						+ "', '"
						+ reuse_history_domain
						+ "', '"
						+ reuse_history_project
						+ "', '"
						+ asset_name
						+ "')");
			}

			out.println("reuse information insertion ok!!<br>");
			response.sendRedirect("view_reuse_page.jsp?asset_name="
					+ asset_name);
		} catch (Exception e) {
			e.printStackTrace();
		}
	} finally {
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException e) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException e) {
			}
	}
%>
</body>
</html>