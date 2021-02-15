<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String categoryName = request.getParameter("categoryName");
	//카테고리란 데이터타입으로 묶어서 보냄
	Category category = new Category();
	//category.categoryName = categoryName;
	category.setCategoryName(categoryName);
	//Dao를 통해 데이터베이스 접근하기
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.insertCategory(category);
	//리다이렉트
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>