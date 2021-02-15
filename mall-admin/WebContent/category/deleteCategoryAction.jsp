<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!-- 카테고리 삭제 -->
<%
	//한글 인코딩
	request.setCharacterEncoding("utf-8");
	//categoryList.jsp에서 보낸 파라메터 값을 변수에 담음
	int id = Integer.parseInt(request.getParameter("categoryId"));
	
	//데이터값을 vo변수에 담기(DB에 접근하기 위함)
	//vo객체 생성
	Category category = new Category();
	//category.categoryId = id;
	category.setCategoryId(id);
	
	//Dao에 vo담기
	//dao 객체 생성
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.deleteCategory(category);
	
	//리다이렉트
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>