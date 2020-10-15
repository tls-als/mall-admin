<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 이미 로그인 상태라면
	if(session.getAttribute("loginAdminId") != null) {
		System.out.println("이미 로그인 상태입니다");
		response.sendRedirect("/mall-admin/index.jsp");
		return;	//밑에 것 실행 안됨.
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$("#btn").click(function() {
			if($("#adminId").val() == "") {
				alert("아이디를 입력하세요!");
				$("#adminId").focus();
				return;
			}else if($("#adminPw").val() == "") {
				alert("비밀번호를 입력하세요!");
				$("#adminPw").focus();
				return;
			}
		});
	});
</script>
</head>
<body>
<div class="container" align="center">
	<div class="jumbotron text-secondary">
		<h1>관리자 로그인</h1>
	</div>
	<div>
		<img class="rounded-circle" src="/mall-admin/image/login.gif">
	</div><br>
	<form method="post" action="/mall-admin/loginAction.jsp" id="loginForm">	<!-- 절대주소: /프로젝트명/파일 -->
	<table class="table-dark table-bordered">
		<tr>
			<td>관리자 ID</td>
			<td><input class="form-control" type="text" name="adminId" id="adminId" value="admin@gd.com"></td>
		</tr>
		<tr>
			<td>관리자 PW</td>
			<td><input class="form-control" type="password" name="adminPw" id="adminPw" value="1234"></td>
		</tr>
	</table><br>
	<button class="btn btn-secondary" type="button" id="btn">로그인</button>
	</form>
</div>
</body>
</html>