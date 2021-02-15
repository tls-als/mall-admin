<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
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
	<title>상품목록화면</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	<!-- 부트스트랩(CSS) 링크 -->
</head>
<body>
<div class="container">
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	
	<%	/*
		* 상품 리스트 출력 페이지
		* 카테고리 선택에 따른 다른 리스트 목록 출력(CategoryId로 구분)
		*/
		
		// 넘어오는 값이 있으면 반드시 인코딩 기재
		request.setCharacterEncoding("utf-8");
		
		// 카탈로그 번호 받는 변수 생성
		int categoryId = -1;	// 임시의 값. 카탈로그id값은 -1이 없으니 전체 출력
		if(request.getParameter("categoryId") != null) {
			categoryId = Integer.parseInt(request.getParameter("categoryId"));
		}
		// 페이징 데이터를 담는 Pasing 객체 생성
		Paging paging = new Paging();
		// 넘어오는 현재 페이지 값을 변수에 담기
		if(request.getParameter("currentPage") != null) {
			//paging.currentPage = Integer.parseInt(request.getParameter("currentPage"));
			paging.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}
		// 상품 리스트 조회를 위한 DAO 객체 생성
		ProductDao productDao = new ProductDao();
		// Product 데이터를 가진 ArrayList 변수 생성 
		ArrayList<Product> productList = null;
		// 카탈로그 번호가 -1이면(초기값) 전체 리스트 출력하는 메서드 호출
		if(categoryId == -1) {		
			productList = productDao.selectProductListPasing(paging); // 페이지에 따른 전체 리스트 화면 출력
		// 카탈로그 번호가 따로 있으면 카탈로그 선택에 따른 리스트 출력 메서드 호출
		}else {	
			productList= productDao.selectProductByCategoryId(categoryId ,paging);	// 카테고리번호와 페이지를 넘김
		}
		
		// 카탈로그 리스트를 출력하기 위한 메서드 호출
		CategoryDao categoryDao = new CategoryDao();
		ArrayList<Category> categoryList = categoryDao.selectCategoryList();
			
	%>
	
	<div class="jumbotron">
		<h1>Product List</h1>
	</div>
	
	<!-- 카테고리 목록을 출력 -->
	<div class="btn-group btn-group-sm">
		<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/product/productList.jsp?&categoryId=-1">전체</a>
		<%
			
			for(Category c : categoryList) {
		%>
				<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/product/productList.jsp?categoryId=<%=c.getCategoryId()%>">	
					<%=c.getCategoryName()%>
				</a>
		<%
			}
		%>
	</div>
	
	<!-- 상품추가 화면(addProduct.jsp)으로 이동하는 링크 -->
	<div align="right">
		<a class="btn btn-secondary" href="<%=request.getContextPath()%>/product/addProduct.jsp">상품추가</a>
	</div><br>
	
	<table class="table table-striped table-hover">
		<thead>
			<tr>
				<th>product_id</th>
				<th>category_id</th>
				<th>product_name</th>
				<th>product_price</th>
				<th>product_soldout</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Product p : productList) {
					if(p.getProductSoldout().equals("Y")) {
			%>		<tr>
						<td>
							<del>
							<a class="btn btn-info" href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=p.getProductId()%>">
								<%=p.getProductId()%>
							</a>
							</del>
						</td>
						<td><del><%=p.getCategoryId()%></del></td>
						<td><del><%=p.getProductName()%></del></td>
						<td><del><%=p.getProductPrice()%></del></td>
						<td>품절</td>
					</tr>	
			<%		
					}else {
			%>		
					<tr>
						<td>
							<a class="btn btn-info" href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=p.getProductId()%>">
								<%=p.getProductId()%>
							</a>
						</td>
						<td><%=p.getCategoryId()%></td>
						<td><%=p.getProductName()%></td>
						<td><%=p.getProductPrice()%></td>
						<td><%=p.getProductSoldout()%></td>
					</tr>	
			<%				
					}
				}
			%>
		</tbody>
	</table>
	<!-- 페이징 네비게이션 -->
	<div align="center">
		<%
			// 마지막 페이지를 담을 변수
			int lastPage = 0;
			// 현재 페이지를 담는 변수
			int currentPage = paging.getCurrentPage();
			// 다음페이지를 받는 변수
			int next = currentPage+1;
			// 이전페이지를 받는 변수
			int pre = currentPage-1;
			
			if(categoryId == -1) {
				lastPage = paging.getLastPage();
				// 현재 페이지가 1이고 페이지가 1개 이상일 때 -> 처음&이전 비활성화, 페이지가 1개면 다음&마지막 비활성화
				if(currentPage < 2 && lastPage != 1) {
		%>	
					<ul class="pagination pagination-sm pagination justify-content-center">
						<li class="page-item disabled"><a class="page-link">처음으로</a></li>
						<li class="page-item disabled"><a class="page-link">이전</a></li>
						<li class="page-item">
							<span class="page-link"><%=currentPage%></span>
						</li>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=currentPage+1%>&categoryId=<%=categoryId%>">다음</a></li>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=lastPage%>&categoryId=<%=categoryId%>">마지막으로</a></li>
					</ul>
		<%
				}
				// 2페이지부터 ~ 마지막 페이지 전까지 페이징 활성화
				if(currentPage > 1 && lastPage > currentPage) {
		%>			<ul class="pagination pagination-sm pagination justify-content-center">
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=1&categoryId=<%=categoryId%>" >처음으로</a></li>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=currentPage-1%>&categoryId=<%=categoryId%>">이전</a></li>
						<li class="page-item">
							<span class="page-link"><%=currentPage%></span>
						</li>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=currentPage+1%>&categoryId=<%=categoryId%>">다음</a></li>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=lastPage%>&categoryId=<%=categoryId%>">마지막으로</a></li>
					</ul>
		<%
				}
				// 마지막페이지면 다음,마지막 비활성화
				if(currentPage > 1 && currentPage == lastPage) {
		%>
					<ul class="pagination pagination-sm pagination justify-content-center">
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=1&categoryId=<%=categoryId%>" >처음으로</a></li>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=currentPage-1%>&categoryId=<%=categoryId%>">이전</a></li>
						<li class="page-item">
							<span class="page-link"><%=currentPage%></span>
						</li>
						<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=currentPage+1%>&categoryId=<%=categoryId%>">다음</a></li>
						<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=lastPage%>&categoryId=<%=categoryId%>">마지막으로</a></li>
					</ul>		
		<%
				}
			// 카테고리 넘버가 1이상 일때(다른 카테고리를 선택할때)
			}
			else {
				lastPage = paging.getLastPageByCategory(categoryId);
				if(currentPage < 2 && lastPage != 1) {
		%>	
					<ul class="pagination pagination-sm pagination justify-content-center">
						<li class="page-item disabled"><a class="page-link">처음으로</a></li>
						<li class="page-item disabled"><a class="page-link">이전</a></li>
						<li class="page-item">
							<span class="page-link"><%=currentPage%></span>
						</li>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=currentPage+1%>&categoryId=<%=categoryId%>">다음</a></li>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=lastPage%>&categoryId=<%=categoryId%>">마지막으로</a></li>
					</ul>
		<%
				}
				if(currentPage > 1 && lastPage > currentPage) {
		%>			<ul class="pagination pagination-sm pagination justify-content-center">
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=1&categoryId=<%=categoryId%>" >처음으로</a></li>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=currentPage-1%>&categoryId=<%=categoryId%>">이전</a></li>
						<li class="page-item">
							<span class="page-link"><%=currentPage%></span>
						</li>						
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=currentPage+1%>&categoryId=<%=categoryId%>">다음</a></li>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=lastPage%>&categoryId=<%=categoryId%>">마지막으로</a></li>
					</ul>
		<%
				}
				if(currentPage > 1 && currentPage == lastPage) {
		%>
					<ul class="pagination pagination-sm pagination justify-content-center">
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=1&categoryId=<%=categoryId%>" >처음으로</a></li>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=currentPage-1%>&categoryId=<%=categoryId%>">이전</a></li>
						<li class="page-item">
							<span class="page-link"><%=currentPage%></span>
						</li>
						<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=currentPage+1%>&categoryId=<%=categoryId%>">다음</a></li>
						<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=lastPage%>&categoryId=<%=categoryId%>">마지막으로</a></li>
					</ul>		
		<%
				}
			}
		System.out.println(categoryId + "<--상품 리스트의 카테고리 아이디");
		System.out.println(paging.getCurrentPage() + "<--상품 리스트의 현재 페이지");
		System.out.println(lastPage + "<--상품 리스트의 마지막 페이지");
		%>
	</div>
</div>
</body>
</html>