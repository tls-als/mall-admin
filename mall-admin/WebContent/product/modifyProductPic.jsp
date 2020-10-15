<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyProductPic</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$("#btn").click(function(){
			if($("#productPic").val() == ""){
				alert("사진을 선택하세요");
				return;
			}
			$("#modifyForm").submit();
		});
	});
</script>
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
	<form action="/mall-admin/product/modifyProductAction.jsp" method="post" id="modifyForm" enctype="multipart/form-data">
		<input type="hidden" name="productId" value="<%=productId%>">
		<div>
			이미지 선택 :
			<input type="file" name="productPic" id="productPic">
		</div>
		<div>
			<button type="button" id="btn">이미지 수정</button>
		</div>
	</form>
</body>
</html>