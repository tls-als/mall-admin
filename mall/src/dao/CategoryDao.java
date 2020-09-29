package dao;

import java.util.ArrayList;	//ArrayList 사용하기 위한 import

import commons.DBUtil;
import vo.Category;	// Category(vo) 클래스 import

import java.sql.*;	// 데이터베이스 사용을 위한 import

//데이터베이스에 접근하는 CategoryDao(dao) 클래스
public class CategoryDao {	
	// Category 목록
	// ArrayList를 반환하는 selectCategoryList() 메서드
	public ArrayList<Category> selectCategoryList() throws Exception{
		ArrayList<Category> list = new ArrayList<Category>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select category_id, category_name from category";	
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category category = new Category();
//			category.categoryId = rs.getInt("category_id");
//			category.categoryName = rs.getString("category_name");
			category.setCategoryId(rs.getInt("category_id"));
			category.setCategoryName(rs.getString("category_name"));
			list.add(category);
		}
		conn.close();	//커넥션은 클로즈해줘야 함
		return list;
	}
	// 추천 Category 목록
	public ArrayList<Category> selectCategoryCkList() throws Exception{
		ArrayList<Category> list = new ArrayList<Category>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		// category_ck='Y'(추천) 4개 출력
		String sql = "select category_id, category_name, category_pic from category where category_ck='Y' limit 0,4";	
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category category = new Category();
//			category.categoryId = rs.getInt("category_id");		// rs.getInt("category_id")는 컬럼명이 아닌 AS도 올수 있다.
//			category.categoryPic = rs.getString("category_pic");
			category.setCategoryId(rs.getInt("category_id"));
			category.setCategoryName(rs.getString("category_name"));
			category.setCategoryPic(rs.getString("category_pic"));
			list.add(category);
		}
		conn.close();	//커넥션은 클로즈해줘야 함
		return list;
	}
}