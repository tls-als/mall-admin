<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>

<!-- 해당 페이지는 로그인 액션을 수행하는 페이지입니다. -->

<%
	//이미 로그인 중이면 인덱스로 이동 
	if(session.getAttribute("loginMemberId") != null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		// return의  의미 1.메소드를 끝낸다 	2.값을 남길 수 있다
		return;	// void타입. int였으면 return 0;
	}
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");
	// request로 파라메터 값 받기
	String memberEmail = request.getParameter("memberEmail");
	String memberPw = request.getParameter("memberPw");
	// 디버깅
	System.out.println(memberEmail + "<-memberEmail");
	System.out.println(memberPw + "<-memberPw");
	// 데이터를 담을 vo객체 생성
	Member paramMember = new Member();
	// vo 객체에 이메일,비밀번호 값 담기
	//paramMember.memberEmail = memberEmail;
	//paramMember.memberPassword = memberPw;
	paramMember.setMemberEmail(memberEmail);
	paramMember.setMemberPassword(memberPw);

	// 쿼리를 실행하기 위한 dao 객체 생성
	MemberDao memberDao = new MemberDao();
	// 결과값을 변수에 담기(이메일 조회)
	String loginMemberEmail = memberDao.login(paramMember);
	// 이메일 값이 없으면 로그인 페이지로 이동
	if(loginMemberEmail == null) {
		System.out.println("memberEmail == null");
		response.sendRedirect(request.getContextPath() + "/member/login.jsp");
	// 이메일값이 있으면 인덱스 화면으로 이동
	} else{
		// 세션에 loginMemberEmail 회원 이메일 값 설정하기
		session.setAttribute("loginMemberEmail", memberEmail);
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	}
%>