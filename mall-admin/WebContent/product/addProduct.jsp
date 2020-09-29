<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
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
<title>상품추가</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<%
		CategoryDao categoryDao = new CategoryDao();
		ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	%>
	<div class="jumbotron">
		<h1>상품추가</h1>	
	</div>
	<form method="post" action="/mall-admin/product/addProductAction.jsp">
		<table class="table table-striped table-bordered">
			<tr>
				<td>category_id</td>
				<td>
					<div class="form-group">
						<select class="form-control" name="categoryId">
							<option value="">카테고리 선택</option>
							<%
								for(Category c : categoryList) {
							%>	
									<option value="<%=c.getCategoryId()%>"><%=c.getCategoryName()%></option>	
							<%		
								}
							%>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<td>product_name</td>
				<td>
					<input class="form-control" type="text" placeholder="상품명 입력" name="productName">
				</td>
			</tr>
			<tr>
				<td>product_price</td>
				<td>
					<input class="form-control" type="text" placeholder="가격 입력" name="productPrice">
				</td>
			</tr>
			<tr>
				<td>product_content</td>
				<td>
					<textarea class="form-control" rows="5" cols="80" name="productContent"></textarea>
				</td>
			</tr>
						<tr>
				<td>product_soldout</td>
				<td>
					<div class="form-check-inline">
						<input type="radio" class="form-check-inline" name="productSoldout" value="N" checked="checked">품절아님
					</div>
					<div class="form-check-inline">
						<input type="radio" class="form-check-inline" name="productSoldout" value="Y">품절
					</div>
				</td>
			</tr>
		</table>
		<button class="btn btn-secondary" type="submit">상품추가</button>
	</form>
</div>
</body>
</html>