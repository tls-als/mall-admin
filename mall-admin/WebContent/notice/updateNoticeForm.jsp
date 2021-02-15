<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>
<!-- 공지사항 항목을 수정하는 페이지-->
<%
	// 로그인 상태가 아니면 로그인 페이지로 이동
	if(session.getAttribute("loginAdminId") == null) {
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 수정 폼</title>
<!-- 부트스트랩(CSS) 링크 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	
</head>
<body>
<div class="container">
	<!-- 상위 메뉴 목록 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	
	<div class="jumbotron">
		<h1>공지사항 수정</h1>
	</div>
<%
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");

	// request로 보내진 값 받기
	int noticeId = 0;
	if(request.getParameter("noticeId") != null) {
		noticeId = Integer.parseInt(request.getParameter("noticeId"));
	}
	//System.out.println(noticeId + "공지 아이디 값");
	String noticeTitle = "";
	if(request.getParameter("noticeTitle") != null) {
		noticeTitle = request.getParameter("noticeTitle");
	}
	String noticeContent = "";
	if(request.getParameter("noticeContent") != null) {
		noticeContent = request.getParameter("noticeContent");
	}
	
	// 입력한 데이터를 받을 리스트 변수 생성
	ArrayList<Notice> list = new ArrayList<Notice>();
	
%>	
	<form method="post" action="<%=request.getContextPath()%>/notice/updateNoticeAction.jsp">
		<input type="hidden" name="noticeId" value="<%=noticeId%>">
		<table class="table table-striped">
			<tr>
				<td>notice_title</td>
				<td><input type="text" name="noticeTitle" value="<%=noticeTitle%>" class="form-control"></td>
			</tr>
			<tr>
				<td>notice_content</td>
				<td><textarea rows="5" cols="80" name="noticeContent" class="form-control"><%=noticeContent%></textarea></td>
			</tr>
		</table>
		<div class="d-flex justify-content-end">
			<button type="submit" class="btn btn-primary">수정하기</button>
		</div>
	</form>
</div>
</body>
</html>