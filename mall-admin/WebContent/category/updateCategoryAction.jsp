<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	
	//categoryList.jsp에서 보낸 데이터값을 담는 변수
	int categoryId = Integer.parseInt(request.getParameter("categoryId"));
	String categoryName = request.getParameter("categoryName");
	
	//변수 값을 vo에 담기
	Category category = new Category();
//	category.categoryId = categoryId;
//	category.categoryName = categoryName;
	category.setCategoryId(categoryId);
	category.setCategoryName(categoryName);
	
	//vo에 값을 담은 후 dao를 통해 DB접근하기
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.updateCategory(category);
	
	//리다이렉트
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>