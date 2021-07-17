package com.project2.ezen;

import java.sql.*;
import java.sql.Date;
import java.util.*;

public class MemberDAO {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userid = "system";
	String passwd = "Tienanmen1989..";
	//private static MemberDAO instance;

	public MemberDAO() {
		try {
			Class.forName(driver);
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}




	//데이터 삽입
	public void insert(MemberBean member){
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();
		Connection con = null;
		PreparedStatement pstmt=null;

		try {
			con = DriverManager.getConnection(url, userid, passwd);
			con.setAutoCommit(false);

			String query = "Insert into customer(cust_id, cust_name, cust_password, cust_email, cust_pNum)"
					+ "		values(?,?,?,?,?)";

			pstmt = con.prepareStatement(query);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getPassword());
			if(member.getEmail1()==null) {
				pstmt.setString(4, null);
			}else {
				pstmt.setString(4, member.getEmail1()+"@"+member.getEmail2());

			}
			if(member.getpNum2()==null) {
				pstmt.setString(5, null);
			}else {
				pstmt.setString(5, member.getpNum()+"-"+member.getpNum2()+"-"+member.getpNum3());
			}
			int n = pstmt.executeUpdate();
			con.commit();

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

	//로그인 시 아이디 비밀번호 체크 메서드
	public int loginCheck(String id, String password) {
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null; 

		String dbPw = "";
		int x = -1;

		try {
			String query = "SELECT cust_password FROM customer WHERE cust_id=?";
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				dbPw = rs.getString("cust_password");

				if(dbPw.equals(password)) {
					x=1; //로그인 인증성공
				}else {
					x=0; //로그인 인증실패
				}

			}else {
				x=-1;	//아이디 정보없음
			}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return x;


	}//end loginCheck
	
	public MemberBean selectById(String id) {
		MemberBean dto = new MemberBean();
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query="SELECT * FROM customer WHERE cust_id=?";
		
		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto.setName(rs.getString("cust_name"));
				dto.setPassword(rs.getString("cust_password"));
				if(rs.getString("cust_email")!=null) {
				String[] mailArray = (rs.getString("cust_email").split("@"));
				dto.setEmail1(mailArray[0]);
				dto.setEmail2(mailArray[1]);
				}
				if(rs.getString("cust_Pnum")!=null) {
				String[] pNumArray = (rs.getString("cust_Pnum").split("-"));
				dto.setpNum(pNumArray[0]);
				dto.setpNum2(pNumArray[1]);
				dto.setpNum3(pNumArray[2]);
				}
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
	}//end selectById
	
	public boolean confirmId(String id) {
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query = "SELECT cust_id FROM customer WHERE cust_id=?";
		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result=true;
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
		return result;
	}//end confirmId
	
	public String selectByEmail(String email) {
		MemberBean dto = new MemberBean();
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query="SELECT * FROM customer WHERE cust_email=?";
		
		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto.setId(rs.getString("cust_id"));
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
		return dto.getId();
	}//end selectByEmail
	
	public String getNameById(String id) {
		String name="";
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query = "SELECT cust_name from customer where cust_id=?";
		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				name = rs.getString("cust_name");
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
		
		return name;
	}//end getNameById
}
