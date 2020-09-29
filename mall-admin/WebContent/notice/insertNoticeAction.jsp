<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<!-- 공지사항 액션 -->
<%
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");

	// request 파라메터 데이터 받기
	String noticeTitle = "";	// 공지제목
	if(request.getParameter("noticeTitle") != null) {
		noticeTitle = request.getParameter("noticeTitle");
	}
	String noticeContent = "";	// 공지내용
	if(request.getParameter("noticeContent") != null) {
		noticeContent = request.getParameter("noticeContent");
	}
	System.out.println(noticeTitle + "<--공지제목");
	System.out.println(noticeContent + "<--공지내용");
	
	// vo 객체 생성 후에 데이터 담기
	Notice notice = new Notice();
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	// dao 객체 생성하기
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.insertNoticeList(notice);
	
	response.sendRedirect(request.getContextPath() + "/notice/noticeList.jsp");
%>
