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
<title>수정 카테고리</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<%
		// 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		// categoryList.jsp에서 보낸 데이터 값 받기
		int id = 0;
 		String name = "";
 		
		if(request.getParameter("categoryId") != null) {
			id = Integer.parseInt(request.getParameter("categoryId"));
		}
		if(request.getParameter("categoryName") != null) {
			name = request.getParameter("categoryName");
		}
		System.out.println(id+"<-id");
		System.out.println(name+"<-name");
	%>
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	
	<div class="jumbotron">
		<h1>카테고리 수정</h1>
	</div>
	
	<form method="post" action="<%=request.getContextPath()%>/category/updateCategoryAction.jsp">
		<div class="form-group">	
			<label>category_name 수정 입력</label>
			<input type="hidden" name="categoryId" value="<%=id%>">
			<input class="form-control" type="text" name="categoryName" value="<%=name%>">
		</div>
		<button class="btn btn-secondary" type="submit">수정하기</button>
	</form>
</div>
</body>
</html>