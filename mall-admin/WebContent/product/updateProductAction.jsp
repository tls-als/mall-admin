<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@page import="dao.*"%>
<%
	request.setCharacterEncoding("utf-8");
	//상품번호 받기
	int productId = 0;
	if(request.getParameter("productId") != null) {
		productId = Integer.parseInt(request.getParameter("productId"));
	}
	//상품이름 받기
	String productName = "";
	if(request.getParameter("productName") != null) {
		productName = request.getParameter("productName");
	}
	//상품가격 받기
	int productPrice = 0;
	if(request.getParameter("productPrice") != null) {
		productPrice = Integer.parseInt(request.getParameter("productPrice"));
	}
	
	// vo에 변수 값 담기
	Product product = new Product();
	//product.productId = productId;
	//product.productName = productName;
	//product.productPrice = productPrice;
	product.setProductId(productId);
	product.setProductName(productName);
	product.setProductPrice(productPrice);
	
	// Dao로 실행
	ProductDao productDao = new ProductDao();
	productDao.updateProduct(product);
	
	//리다이렉트
	response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
%>