<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	/*
	* 주문 상세보기를 위한 페이지
	* 1. 로그인이 되어 있지 않으면 로그인 화면으로 이동하기
	* 2. 회원 이메일 값으로 구분하여 주문 목록을 출력하기
	*/
	
	// 세션에 회원이메일이 없다면(로그아웃이 되어 있다면) -> 로그인 페이지로 이동하기
	if(session.getAttribute("loginMemberEmail") == null) {
		response.sendRedirect(request.getContextPath() + "/member/login.jsp");
		return;
	}
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 주문</title>
<!-- 부트스트랩 이용을 위한 링크 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
		
	<%
		// 인코딩 설정
		request.setCharacterEncoding("utf-8");
	
		// 회원 이메일 받아오기
		String memberEmail = (String)session.getAttribute("loginMemberEmail");
		
		// 주문 상세 목록 결과를 가져오기 위한   dao 객체 생성
		OrdersDao ordersDao = new OrdersDao();
		// 결과값 list에 담기
		ArrayList<Orders> list = ordersDao.selectOrdersListByEmail(memberEmail);
		System.out.println(list + "<- 가져온 주문상세");
	%>
<div class="container">
	<div class="jumbotron">
		<h1>주문 상세목록</h1>
	</div>
	<form action="<%=request.getContextPath()%>/index.jsp">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>orders_id</th>
					<th>product_id</th>
					<th>orders_amount</th>
					<th>orders_price</th>
					<th>member_email</th>
					<th>orders_addr</th>
					<th>orders_date</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Orders o : list) {
				%>
						<tr>
							<td><%=o.getOrdersId()%></td>
							<td><%=o.getProductId()%></td>
							<td><%=o.getOrdersAmount()%></td>
							<td><%=o.getOrdersPrice()%></td>
							<td><%=o.getMemberEmail()%></td>
							<td><%=o.getOrdersAddr()%></td>
							<td><%=o.getOrdersDate()%></td>
						</tr>
				<%
					System.out.println(o.getOrdersId() + "<- 주문번호");
					System.out.println(o.getProductId() + "<- 제품번호");
					System.out.println(o.getOrdersAmount() + "<- 주문개수");
					System.out.println(o.getOrdersPrice() + "<- 주문가격");
					System.out.println(o.getMemberEmail() + "<- 회원메일");
					System.out.println(o.getOrdersAddr() + "<- 주문지");
					System.out.println(o.getOrdersDate() + "<- 날짜");
					}
				%>
			</tbody>
		</table>
		<div class="d-flex justify-content-end">
			<button type="submit" class="btn btn-secondary">돌아가기</button>
		</div>
		
		<h6><span>주문을 취소하시려면 배송준비 전까지 admin@gd.com으로 메일을 주세요.</span></h6>
	</form>
</div>
</body>
</html>