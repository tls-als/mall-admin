package dao;

import java.util.ArrayList;	//ArrayList 사용하기 위한 import

import commons.DBUtil;
import vo.Category;	// Category(vo) 클래스 import
import vo.Paging;

import java.sql.*;	// 데이터베이스 사용을 위한 import

//데이터베이스에 접근하는 CategoryDao(dao) 클래스
public class CategoryDao {
	// Category를 추가하는 메서드(리턴값 없음)
	// throws Exception : 예외처리
	// 입력값 : Category category => categoryId, categoryName(카테고리 ID,Name을 함께 넘김)
	public void insertCategory(Category category) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();	// 중복되는 부분을 줄임
		String sql = "insert into category(category_name) values(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.executeLargeUpdate();
		conn.close();	//커넥션 사용 후 반드시 close();
	}
	
	// Category를 수정하는 메서드
	public void updateCategory(Category category) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "update category set category_name = ? where category_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setInt(2, category.getCategoryId());
		stmt.executeLargeUpdate();
		conn.close();
	}
	
	// Category 삭제하는 메서드
	public void deleteCategory(Category category) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "delete from category where category_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, category.getCategoryId());
		stmt.executeLargeUpdate();
		conn.close();
	}
	
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
			category.setCategoryId(rs.getInt("category_id"));
			//category.categoryName = rs.getString("category_name");
			category.setCategoryName(rs.getString("category_name"));
			list.add(category);
		}
		conn.close();	//커넥션은 클로즈해줘야 함
		return list;
	}
	// 페이지에 따른 상품 리스트 조회
	public ArrayList<Category> selectProductListPasing(Paging paging) throws Exception {
		ArrayList<Category> list = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select category_id, category_name from category limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, (paging.getCurrentPage()-1)*paging.getRowPerPage());
		stmt.setInt(2, paging.getRowPerPage());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category category = new Category();
//			category.categoryId = rs.getInt("category_id");
//			category.categoryName = rs.getString("category_name");
			category.setCategoryId(rs.getInt("category_id"));
			category.setCategoryName(rs.getString("category_name"));
			list.add(category);
		}
		conn.close();
		return list;
	}
	
	// 상품 리스트의 전체 목록 개수를 구하기 위한 쿼리 메서드
	public int selectCount() throws Exception {
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		return count;
	}
	
}
