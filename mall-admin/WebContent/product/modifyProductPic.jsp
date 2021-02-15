<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginAdminId") == null) {
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modifyProductPic</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<!-- https://mvnrepository.com/ 라이브러리 -->
	<!-- http://servlets.com/cos/ cos.jar는 파일업로드를 편리하게 제공하는 라이브러리-->
	<%
		request.setCharacterEncoding("utf-8");
		int productId = Integer.parseInt(request.getParameter("productId"));
	%>
	<div class="jumbotron">
		<h1>상품 이미지 수정</h1>
	</div>
	
	<!-- multipart/form-data 파일(데이터) 형태로 넘김.(input 타입의 String도 파일로 넘기기 때문에 불편) application/x-www-form-urlencoded는 글자가 넘어감 -->
	<form action="<%=request.getContextPath()%>/product/modifyProductAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="productId" value="<%=productId%>">
		<div>
			<table class="table table-bordered table-sm">
				<tr>
					<td><span class="badge badge-pill badge-primary">이미지 선택</span></td>
				</tr>
				<tr>
					<td><input type="file" name="productPic"></td>
				</tr>
			</table>
		</div>
		<div align="right">
			<button class="btn btn-secondary mt-2" type="submit">이미지 수정</button>
		</div>
	</form>
</div>
</body>
</html>