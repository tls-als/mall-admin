<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//세션에 있는 모든 내용 삭제
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/login.jsp");
%>