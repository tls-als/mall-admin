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
<title>카테고리 추가</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>	
	</div>
	
	<div class="jumbotron">
		<h1>카테고리 입력</h1>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/category/addCategoryAction.jsp">
		<div class="form-group">
			<label>category_name</label>
			<input class="form-control" type="text" placeholder="카테고리명 입력" name="categoryName">
		</div>
		<div>
			<button class="btn btn-secondary" type="submit">카테고리 추가</button>
		</div>
	</form>
</div>
</body>
</html>