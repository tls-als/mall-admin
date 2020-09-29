package dao;
import java.sql.*;

import commons.DBUtil;
import vo.*;

public class AdminDao {
	public Admin login(Admin admin) throws Exception {
		Admin returnadmin = null;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select admin_id from admin where admin_id=? and admin_pw=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		//매개변수 admin으로 받은 값
		//stmt.setString(1, admin.adminId);
		stmt.setString(1, admin.getAdminId());
		stmt.setString(2, admin.getAdminPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			// 객체 변수 지정
			returnadmin = new Admin();
			// 비번은 보안 문제로 안 넘김
			returnadmin.setAdminId(rs.getString("admin_id"));
		}
		return returnadmin;	//null이면 로그인실패, 아니면 로그인 성공
	}
}