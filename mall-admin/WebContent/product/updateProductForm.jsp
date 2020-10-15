<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginAdminId") == null) {
		response.sendRedirect("/mall-admin/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
/*
	$(document).ready(function(){
		$("#btn").click(function(){
			if($("#productName").val() == ""){
				alert("제품명을 입력하세요");
				return;
			}else if($("#productPrice").val() == 0){
				alert("가격을 입력하세요");
				return;
			}
			$("#updateForm").submit();
		});
	});
*/
</script>
</head>
<body>
<div class="container">
	<%	
		//한글 인코딩
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
		//판매현황 받기
		String productSoldout = "";
		if(request.getParameter("productSoldout") != null) {
			productSoldout = request.getParameter("productSoldout");
		}
	%>
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<div class="jumbotron">
		<h1>상품 수정</h1>
	</div>
	<form method="post" action="/mall-admin/product/updateProductAction.jsp" id="updateForm">
		<h5>Product_name, product_price 수정</h5>
		<input type="hidden" name="productId" value=<%=productId%>>
		<table class="table table-bordered">
			<tr>
				<td>상품명</td>
				<td><input type="text" name="productName" id="productName" value=<%=productName%>></td>
			</tr>
			<tr>
				<td>상품가격</td>
				<td><input type="text" name="productPrice" id="productPrice" value=<%=productPrice%>></td>
			</tr>
		</table>
		<button class="btn btn-secondary" type="button" id="btn">수정하기</button>
	</form>
</div>
</body>
</html>