<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="dbconn.jsp"%>
    <%		
    request.setCharacterEncoding("UTF-8");
    		String custid = request.getParameter("custid");
    		String prodid = request.getParameter("prodid");
    		String score = request.getParameter("score");
    		String review = request.getParameter("content");
		 	PreparedStatement pstmt=null;
		 	ResultSet rs = null;
		 	
          
			String sql2 = "SELECT * FROM score WHERE score_custid=? and score_prodid=?";
			pstmt=conn.prepareStatement(sql2);
			pstmt.setString(1, custid);
			pstmt.setString(2, prodid);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				String sql3="UPDATE score SET score_score=?, score_review=? WHERE score_custid=? and score_prodid=?";
				pstmt = conn.prepareStatement(sql3);
				pstmt.setString(1, score);
				pstmt.setString(2, review);
				pstmt.setString(3, custid);
				pstmt.setString(4, prodid);
				pstmt.executeUpdate();
			}else{
				String sql="insert into score values(?,?,?,?)";
		           pstmt=conn.prepareStatement(sql); 
		           pstmt.setString(1, custid);
		           pstmt.setString(2, prodid);
		           pstmt.setString(3, score);
		           pstmt.setString(4, review);
		           int n = pstmt.executeUpdate();
			}
		 	
		 	
           
                                  
           if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
        	
        	
			response.sendRedirect("ViewDetails.jsp?id="+prodid);                                      
         %>
</body>
</html>