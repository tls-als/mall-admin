<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//한글 인코딩
	request.setCharacterEncoding("utf-8");

	//login.jsp에서 보낸 로그인 입력값 받기
	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");
	//넘어온 파라메터 값 vo변수에 저장
	Admin paramAdmin = new Admin();
	//paramAdmin.adminId = adminId;
	//paramAdmin.adminPw = adminPw;
	paramAdmin.setAdminId(adminId);
	paramAdmin.setAdminPw(adminPw);
	//dao 객체 생성
	AdminDao adminDao = new AdminDao();
	Admin loginAdmin = adminDao.login(paramAdmin);
	if(loginAdmin == null) {
		System.out.println("로그인 실패");
		response.sendRedirect("/mall-admin/login.jsp");
	}else {
		System.out.println("로그인 성공");
		//로그인 정보를 세션에 저장(page < reqeust < session < application)
		session.setAttribute("loginAdminId", loginAdmin.getAdminId());	//세션에 변수 만드는 방법. 해당 변수가 없으면 로그인 안 된것
		response.sendRedirect("/mall-admin/index.jsp");
	}
%>