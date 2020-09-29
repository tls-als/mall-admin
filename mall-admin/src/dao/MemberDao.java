package dao;

import vo.Member;
import java.util.*;
import java.sql.*;

import commons.DBUtil;

public class MemberDao {
	// 회원 탈퇴를 위한 메서드 생성
	public void deleteMemberList(Member member) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "delete from member where member_email = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberEmail());
		stmt.executeUpdate();
	}
	
	// 회원 리스트를 조회하기 위한 메서드
	public ArrayList<Member> selectMemberList() throws Exception {
		// 리스트 객체 생성
		ArrayList<Member> list = new ArrayList<Member>();
		// DB 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select member_email, member_name, member_date from member";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			// vo 객체 생성
			Member member = new Member();
			member.setMemberEmail(rs.getString("member_email"));
			member.setMemberName(rs.getString("member_name"));
			member.setMemberDate(rs.getString("member_date"));
			list.add(member);
		}
		return list;
	}
}
