<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyProductPic</title>
</head>
<body>
<!-- https://mvnrepository.com/ 라이브러리 -->
<!-- http://servlets.com/cos/ cos.jar는 파일업로드를 편리하게 제공하는 라이브러리-->
	<%
		request.setCharacterEncoding("utf-8");
		int productId = Integer.parseInt(request.getParameter("productId"));
	%>
	<h1>상품 이미지 수정</h1>
	<!-- multipart/form-data 파일(데이터) 형태로 넘김.(input 타입의 String도 파일로 넘기기 때문에 불편) application/x-www-form-urlencoded는 글자가 넘어감 -->
	<form action="/mall-admin/product/modifyProductAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="productId" value="<%=productId%>">
		<div>
			이미지 선택 :
			<input type="file" name="productPic">
		</div>
		<div>
			<button type="submit">이미지 수정</button>
		</div>
	</form>
</body>
</html>