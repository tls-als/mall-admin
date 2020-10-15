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
<title>카테고리 추가</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$("#btn").click(function(){
			if($("#categoryName").val() == ""){
				alert("카테고리명을 입력하세요");
				return;
			}
			$("#addForm").submit();
		});
	});
</script>
</head>
<body>
<div class="container">
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>	
	</div>
	
	<div class="jumbotron">
		<h1>카테고리 입력</h1>
	</div>
	
	<form method="post" action="/mall-admin/category/addCategoryAction.jsp" id="addForm">
		<div class="form-group">
			<label>category_name</label>
			<input class="form-control" type="text" placeholder="카테고리명 입력" name="categoryName" id="categoryName">
		</div>
		<div>
			<button class="btn btn-secondary" type="button" id="btn">카테고리 추가</button>
		</div>
	</form>
</div>
</body>
</html>