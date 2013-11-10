<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if (request.getAttribute("result") != null) {
		Map<String,Object> result = (Map<String,Object>) request.getAttribute("result");
		String msg = (String)result.get("msg");
		if (msg.equals("yes")) {
			out.println("<script>alert('保存成功！');parent.returnValue='"+result.get("imgUrl")+"';parent.close();</script>");
		} else {
			out.println("<script>alert('保存失败！')</script>");
		}
	}
%>