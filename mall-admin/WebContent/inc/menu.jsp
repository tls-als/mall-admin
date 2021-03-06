<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--
	 1. include(현재 문서에 다른 문서를 포함시키는 것)를 위한 JSP
	 2. 상품카테고리관리 링크 목록
-->
<nav class="navbar navbar-expand-sm bg-info navbar-dark">
	<ul class="navbar-nav">
		<li class="nav-item">
			<a class="nav-link btn btn-info" href="<%=request.getContextPath()%>/index.jsp">|홈으로|</a>
		</li>
		<li class="nav-item">
			<a class="nav-link btn btn-info" href="<%=request.getContextPath()%>/category/categoryList.jsp">|상품카테고리 관리|</a>
		</li>
		<li class="nav-item">
			<a class="nav-link btn btn-info" href="<%=request.getContextPath()%>/product/productList.jsp">|상품 관리|</a>
		</li>
		<li class="nav-item">
			<a class="nav-link btn btn-info" href="<%=request.getContextPath()%>/orders/ordersList.jsp">|주문 관리|</a>
		</li>
		<li class="nav-item">
			<a class="nav-link btn btn-info" href="<%=request.getContextPath()%>/notice/noticeList.jsp">|공지 관리|</a>
		</li>
		<li class="nav-item">
			<a class="nav-link btn btn-info" href="<%=request.getContextPath()%>/member/memberList.jsp">|회원 관리|</a>
		</li>
		<li class="nav-item">
			<a class="nav-link btn btn-info" href="<%=request.getContextPath()%>/logoutAction.jsp">|로그아웃|</a>
		</li>
	</ul>	
</nav>