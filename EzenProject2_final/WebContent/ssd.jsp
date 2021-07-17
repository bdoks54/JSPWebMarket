<%@page import="com.sun.corba.se.spi.orbutil.fsm.Guard.Result"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SSD</title>
<link href="${pageContext.request.contextPath}/css/list.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%request.setCharacterEncoding("UTF-8"); 
		
	%>
	<%
            if(session.getAttribute("sessionID")!=null){
    			out.println("<style>.isLogin{display:inline;}.isNotLogin{display:none;}</style>");
    		}else{
    			out.println("<style>.isLogin{display:none;}</style>");
    		}
            %>


	<header>
	<div style="text-align: left">
		<a href="./main.jsp"><img src="${pageContext.request.contextPath}/image/head.png"></a>
		<form>
			<ul>
				<a href="logoutPro.jsp" class="isLogin">로그아웃</a>

				<a href="login.jsp" class="isNotLogin">로그인</a>

				<a href="makeId.jsp" class="isNotLogin">회원가입</a>

				<a href="cartview.jsp" class="isNotLogin">장바구니</a>
			</ul>
		</form>
		<%
            if(session.getAttribute("sessionID")!=null){
    			out.println("<p class=\"isLogin\">"+session.getAttribute("sessionID")+"님 안녕하세요.</p>");
    		}
            %>
	</div>

	</header>
	<nav class="navi">
	<ul>
		<li><a href="RAM.jsp">RAM</a></li>

		<li><a href="HDD.jsp">HDD</a></li>

		<li><a href="ssd.jsp">SSD</a></li>

		<li><a href="VGA.jsp">그래픽카드</a></li>

		<li><a href="cpu.jsp">CPU</a></li>

		<li><a href="MB.jsp">메인보드</li>

		<li><a herf="./board.jsp">고객게시판</a></li>
	</ul>


	</nav>

	<div class="container">

		<section>
		<%@ include file="dbconn.jsp" %>
		 <%
		 PreparedStatement pstmt=null;
          ResultSet rs=null;
          String sql="select * from product where product_id like 's%'";
           pstmt=conn.prepareStatement(sql);              
           rs=pstmt.executeQuery();
           while(rs.next()){
     				                                      
         %> 
         <article class="at1">
         <a href="ViewDetails.jsp?id=<%=rs.getString("product_id")%>"> <img src="${pageContext.request.contextPath}<%=rs.getString("product_url") %>" ></a>
		<h3><%=rs.getString("product_name") %></h3>
		<h3><%=rs.getInt("product_price") %>원</h3>
	    <p></p>
	     <button type="submit" onclick="location.href='cartview.jsp?id=<%=rs.getString("product_id")%>'" class="button"  >
	           장바구니</button>
	                          
	     <button type="submit" onclick="location.href='cartview.jsp?id=<%=rs.getString("product_id")%>'" class="button">
	                구매하기</button>         
	     	     	     
		</article> 
		<%} %>
		
    <% 
        	if(rs != null)rs.close();
            if(pstmt !=null)pstmt.close();
            if(conn !=null)conn.close();
        	%>
        
		   
             
                 </section>

		<sidebar class="sidebar"> </sidebar>
	</div>
	<footer>
	<address>
		<div style="text-align: center;">
			<h3>
				<p>회사소개/ 이용약관 / 개인방침/ 전화번호 xxx-xxx-xxxx</p>
			</h3>
			<h3>
				<p>FAX:XXX-XXX_XXXX</p>
			</h3>
		</div>
	</address>

	</footer>
	</div>
</body>
</html>