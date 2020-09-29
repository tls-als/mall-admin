package dao;
import vo.*;
import java.util.*;

import commons.DBUtil;

import java.sql.*;

public class OrdersDao {
	
	// 주문의 상태를 수정하는 쿼리
	public void updateOrdersState(Orders orders) throws Exception{
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "update orders set orders_state = ? where orders_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, orders.getOrdersState());
		stmt.setInt(2, orders.getOrdersId());
		stmt.executeUpdate();
		conn.close();
	}
	
	// 주문상태 목록
	public ArrayList<String> selectOrdersStateList() throws Exception{
		// select distinct orders_state from orders(distinct : 중복제거)
		ArrayList<String> list = new ArrayList<String>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select distinct orders_state from orders";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			String state = new String();
			state = rs.getString("orders_state");
			list.add(state);
		}
		return list;
	}
	
	// 전체 주문의 리스트를 확인하는 쿼리 메서드
	public ArrayList<OrdersAndProduct> selectOrdersList() throws Exception{
		ArrayList<OrdersAndProduct> list = new ArrayList<OrdersAndProduct>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		/*
		 * select o.orders_id, o.product_id, o.orders_amount, o.orders_price, o.member_email, o.orders_addr, o.orders_state, o.orders_date, p.product_name
		 * from orders o inner join product p
		 * on o.product_id = p.product_id
		 */
		String sql = "select o.orders_id, o.product_id, o.orders_amount, o.orders_price, o.member_email, o.orders_addr, o.orders_state, o.orders_date, p.product_name "
				+ "from orders o inner join product p" + " on o.product_id = p.product_id";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrdersAndProduct oap = new OrdersAndProduct();
			oap.orders = new Orders();
			oap.product = new Product();
			
			oap.orders.setOrdersId(rs.getInt("o.orders_id"));
			oap.orders.setProductId(rs.getInt("o.product_id"));
			oap.orders.setOrdersAmount(rs.getInt("o.orders_amount"));
			oap.orders.setOrdersPrice(rs.getInt("o.orders_price"));
			oap.orders.setMemberEmail(rs.getString("o.member_email"));
			oap.orders.setOrdersAddr(rs.getString("o.orders_addr"));
			oap.orders.setOrdersState(rs.getString("o.orders_state"));
			oap.orders.setOrdersDate(rs.getString("o.orders_date"));
			oap.product.setProductName(rs.getString("p.product_name"));
			list.add(oap);
		}
		conn.close();
		return list;
	}
	
	// 조건에 따른 주문의 상태별 리스트를 확인하는 쿼리 메서드
	public ArrayList<OrdersAndProduct> selectOrdersListByState(String ordersState) throws Exception{
		ArrayList<OrdersAndProduct> list = new ArrayList<OrdersAndProduct>();
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "select o.orders_id, o.product_id, o.orders_amount, o.orders_price, o.member_email, o.orders_addr, o.orders_state, o.orders_date, p.product_name "
				+ "from orders o inner join product p" + " on o.product_id = p.product_id where orders_state = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ordersState);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrdersAndProduct oap = new OrdersAndProduct();
			oap.orders = new Orders();
			oap.product = new Product();
//			oap.orders.ordersId = rs.getInt("o.orders_id");
//			oap.orders.productId = rs.getInt("o.product_id");
//			oap.orders.ordersAmount = rs.getInt("o.orders_amount");
//			oap.orders.ordersPrice = rs.getInt("o.orders_price");
//			oap.orders.memberEmail = rs.getString("o.member_email");
//			oap.orders.ordersAddr = rs.getString("o.orders_addr");
//			oap.orders.ordersState = rs.getString("o.orders_state");
//			oap.orders.ordersDate = rs.getString("o.orders_date");
//			oap.product.productName = rs.getString("p.product_name");
			oap.orders.setOrdersId(rs.getInt("o.orders_id"));
			oap.orders.setProductId(rs.getInt("o.product_id"));
			oap.orders.setOrdersAmount(rs.getInt("o.orders_amount"));
			oap.orders.setOrdersPrice(rs.getInt("o.orders_price"));
			oap.orders.setMemberEmail(rs.getString("o.member_email"));
			oap.orders.setOrdersAddr(rs.getString("o.orders_addr"));
			oap.orders.setOrdersState(rs.getString("o.orders_state"));
			oap.orders.setOrdersDate(rs.getString("o.orders_date"));
			oap.product.setProductName(rs.getString("p.product_name"));
			list.add(oap);
		}
		System.out.println(ordersState);
		conn.close();
		return list;
	}
	
}
