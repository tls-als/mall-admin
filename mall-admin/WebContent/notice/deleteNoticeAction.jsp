<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");

	// request 파라메터 값 받기
	int noticeId = 0;
	if(request.getParameter("noticeId") != null) {
		noticeId = Integer.parseInt(request.getParameter("noticeId"));
	}
	
	// 쿼리 실행을 위한 dao
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.deleteNoticeList(noticeId);
	
	response.sendRedirect(request.getContextPath() + "/notice/noticeList.jsp");
%>