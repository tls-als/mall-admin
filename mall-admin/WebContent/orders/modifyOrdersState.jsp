<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import = "java.util.*" %>
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
	<title>modifyOrdersState.jsp</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<%
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");
	// 주문상태 수정을 위한 ordersId 값 받기
	int ordersId = 0;
	if(request.getParameter("ordersId") != null) {
		ordersId = Integer.parseInt(request.getParameter("ordersId"));
	}
	// 현재 등록된 주문 상태를 받기 위한 변수
	String ordersState = null;
	if(request.getParameter("ordersState") != null) {
		ordersState = request.getParameter("ordersState");
	}
	// 주문상태 목록 쿼리를 받기 위한 Dao,ArrayList 객체 생성
	OrdersDao ordersDao = new OrdersDao();
	ArrayList<String> list = null;
	// 주문상태 목록 쿼리 결과를 리스트에 담음
	list = ordersDao.selectOrdersStateList();
	%>
	<div class="jumbotron">
		<h1>주문 상태 수정</h1>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/orders/modifyOrdersStateAction.jsp">
		<table class="table-striped table-bordered">
			<tr>
				<td>주문번호</td>
				<td>
					<input class="form-control" type="text" name="ordersId" value="<%=ordersId%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>현재 주문상태</td>
				<td>
					<input class="form-control" type="text" value="<%=ordersState%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>주문상태 변경</td>
				<td>
					<select class="form-control" name="ordersState">
						<%
							for(String state : list) {
						%>		
								<option value="<%=state%>"><%=state%></option>
						<%
							}							
						%>
					</select>
				</td>
			</tr>
		</table>
		<button class="btn btn-secondary mt-2" type="submit">수정하기</button>
</form>
</div>
</body>
</html>