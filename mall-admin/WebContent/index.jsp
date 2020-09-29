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
<title>메인페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<!-- 
	admin-mall 프로젝트 아쉬운 점
	1. 페이징을 온전하게 구현하지 못한 아쉬움 -> 숫자를 이용한 페이지 이동을 구현해보려고 하였으나 아직 방안을 찾고 있는 중
	2. 페이징에 대한 이해도가 아직 부족.
	3. 회원 탈퇴 기능에 대한 아쉬움 -> 한번 탈퇴한 계정의 이메일은 다시 가입하지 못하도록 구현하는 기능 필요.
	4. 두 쿼리를 조인하기 위하여 두 데이터를 함께 담기 위한 OrdersAndProduct 메서드를 만드는 과정에 대한 복습이 필요. 
 -->
<body>
<div class="container">
	<!-- 
		response 명령의 주체는 웹브라우저이기에 프로젝트명과 함께 호출, 
		include 명령의 주체는 톰캣이기에 프로젝트명X(ex) /inc/menu.jsp) 
	-->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<div class="jumbotron">
		<h1>관리자 메인 페이지</h1>
		<div class="text-secondary">
			<h4>해당 페이지는 카탈로그 관리 및 상품 관리를 위한 관리자 화면입니다.</h4>
			<p><%=session.getAttribute("loginAdminId")%>님 반갑습니다.</p>
		</div>
	</div>
	<div align="center">
		<img class="img-thumbnail" src="/mall-admin/image/product.png">
		<h4>프로그램 기능</h4>
		<table class="table table-striped table-bordered">
			<tr>
				<td>1</td>
				<td>
					<div>
						카테고리 목록을 조회, 추가, 수정, 삭제가 가능한 기능을 만든다.
					</div>
				</td>
			</tr>
			<tr>
				<td>2</td>
				<td>
					<div>
						상품의  전체 목록, 카테고리별 목록, 상품의 추가,수정,삭제가 가능한 기능을 만든다.
					</div>
				</td>
			</tr>
		</table>

		<h4>상위 목록</h4>
		<table class="table table-striped table-bordered">
			<tr>
				<td>홈으로</td>
				<td>
					<div>
						현재 관리자 메인페이지로 이동합니다.
					</div>
				</td>
			</tr>
			<tr>
				<td>상품카테고리 관리</td>
				<td>
					<div>
						카테고리의 목록,수정,삭제 관리페이지로 이동합니다.
					</div>
				</td>
			</tr>
			<tr>
				<td>상품관리</td>
				<td>
					<div>
						상품의 목록,수정,삭제 관리페이지로 이동합니다.
					</div>
				</td>
			</tr>
		</table>	
	</div>
</div>
</body>
</html>