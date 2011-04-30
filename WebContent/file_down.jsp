<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="java.io.*" %>
<%@ page import ="java.net.*" %>
<%!
	String filepath;
	String fileName;
%>
<%
 	fileName = request.getParameter("file_name");
 	//String filepath = request.getContextPath() + "/files/";
 	filepath = "C:\\Users\\daehee\\workspace\\reuse\\WebContent\\files";
 
 	//ServletContext context = getServletContext();
 	//String sDownloadPath = context.getRealPath(savePath);
 	
 	String sFilePath = filepath + fileName;
 	out.println(sFilePath);
 
	response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8") + ";");
	
	File file1 = new File(sFilePath);
	
	byte[] byte1 = new byte[(int)file1.length()];
	
	if(file1.isFile())
	{
		FileInputStream filestream1 = new FileInputStream(file1);
		
		int inx = 0;
		int tempInt = 0;
		
		while( ( tempInt = filestream1.read()) != -1 )
		{
			byte1[inx] = (byte)tempInt;
			inx = inx +1;
		}
		OutputStream outputStream1 = response.getOutputStream();
		
		outputStream1.write(byte1);
		outputStream1.close();
		
		out.clear();
		out = pageContext.pushBody();
	}
 	%>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
</body>
</html>
