<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 이미 로그인 중이면 인덱스로 이동 
	if(session.getAttribute("loginMemberId") != null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		// return의  의미 1.메소드를 끝낸다 	2.값을 남길 수 있다
		return;	// void타입. int였으면 return 0;
	}

	request.setCharacterEncoding("utf-8");
	String memberEmail = request.getParameter("memberEmail");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	System.out.println(memberEmail + "<- 회원가입 액션 이메일");
	System.out.println(memberPw + "<- 회원가입 액션 이메일");
	System.out.println(memberName + "<- 회원가입 액션 이메일");
	
	// 아무런 값도 입력하지 않았을 때
	if(memberEmail.equals("") || memberPw.equals("") || memberName.equals("")) {
		response.sendRedirect(request.getContextPath()+"/member/signup.jsp");
		return;
	}

	// 사용 가능한 이메일인지 아닌지 확인
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberEmailCk(memberEmail);	// 가입 이메일 체크 메서드
	if(member != null) {
		System.out.println("이미 사용중인 이메일입니다");
		response.sendRedirect(request.getContextPath()+"/member/signup.jsp");
		return;
	}
	
	Member paramMember = new Member();
	//paramMember.memberEmail = memberEmail;
	//paramMember.memberPassword = memberPw;
	//paramMember.memberName = memberName;
	paramMember.setMemberEmail(memberEmail);
	paramMember.setMemberPassword(memberPw);
	paramMember.setMemberName(memberName);
	memberDao.insertMember(paramMember);	//회원가입메서드 호출
	
	response.sendRedirect(request.getContextPath()+"/member/login.jsp");
%>