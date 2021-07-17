package com.project2.ezen;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;

public class OrderDAO {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userid = "system";
	String passwd = "Tienanmen1989..";
	
	public OrderDAO() {
		try {
			Class.forName(driver);
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	
	public int insert(OrderDTO odto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int cnt=0;
		try {
			String query = "INSERT into ordertb(order_id,order_name,order_phone,order_postcode,order_address,order_detailaddress,order_extraaddress,fk_cust_id,order_date) values(order_seq.NEXTVAL,?,?,?,?,?,?,?,sysdate) ";
			con=DriverManager.getConnection(url,userid,passwd);
			pstmt=con.prepareStatement(query);
			pstmt.setString(1, odto.getOrder_name());
			pstmt.setString(2, odto.getOrder_phone());
			pstmt.setString(3, odto.getOrder_postcode());
			pstmt.setString(4, odto.getOrder_address());
			pstmt.setString(5, odto.getOrder_detailaddress());
			pstmt.setString(6, odto.getOrder_extraaddress());
			pstmt.setString(7, odto.getFk_cust_id());
			cnt =pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			}catch(SQLException e) {
				
				
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	
	
	
	
	

	
	public OrderDTO read(int order_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		OrderDTO dto=null;
	
		
		try {
			
			con=DriverManager.getConnection(url,userid,passwd);
			String query = "SELECT o.order_name,o.order_phone,o.order_postcode,o.order_address,o.order_detailaddress,o.order_extraaddress,o.order_date ,o.order_id,o.fk_cust_id FROM customer c join  ordertb o on c.cust_id=o.fk_cust_id where o.order_id=? ";
			pstmt=con.prepareStatement(query);			
			pstmt.setInt(1, order_id);
			rs=pstmt.executeQuery();
			
		   if(rs.next()) {
			  dto=new OrderDTO();
			   dto.setOrder_name(rs.getString("order_name"));
			   dto.setOrder_phone(rs.getString("order_phone"));
			   dto.setOrder_postcode(rs.getString("order_postcode"));
			   dto.setOrder_address(rs.getString("order_address"));
			   dto.setOrder_detailaddress(rs.getString("order_detailaddress"));
			   dto.setOrder_extraaddress(rs.getString("order_extraaddress"));
			   dto.setOrder_date(rs.getDate("order_date"));
			   dto.setFk_cust_id(rs.getString("fk_cust_id"));
			   dto.setOrder_id(rs.getInt("order_id"));
			
			   
			 
		   }else {
			   dto=null;
		   }
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			}catch(SQLException e) {
				
				
				e.printStackTrace();
			}
		}
		return dto;
	}
	
	
	
	
}
