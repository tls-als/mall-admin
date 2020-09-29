package dao;
import java.util.*;

import commons.DBUtil;
import java.sql.*;
import vo.*;

public class NoticeDao {
	public ArrayList<Notice> selectNoticeList() throws Exception{
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select notice_id, notice_title from notice order by notice_date desc limit 0, 2";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			//n.noticeId = rs.getInt("notice_id");
			n.setNoticeId(rs.getInt("notice_id"));
			//n.noticeTitle = rs.getNString("notice_title");
			n.setNoticeTitle(rs.getNString("notice_title"));
			list.add(n);
		}
		conn.close();
		return list;
	}
	
//	public ArrayList<Notice> selectNoticeOne() throws Exception{
//		DBUtil dbUtil = new DBUtil();
//		Connection conn = dbUtil.getConnection();
//		
//		return null;
//	}
}
