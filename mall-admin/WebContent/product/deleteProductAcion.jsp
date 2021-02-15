<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@page import="dao.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	int productId = 0;
	if(request.getParameter("productId") != null) {
		productId = Integer.parseInt(request.getParameter("productId"));
	}
	
	Product product = new Product();
	//product.productId = productId;
	product.setProductId(productId);
	
	ProductDao productDao = new ProductDao();
	productDao.deleteProduct(product);
	
	response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
%>