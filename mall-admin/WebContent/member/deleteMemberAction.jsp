<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<!-- 회원 탈퇴를 위한 페이지 -->
<%
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");
	
	// 회원 이메일 받기
	String memberEmail = "";
	if(request.getParameter("memberEmail") != null) {
		memberEmail = request.getParameter("memberEmail");
	}
	System.out.println(memberEmail + "<-- 받은 이메일");
	
	// vo 객체 생성
	Member member = new Member();
	member.setMemberEmail(memberEmail);
	
	// dao 객체 생성
	MemberDao memberDao = new MemberDao();
	memberDao.deleteMemberList(member);
	
	response.sendRedirect(request.getContextPath() + "/member/memberList.jsp");
%>