<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.ac.kaist.webeng.UserDao" %>

<%
	String id = request.getParameter("id");
	UserDao dao = new UserDao();
	int re = dao.checkId(id);
%>
<%=re%>