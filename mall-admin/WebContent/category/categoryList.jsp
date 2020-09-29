<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>			<!-- dao 사용하기 위한 import -->
<%@ page import="vo.*"%>			<!-- vo 사용하기 위한 import -->
<%@ page import = "java.util.*" %>	<!-- ArrayList를 사용하기 위한 import -->
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
<title>카테고리 리스트</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- 
		public 결과타입 메서드이름(입력타입1,입력타입) {
			구현코드
			return 결과값;
		}
		메서드이름(입력값,입력값)	
	 -->
	 
	 <!-- Include(상품카테고리관리) 사용-->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>	
	</div>
	
	<div class="jumbotron">
		<h1>Category List</h1>
	</div>
		
	<div align="right">
		<a class="btn btn-secondary" href="/mall-admin/category/addCategory.jsp">카테고리추가</a>
	</div><br>
	<%
		request.setCharacterEncoding("utf-8");
	
		CategoryDao categoryDao = new CategoryDao();	// CategoryDao 클래스 객체 생성
		ArrayList<Category> list = categoryDao.selectCategoryList();	// 해당 메서드의 반환값을 list에 담음
		// 페이징을 위한 객체 생성
		Paging paging = new Paging();
		// 요청에 따른 현재 페이지를 담을 변수
		if(request.getParameter("currentPage") != null) {
			//paging.currentPage = Integer.parseInt(request.getParameter("currentPage"));
			paging.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}
		// 페이지에 따른 화면 출력
		list = categoryDao.selectProductListPasing(paging);
	%>
	<table class="table table-striped table-hover">
		<thead>
			<tr>
				<th>category_no</th>
				<th>category_name</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Category c : list) {
			%>		
					<tr>
						<td><%=c.getCategoryId()%></td>
						<td><%=c.getCategoryName()%></td>
						<td><a class="btn btn-primary" href="/mall-admin/category/updateCategory.jsp?categoryId=<%=c.getCategoryId()%>&categoryName=<%=c.getCategoryName()%>">수정</a></td>
						<td><a class="btn btn-danger" href="/mall-admin/category/deleteCategoryAction.jsp?categoryId=<%=c.getCategoryId()%>">삭제</a></td>
					</tr>
			<%	
				}
			%>
		</tbody>
	</table>
	<!-- 페이징 네이게이션 -->
	<div align="center">
		<%
			Category c = new Category();
			// 현재 페이지를 담는 변수
			int currentPage = paging.getCurrentPage();
			// 마지막 페이지를 담는 변수
			int lastPage = paging.getLastPageByCategory();
			// 다음페이지를 받는 변수
			int next = currentPage+1;
			// 이전페이지를 받는 변수
			int pre = currentPage-1;
		
			// 1페이지 뿐이면 페이징 출력X, 현재 페이지가 1페이지면 처음,이전 비활성화
			if(currentPage < 2 && lastPage != 1) {
			%>	
				<ul class="pagination pagination-sm pagination justify-content-center">
					<li class="page-item disabled"><a class="page-link">처음으로</a></li>
					<li class="page-item disabled"><a class="page-link">이전</a></li>
					<li class="page-item">
						<span class="page-link"><%=currentPage%></span>
					</li>
					<li class="page-item"><a class="page-link" href="/mall-admin/category/categoryList.jsp?currentPage=<%=next%>">다음</a></li>
					<li class="page-item"><a class="page-link" href="/mall-admin/category/categoryList.jsp?currentPage=<%=lastPage%>">마지막으로</a></li>
				</ul>
			<%
			}
			// 2페이지부터 ~ 마지막 페이지 전까지 페이징 활성화
			else if(currentPage > 1 && lastPage > currentPage) {
			%>			
				<ul class="pagination pagination-sm pagination justify-content-center">
					<li class="page-item"><a class="page-link" href="/mall-admin/product/productList.jsp?currentPage=1" >처음으로</a></li>
					<li class="page-item"><a class="page-link" href="/mall-admin/product/productList.jsp?currentPage=<%=pre%>">이전</a></li>
					<li class="page-item">
						<span class="page-link"><%=currentPage%></span>
					</li>
					<li class="page-item"><a class="page-link" href="/mall-admin/product/productList.jsp?currentPage=<%=next%>">다음</a></li>
					<li class="page-item"><a class="page-link" href="/mall-admin/product/productList.jsp?currentPage=<%=lastPage%>">마지막으로</a></li>
				</ul>
			<%
			}
			// 마지막페이지면 다음,마지막 비활성화
			else if(currentPage > 1 && lastPage == currentPage) {
			%>		
				<ul class="pagination pagination-sm pagination justify-content-center">
					<li class="page-item"><a class="page-link" href="/mall-admin/category/categoryList.jsp?currentPage=1" >처음으로</a></li>
					<li class="page-item"><a class="page-link" href="/mall-admin/category/categoryList.jsp?currentPage=<%=pre%>">이전</a></li>
					<li class="page-item">
						<span class="page-link"><%=currentPage%></span>
					</li>
					<li class="page-item disabled"><a class="page-link" href="/mall-admin/category/categoryList.jsp?currentPage=<%=next%>">다음</a></li>
					<li class="page-item disabled"><a class="page-link" href="/mall-admin/category/categoryList.jsp?currentPage=<%=lastPage%>">마지막으로</a></li>
				</ul>
			<%
			}

		//System.out.println(currentPage + "<--현재 카테고리 페이지 번호");
		//System.out.println(paging.getLastPageByCategory() + "<--카테고리 마지막 페이지");
		%>
	</div>
</div>
</body>
</html>