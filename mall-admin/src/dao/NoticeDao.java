package dao;

import vo.Notice;
import java.util.*;
import java.sql.*;

import commons.DBUtil;

public class NoticeDao {
	// 공지사항 삭제를 위한 쿼리
	public void deleteNoticeList(int noticeId) throws Exception {
		// 데이터베이스 이용을 위한 객체
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		// 공지사항 삽입 쿼리문
		String sql = "delete from notice where notice_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeId);
		stmt.executeUpdate();
		System.out.println(stmt + "<--삭제쿼리");
		conn.close();
	}
	
	// 공지사항 입력을 위한 쿼리
	public void insertNoticeList(Notice notice) throws Exception {
		// 데이터베이스 이용을 위한 객체
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		// 공지사항 삽입 쿼리문
		String sql = "insert into notice(notice_title, notice_content, notice_date) values(?,?,now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		// vo에 담긴 값을 파라미터에 설정
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		// 쿼리문 실행
		stmt.executeUpdate();
		System.out.println(stmt + "<-- 쿼리 결과값");
		// 커넥션 닫기
		conn.close();
	}
	
	// 공지 수정을 결과를 가져오는 쿼리
	public void updateNoticeList(Notice notice) throws Exception {
		// 데이터베이스 이용을 위한 객체
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		// 업데이트를 위한 쿼리문
		String sql = "update notice set notice_title = ?, notice_content = ? where notice_id = ? order by notice_date desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		// 파라미터에 값 세팅하기
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeId());
		//System.out.println(notice.getNoticeTitle() + "<- 타이틀");
		//System.out.println(notice.getNoticeId() + "<- 넘버");
		//System.out.println(notice.getNoticeContent() + "<- 내용");
		// 업데이트 실행
		stmt.executeLargeUpdate();		
		// 커넥션 종료
		conn.close();
	}
	
	//공지 목록을 가져오는 쿼리
	public ArrayList<Notice> selectNoticeList() throws Exception{
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select notice_id, notice_title, notice_content, notice_date from notice order by notice_date desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		//System.out.println(rs + "<- 쿼리실행문");
		while(rs.next()) {
			Notice notice = new Notice();
//			notice.noticeId = rs.getInt("notice_id");
//			notice.noticeTitle = rs.getString("notice_title");
//			notice.noticeContent = rs.getString("notice_content");
//			notice.noticeDate = rs.getString("notice_date");
			notice.setNoticeId(rs.getInt("notice_id"));
			notice.setNoticeTitle(rs.getString("notice_title"));
			notice.setNoticeContent(rs.getString("notice_content"));
			notice.setNoticeDate(rs.getString("notice_date"));
			list.add(notice);
		}
		conn.close();
		return list;
	}
}
