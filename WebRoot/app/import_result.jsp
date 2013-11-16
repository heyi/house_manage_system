<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if (request.getAttribute("msg") != null) {
		String msg = (String) request.getAttribute("msg");
		if (msg.equals("yes")) {
			out.println("<script>alert('保存成功！');parent.close();</script>");
		} else {
			out.println("<script>alert('保存失败！')</script>");
		}
	}
%>