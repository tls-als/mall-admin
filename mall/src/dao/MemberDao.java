package dao;
import commons.DBUtil;
import vo.*;
import java.sql.*;

import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

public class MemberDao {
	// 비밀번호 수정을 위한 메서드
	public void updateMemberPw(Member member) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		// 회원 정보 조회를 위한 쿼리
		String sql = "update member set member_pw = ? where member_email = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberPassword());
		stmt.setString(2, member.getMemberEmail());
		stmt.executeUpdate();
		System.out.println(stmt + "<--비번 수정 쿼리");
	}
	
	// 이메일에 따른 회원 정보 조회를 위한 메서드
	public Member selectMemberInfo(String memberEmail) throws Exception {
		// vo 객체 생성(데이터 담기, 리턴을 위해)
		Member member = null;
		// 데이터베이스 연결
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		// 회원 정보 조회를 위한 쿼리
		String sql = "select member_email, member_name, member_pw, member_date from member where member_email = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberEmail);
		// 쿼리문 실행
		ResultSet rs = stmt.executeQuery();
		System.out.println(rs + "<--쿼리실행");
		if(rs.next()) {
			member = new Member();
			member.setMemberEmail(rs.getString("member_email"));
			member.setMemberName(rs.getString("member_name"));
			member.setMemberPassword(rs.getString("member_pw"));
			member.setMemberDate(rs.getString("member_date"));
		}
		conn.close();
		return member;
	}
	
	//로그인을 위한 메서드. 리턴값이 있으면 즉,결과물이 나오면 로그인 성공
	public String login(Member member) throws Exception {
		// 결과값이 없으면 null을 리턴
		String memberEmail = null;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select member_email from member where member_email = ? and member_pw = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberEmail());
		stmt.setString(2, member.getMemberPassword());
		ResultSet rs = stmt.executeQuery();
		//로그인 성공
		if(rs.next()) {
			memberEmail = rs.getString("member_email");
		}		
		conn.close();
		return memberEmail;
	}
	
	// 회원 가입 메서드
	public void insertMember(Member member) throws Exception{
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "insert into member(member_email, member_pw, member_name, member_date) values(?,?,?,now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberEmail());
		stmt.setString(2, member.getMemberPassword());
		stmt.setString(3, member.getMemberName());
		stmt.executeLargeUpdate();
		conn.close();
	}
	
	public Member selectMemberEmailCk(String memberEmail) throws Exception{
		Member member = null;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select id from (select member_email id FROM member UNION SELECT admin_id id FROM admin) t WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberEmail);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			//  지금 입력한 이메일은 이미 존재하여 사용할 수 없음
			member = new Member();
			//member.memberEmail = rs.getString("id");
			member.setMemberEmail(rs.getString("id"));
		}
		System.out.println(member.getMemberEmail() + "<- 이메일 체크 결과값");
		conn.close();
		return member;
	}
}
