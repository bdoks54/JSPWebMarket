package com.project2.ezen;

import java.sql.*;
import java.sql.Date;
import java.util.*;

public class QnADAO {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userid = "system";
	String passwd = "Tienanmen1989..";
	
	public QnADAO() {
		try {
			Class.forName(driver);
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public int getCount() {
		int count=0;
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query="SELECT count(*) FROM QnA";
		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(query);
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
	
	public List<QnABean> getList(int startRow, int endRow){
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query="SELECT rnum, qna_num, qna_id, qna_name,"
				+ " qna_title, qna_content, qna_date, "
				+ "qna_count FROM (select rownum as rnum, qna_num, qna_id, qna_name, qna_title, qna_content, " + 
				"qna_date, qna_count from (select * from qna order by qna_num desc))"
				+ "WHERE rnum between ? and ?";
		List<QnABean> list = new ArrayList<QnABean>();
		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					QnABean dto = new QnABean();
					dto.setNum(rs.getString("qna_num"));
					dto.setId(rs.getString("qna_id"));
					dto.setName(rs.getString("qna_name"));
					dto.setTitle(rs.getString("qna_title"));
					dto.setContent(rs.getString("qna_content"));
					dto.setDate(rs.getDate("qna_date"));	//날짜
					dto.setViewCount(rs.getInt("qna_count"));
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
	}//end getList
	
	public QnABean selectByNum(String num) {
		QnABean dto = new QnABean();
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query="SELECT * FROM qna WHERE qna_num=?";
		
		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto.setNum(rs.getString("qna_num"));
				dto.setId(rs.getString("qna_id"));
				dto.setNum(rs.getString("qna_num"));
				dto.setId(rs.getString("qna_id"));
				dto.setName(rs.getString("qna_name"));
				dto.setTitle(rs.getString("qna_title"));
				dto.setContent(rs.getString("qna_content"));
				dto.setDate(rs.getDate("qna_date"));	//날짜
				dto.setViewCount(rs.getInt("qna_count"));
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
		return dto;
		
	}//end selectByNum
	
	
	
	public void insert(String num, String id, String name, String title, String content, Date date, int viewCount) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			String query = "INSERT into QnA(qna_num, qna_id, qna_name, qna_title, qna_content, qna_date, qna_count) values(?,?,?,?,?,?,?) ";
			con=DriverManager.getConnection(url,userid,passwd);
			pstmt=con.prepareStatement(query);
			pstmt.setString(1, num);
			pstmt.setString(2, id);
			pstmt.setString(3, name);
			pstmt.setString(4, title);
			pstmt.setString(5, content);
			pstmt.setDate(6, date);
			pstmt.setInt(7, viewCount);
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
	
	public void update(QnABean dto) {
		String query="update qna set qna_title=?, qna_content=? where qna_num=?";
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getNum());
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
		
	}//end update
	
	public void addViewCount(String num) {
		QnABean dto = new QnABean();
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query="UPDATE qna set qna_count = qna_count+1 WHERE qna_num=?";
		
		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, num);
			pstmt.executeUpdate();
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
	}//end addViewCount
	
	public void deleteByNum(String num) {
		String query = "DELETE FROM qna WHERE qna_num="+num;
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
	
	public int getMaxNum() {
		int max=0;
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query="SELECT MAX(qna_num) FROM QnA";
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
}
