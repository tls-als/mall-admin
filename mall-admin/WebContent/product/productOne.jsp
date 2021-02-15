<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	if(session.getAttribute("loginAdminId") == null) {
		response.sendRedirect(request.getContextPath()+"/mall-admin/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세정보 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container" align="center">
<!-- 상세정보 페이지 -->
<%
	// 제품 아이디 받기
	int productId = 0;
	if(request.getParameter("productId") != null) {
		productId = Integer.parseInt(request.getParameter("productId"));
	}
	System.out.println(productId + "<-productId");	// 디버깅 중요
	Product product = new ProductDao().selectProductOne(productId);	//코드가 간단하지만 다른 메서드 호출시 또 객체를 만들어야함. 하나의 메서드 사용시
%>
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	
	<div class="jumbotron">
		<h1>상세보기</h1>
	</div>
	
	<table class="table table-striped table-bordered table-hover">
		<tr>
			<td>product_pic</td>
			<td colspan="2">
				<img src="<%=request.getContextPath()%>/image/<%=product.getProductPic()%>">
				<a href="<%=request.getContextPath()%>/product/modifyProductPic.jsp?productId=<%=product.getProductId()%>" class="btn btn-primary">이미지 수정</a>
			</td>
		</tr>
		<tr>
			<td>product_id</td>
			<td colspan="2"><%=product.getProductId()%></td>
		</tr>
		<tr>
			<td>category_id</td>
			<td colspan="2"><%=product.getCategoryId()%></td>
		</tr>
		<tr>
			<td>product_name</td>
			<td colspan="2"><%=product.getProductName()%></td>
		</tr>
		<tr>
			<td>product_price</td>
			<td colspan="2"><%=product.getProductPrice()%></td>
		</tr>
		<tr>
			<td>product_content</td>
			<td colspan="2"><%=product.getProductContent()%></td>
		</tr>
		<tr>
			<td>product_soldout</td>
			<td colspan="2">
				<%
					if(product.getProductSoldout().equals("Y")){
				%>
						<a class="btn btn-secondary" href="<%=request.getContextPath()%>/product/modifyProductSoldoutAction.jsp?productId=<%=product.getProductId()%>&productSoldout=<%=product.getProductSoldout()%>">품절</a>
				<%		
					}else {
				%>
						<a class="btn btn-info" href="<%=request.getContextPath()%>/product/modifyProductSoldoutAction.jsp?productId=<%=product.getProductId()%>&productSoldout=<%=product.getProductSoldout()%>">판매중</a>
				<%		
					}
				%>
			</td>
		</tr>
		<tr>
			<td><a class="btn btn-secondary" href="<%=request.getContextPath()%>/product/productList.jsp">완료</a></td>
			<td><a class="btn btn-primary" href="<%=request.getContextPath()%>/product/updateProductForm.jsp?productId=<%=product.getProductId()%>&productName=<%=product.getProductName()%>&productPrice=<%=product.getProductPrice()%>">수정</a></td>
			<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/product/deleteProductAcion.jsp?productId=<%=product.getProductId()%>">삭제</a></td>
		</tr>		
	</table>
</div>
</body>
</html>