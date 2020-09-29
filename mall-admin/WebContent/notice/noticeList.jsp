<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 로그아웃 상태이면 로그인 화면으로 이동
	if(session.getAttribute("loginAdminId") == null) {
		response.sendRedirect("/mall-admin/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 리스트</title>
<!-- 부트스트랩(CSS) 링크 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	
</head>
<body>
<div class="container">
	<!-- 상위 메뉴 목록 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<!-- 공지사항 -->
	<div class="jumbotron">
		<h1>공지사항 LIST</h1>
	</div>
<%
	// 인코딩 세팅
	request.setCharacterEncoding("utf-8");

	// Dao 쿼리 결과 list에 담기
	NoticeDao noticeDao = new NoticeDao();
	// 리스트를 담을 list 변수 생성
	ArrayList<Notice> list = noticeDao.selectNoticeList();
%>

	<!-- 
		1. 등록하기 버튼 클리하면 공지등록 페이지로 이동 
		2. 공지 목록 출력하는 폼	
	-->
	<form method="post" action="<%=request.getContextPath()%>/notice/insertNoticeForm.jsp">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>notice_id</th>
					<th>notice_title</th>
					<th>notice_content</th>
					<th>notice_date</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Notice n : list) {
				%>	
				<tr>	
						<td><%=n.getNoticeId()%></td>
						<td><%=n.getNoticeTitle()%></td>
						<td><%=n.getNoticeContent()%></td>
						<td><%=n.getNoticeDate()%></td>	
						<td><a href="<%=request.getContextPath()%>/notice/updateNoticeForm.jsp?noticeId=<%=n.getNoticeId()%>&noticeTitle=<%=n.getNoticeTitle()%>&noticeContent=<%=n.getNoticeContent()%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeId=<%=n.getNoticeId()%>">삭제</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<div class="d-flex justify-content-end">
			<button type="submit" class="btn btn-primary">공지쓰기</button>
		</div>
	</form>
</div>
</body>
</html>