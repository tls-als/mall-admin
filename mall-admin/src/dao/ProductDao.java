package dao;

import java.sql.*;


import java.util.*;

import commons.DBUtil;
import vo.*;

public class ProductDao {
	/*
	 * 1. 쿼리가 다르면 메서드가 다르다. 메서드는 많아도 트래픽 발생X
	 * 2. 리턴되는 값이 있으면 리턴 값을 받을 객체변수를 생성해야 함.(ArrayList)
	 * 3. vo파라미터로 넘어오는 값이 있을 경우 vo 객체를 따로 생성할 필요가 없다.
	 * 4. 해당 페이지에서 생성된 객체에 저장된 값은 해당 페이지에서만 유지됨. 새로 객체 생성되면 그 페이지에선 초기값만 나옴.
	 */
	
	// 이미지를 수정하는 메서드(파일 업로드)
	public void updateProductPic(Product product) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "update product set product_pic = ? where product_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, product.getProductPic());
		stmt.setInt(2, product.getProductId());
		System.out.println(stmt + "<- 업데이트 쿼리");
		stmt.executeUpdate();
	}
	
	//select 외에 리턴값이 없음
	//판매 수정
	public void updateProductSoldout(int productId, String productSoldout) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "update product set product_soldout = ? where product_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		if(productSoldout.equals("Y")) {
			stmt.setString(1, "N");
		}else {
			stmt.setString(1, "Y");
		}
		stmt.setInt(2, productId);
		int row = stmt.executeUpdate();
			System.out.println(row+"행 수정");
	}
	
	//하나의 상품 상세조회
	public Product selectProductOne(int productId) throws Exception {
		Product product = null;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select product_id,category_id,product_name,product_price,product_content,product_soldout,product_pic from product where product_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			product = new Product();
//			product.productId = (rs.getInt("product_id"));
//			product.categoryId = (rs.getInt("category_id"));
//			product.productName = (rs.getString("product_name"));
//			product.productPrice = (rs.getInt("product_price"));
//			product.productContent = (rs.getString("product_content"));
//			product.productSoldout = (rs.getString("product_soldout"));
//			product.productPic = (rs.getNString("product_pic"));	//default.jpg
			product.setProductId(rs.getInt("product_id"));
			product.setCategoryId(rs.getInt("category_id"));
			product.setProductName(rs.getString("product_name"));
			product.setProductPrice(rs.getInt("product_price"));
			product.setProductContent(rs.getString("product_content"));
			product.setProductSoldout(rs.getString("product_soldout"));
			product.setProductPic(rs.getNString("product_pic"));
		}
		return product;
	}
	/*
	//상품 전체 리스트를 조회하는 메서드
	public ArrayList<Product> selectProductList() throws Exception {		
		ArrayList<Product> list = new ArrayList<Product>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select product_id,category_id,product_name,product_price,product_soldout from product";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Product p = new Product();
			p.productId = rs.getInt("product_id");
			p.categoryId = rs.getInt("category_id");
			p.productName = rs.getString("product_name");
			p.productPrice = rs.getInt("product_price");
			p.productSoldout = rs.getString("product_soldout");
			list.add(p);
		}
		conn.close();
		return list;
	}
	*/
	// 페이지에 따른 상품 리스트 조회
	public ArrayList<Product> selectProductListPasing(Paging paging) throws Exception {
		ArrayList<Product> list = new ArrayList<Product>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select product_id,category_id,product_name,product_price,product_soldout from product limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, (paging.getCurrentPage()-1)*paging.getRowPerPage());
		stmt.setInt(2, paging.getRowPerPage());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Product p = new Product();
//			p.productId = rs.getInt("product_id");
//			p.categoryId = rs.getInt("category_id");
//			p.productName = rs.getString("product_name");
//			p.productPrice = rs.getInt("product_price");
//			p.productSoldout = rs.getString("product_soldout");
			p.setProductId(rs.getInt("product_id"));
			p.setCategoryId(rs.getInt("category_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductSoldout(rs.getString("product_soldout"));
			list.add(p);
		}
		conn.close();
		return list;
	}
	//카탈로그 클릭시 조회되는 상품 목록 메서드
	public ArrayList<Product> selectProductByCategoryId(int categoryId, Paging paging) throws Exception {
		ArrayList<Product> list = new ArrayList<Product>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select product_id,category_id,product_name,product_price,product_soldout from product where category_id = ? limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryId);
		stmt.setInt(2, (paging.getCurrentPage()-1)*paging.getRowPerPage());
		stmt.setInt(3, paging.getRowPerPage());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Product p = new Product();
//			p.productId = rs.getInt("product_id");
//			p.categoryId = rs.getInt("category_id");
//			p.productName = rs.getString("product_name");
//			p.productPrice = rs.getInt("product_price");
//			p.productSoldout = rs.getString("product_soldout");
			p.setProductId(rs.getInt("product_id"));
			p.setCategoryId(rs.getInt("category_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductSoldout(rs.getString("product_soldout"));
			list.add(p);
		}
		conn.close();
		return list;
	}
	// 카테고리 리스트의 전체 목록 개수를 구하기 위한 메서드
	public int selectCountByCategory() throws Exception {
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		//System.out.println(stmt + "<--카테고리 전체 개수");
		return count;
	}
	
	// 상품 리스트의 전체 목록 개수를 구하기 위한 쿼리 메서드
	public int selectCount() throws Exception {
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM product";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		return count;
	}
	
	// 카테고리 별, 상품 리스트의 전체 목록 개수를 구하기 위한 쿼리 메서드
	public int selectCountByCategoryId(int categoryId) throws Exception {
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM product where category_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		return count;
	}
	
	//상품 추가
	public void insertProduct(Product product) throws Exception{
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "insert into product(category_id,product_name,product_price,product_content,product_soldout) values(?,?,?,?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
//		stmt.setInt(1, product.categoryId);
//		stmt.setString(2, product.productName);
//		stmt.setInt(3, product.productPrice);
//		stmt.setString(4, product.productContent);
//		stmt.setString(5, product.productSoldout);
		stmt.setInt(1, product.getCategoryId());
		stmt.setString(2, product.getProductName());
		stmt.setInt(3, product.getProductPrice());
		stmt.setString(4, product.getProductContent());
		stmt.setString(5, product.getProductSoldout());
		stmt.executeUpdate();
	}
	
	//상품 삭제
	public void deleteProduct(Product product) throws Exception{
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "delete from product where product_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, product.getProductId());
		stmt.executeUpdate();
	}
	//상품 수정
	public void updateProduct(Product product) throws Exception{
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "update product set product_name=?, product_price = ? where product_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, product.getProductName());
		stmt.setInt(2, product.getProductPrice());
		stmt.setInt(3, product.getProductId());
		stmt.executeUpdate();
	}
}
