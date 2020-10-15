<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%	
	/* 공지사항 입력을 위한 페이지 */
	
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
<title>공지사항 입력</title>
<!-- 부트스트랩(CSS) 링크 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$("#btn").click(function(){
			if($("#noticeTitle").val() == ""){
				alert("제목을 입력하세요");
				return;
			}else if($("#noticeContent").val() == ""){
				alert("내용을 입력하세요");
				return;
			}
			$("#noticeForm").submit();
		});
	});
</script>
</head>
<body>
<div class="container">
	<!-- 상위 메뉴 목록 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	<!-- 공지사항 -->
	<div class="jumbotron">
		<h1>공지사항 입력</h1>
	</div>

	 <form method="post" action="<%=request.getContextPath()%>/notice/insertNoticeAction.jsp" id="noticeForm">
	 	<table class="table table-bordered">
	 		<tr>
	 			<td>공지 제목</td>
	 			<td><input type="text" name="noticeTitle" id="noticeTitle" class="form-control" placeholder="제목 입력을 입력하세요"></td>
	 		</tr>
	 		<tr>
	 			<td>공지 내용</td>
	 			<td>
	 				<textarea rows="10" cols="80" name="noticeContent" id="noticeContent" class="form-control" placeholder="내용 입력을 입력하세요"></textarea>
	 			</td>
	 		</tr>
	 	</table>
	 	<div class="d-flex justify-content-end">
	 		<button type="button" id="btn" class="btn btn-primary">등록하기</button>
	 	</div>
	 </form>
</div>
</body>
</html>