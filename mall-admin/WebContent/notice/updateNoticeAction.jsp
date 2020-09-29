<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<!-- 공지사항을 수정 실행하는 페이지 -->
<%
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");
	// request로 넘어오는 값 변수에 담기
	int noticeId = 0;
	if(request.getParameter("noticeId") != null) {
		noticeId = Integer.parseInt(request.getParameter("noticeId"));
	}
	String noticeTitle = "";
	if(request.getParameter("noticeTitle") != null) {
		noticeTitle = request.getParameter("noticeTitle");
	}
	String noticeContent = "";
	if(request.getParameter("noticeContent") != null) {
		noticeContent = request.getParameter("noticeContent");
	}
	//System.out.println(noticeId + "noticeId 값");
	//System.out.println(noticeTitle + "noticeTitle 값");
	//System.out.println(noticeContent + "noticeContent 값");
	
	// 데이터를 담을 vo객체 생성 후 데이터를 vo에 담기
	Notice notice = new Notice();
	//notice.noticeId = noticeId;	//공지번호
	//notice.noticeTitle = noticeTitle;	//공지제목
	//notice.noticeContent = noticeContent;
	notice.setNoticeId(noticeId);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	// 쿼리를 실행하기 위한 Dao 객체
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.updateNoticeList(notice);
	
	response.sendRedirect(request.getContextPath() + "/notice/noticeList.jsp");
%>