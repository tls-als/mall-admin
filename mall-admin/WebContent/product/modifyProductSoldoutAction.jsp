<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	int productId = Integer.parseInt(request.getParameter("productId"));
	String productSoldout = request.getParameter("productSoldout");
	ProductDao productDao = new ProductDao();
	productDao.updateProductSoldout(productId, productSoldout);
	
	response.sendRedirect(request.getContextPath()+"/product/productOne.jsp?productId="+productId);
%>