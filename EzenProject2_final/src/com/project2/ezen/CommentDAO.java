package com.project2.ezen;

import java.sql.*;
import java.sql.Date;
import java.util.*;

public class CommentDAO {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userid = "system";
	String passwd = "Tienanmen1989..";
	
	public CommentDAO() {
		try {
			Class.forName(driver);
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	//ÀÏ¹Ý´ñ±Û ÀÔ·Â(ºÎ¸ð´ñ±Û ¾øÀ½)
	public void insertC(String num, String boardNum, String id, Date date, String content) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			String query = "INSERT INTO COMMENT_BOARD(comment_num, comment_board, comment_id, comment_date, comment_content) VALUES(?,?,?,?,?)";
			con=DriverManager.getConnection(url,userid,passwd);
			pstmt=con.prepareStatement(query);
			pstmt.setString(1, num);
			pstmt.setString(2, boardNum);
			pstmt.setString(3, id);
			pstmt.setDate(4, date);
			pstmt.setString(5, content);
			int n=pstmt.executeUpdate();
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
	}//end insert
	
	//´ë´ñ±Û ÀÔ·Â
	public void insertCc(String num, String boardNum, String id, Date date,String parent, String content) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			String query = "INSERT INTO COMMENT_BOARD(comment_num, comment_board, comment_id, comment_date,comment_parent, comment_content) VALUES(?,?,?,?,?,?)";
			con=DriverManager.getConnection(url,userid,passwd);
			pstmt=con.prepareStatement(query);
			pstmt.setString(1, num);
			pstmt.setString(2, boardNum);
			pstmt.setString(3, id);
			pstmt.setDate(4, date);
			pstmt.setString(5, parent);
			pstmt.setString(6, content);
			int n=pstmt.executeUpdate();
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
	}
	
	public List<CommentBean> getListByBNum(String boardNum) {
		List<CommentBean> list=new ArrayList<CommentBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM COMMENT_BOARD WHERE comment_board=?";
		
		try {
			con=DriverManager.getConnection(url,userid,passwd);
			pstmt=con.prepareStatement(query);
			pstmt.setString(1, boardNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				do {
					CommentBean dto= new CommentBean();
					if(rs.getString("comment_parent")==null) {	//ºÎ¸ð´ñ±ÛÀÌ¾øÀ½=ÀÏ¹Ý´ñ±Û¸¸ ºÒ·¯¿È
					dto.setNum(rs.getString("comment_num"));
					dto.setBoardNum(rs.getString("comment_board"));
					dto.setId(rs.getString("comment_id"));
					dto.setDate(rs.getDate("comment_date"));
					dto.setContent(rs.getString("comment_content"));
					list.add(dto);
					}
				}while(rs.next());
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try{
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}		
		return list;
		
	}//end selectByBNum
	
	public List<CommentBean> getListByParent(String parentNum){
		List<CommentBean> list=new ArrayList<CommentBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM COMMENT_BOARD WHERE comment_parent=?";

		try {
			con=DriverManager.getConnection(url,userid,passwd);
			pstmt=con.prepareStatement(query);
			pstmt.setString(1, parentNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				do {
					CommentBean dto = new CommentBean();
					dto.setNum(rs.getString("comment_num"));
					dto.setBoardNum(rs.getString("comment_board"));
					dto.setId(rs.getString("comment_id"));
					dto.setDate(rs.getDate("comment_date"));
					dto.setContent(rs.getString("comment_content"));
					list.add(dto);
				}while(rs.next());
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try{
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}		
		return list;
	}//end getListByParent
	
	public int getCount(String BNum) {
		int count=0;
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query="SELECT count(*) FROM COMMENT_BOARD WHERE COMMENT_BOARD = ?";
		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, BNum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try{
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}		
		
		return count;
	}//end getCount
	
	public int getCcCount(String CNum) {
		int ccCount=0;
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query="SELECT count(*) FROM COMMENT_BOARD WHERE COMMENT_BOARD = ? AND COMMENT_PARENT is not null";
		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, CNum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				ccCount = rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try{
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}		
		return ccCount;
	}//end getCcCount
	
	public int getMaxNum() {
		int max=0;
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query="SELECT MAX(comment_num) FROM comment_board";
		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				max = rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try{
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}		
		return max;
	}//end getMaxNum
	
	public void deleteByNum(String num) {
		String query = "DELETE FROM comment_board WHERE comment_num="+num;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(query);
			pstmt.executeUpdate();
		
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
	}//end deleteByNum
}
