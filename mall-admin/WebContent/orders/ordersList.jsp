<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
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
<title>주문 LIST</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<%
		// 인코딩 셋팅
		request.setCharacterEncoding("utf-8");
		// 주문 상태를 받는 변수와 코드
		String ordersState = "";
		if(request.getParameter("ordersState") != null) {
			ordersState = request.getParameter("ordersState");
		}
		// 쿼리 결과 값을 가져오기 위한 dao 객체 생성
		OrdersDao ordersDao = new OrdersDao();
		// 전체 항목 리스트 객체 생성
		ArrayList<OrdersAndProduct> list = null;
		// 조건에 따른 항목 리스트 객체 생성
		ArrayList<String> list2 = null;
		// 주문상태 조건이 없으면 전체항목 출력, 상태조건이 있으면 조건에 따른 리스트 출력
		if(ordersState.equals("") || ordersState.equals("선택")) {
			list = ordersDao.selectOrdersList();
		}else {
			list = ordersDao.selectOrdersListByState(ordersState);
		}
	%>
	<div class="jumbotron">
		<h1>주문  LIST</h1>
	</div>
	<form method="post" action="/mall-admin/orders/ordersList.jsp">
		<select name="ordersState">
			<option>선택</option>
			<%
				// 상태 항목리스트 결과를 호출하여 변수 list2에 담음
				list2 = ordersDao.selectOrdersStateList();
				// 상태 항목을 하나씩 가져와 변수 s에 담기
				for(String s : list2) {
					// 항목 s와 요청받은 주문상태와 같으면 해당 상태로 고정
					if(s.equals(ordersState)) {
			%>		
						<option value=<%=s%> selected="selected"><%=s%></option>
			<%
					}else {
			%>
						<option value=<%=s%>><%=s%></option>
			<%
					}
					System.out.println(s + "<- 상태");
				}
			%>
		</select>
		<button class="btn btn-secondary" type="submit">주문상태별로 보기</button>
	</form>
	<table class="table table-striped table-bordered table-hover">
		<thead>
			<tr>
				<td>orders_id</td>
				<td>product_id</td>
				<td>product_name</td>
				<td>orders_amount</td>
				<td>orders_price</td>
				<td>orders_email</td>
				<td>orders_addr</td>
				<td>orders_state</td>
				<td>orders_date</td>
				<td>orders_state 수정</td>
			</tr>
		</thead>
		<tbody>
			<%
				//주문리스트를 출력
				for(OrdersAndProduct oap : list) {
			%>
				<tr>
					<td><%=oap.orders.getOrdersId()%></td>
					<td><%=oap.orders.getProductId()%></td>
					<td><%=oap.product.getProductName()%></td>
					<td><%=oap.orders.getOrdersAmount()%></td>
					<td><%=oap.orders.getOrdersPrice()%></td>
					<td><%=oap.orders.getMemberEmail()%></td>
					<td><%=oap.orders.getOrdersAddr()%></td>
					<td><%=oap.orders.getOrdersState()%></td>
					<td><%=oap.orders.getOrdersDate()%></td>
					<td><a class="btn btn-primary" href="/mall-admin/orders/modifyOrdersState.jsp?ordersId=<%=oap.orders.getOrdersId()%>&ordersState=<%=oap.orders.getOrdersState()%>">orders_state 수정</a></td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
</div>
</body>
</html>