<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 로그아웃이 되어 있으면 로그인 페이지로 복귀
	if(session.getAttribute("loginAdminId") == null) {
		response.sendRedirect("/mall-admin/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	<!-- 부트스트랩(CSS) 링크 -->
</head>
<body>
<div class="container">
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<div class="jumbotron">
		<h1>회원 관리 페이지</h1>
	</div>
	<%
		// 인코딩 설정
		request.setCharacterEncoding("utf-8");
	
		// 데이터를 담기 위한 리스트 객체 생성
		ArrayList<Member> list = null;
	
		// dao 객체 생성
		MemberDao memberDao = new MemberDao();
		// 쿼리 결과값을  list 변수에 담기
		list = memberDao.selectMemberList();
	%>
	<table class="table table-striped table-hover">
		<thead>
			<tr>
				<th>member_email</th>
				<th>member_name</th>
				<th>member_date</th>
				<th>탈퇴</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(Member m : list) {
		%>
				<tr>
					<td><%=m.getMemberEmail()%></td>
					<td><%=m.getMemberName()%></td>
					<td><%=m.getMemberDate()%></td>
					<td><a href="<%=request.getContextPath()%>/member/deleteMemberAction.jsp?memberEmail=<%=m.getMemberEmail()%>" class="btn btn-danger">탈퇴처리</a></td>
				</tr>
		<%
		//System.out.println(m.getMemberEmail() + "<-- 회원 이메일");
			}
		%>
		</tbody>
	</table>
</div>
</body>
</html>