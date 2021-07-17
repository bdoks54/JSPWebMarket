<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="java.util.List"%>
<%@page import="com.sun.corba.se.spi.orbutil.fsm.Guard.Result"%>
<%
	//카테고리 선택을 위한 변수
	String category = request.getParameter("category");
	if(category == null){
		category = "";
	}
	

	//페이징을 위한 변수
	int pageSize= 4; //한페이지에 출력할 레코드 수
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum ="1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	
	//해당 페이지에서 시작할 레코드/마지막 레코드
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	int count=0;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ezen 쇼핑몰</title>
<link href="css/sample1.css" rel="stylesheet" type="text/css">
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
		<a href="./main.jsp"> <img src="images/head.png">
		</a>
		<form class="loginForm">
			<ul>
				<a href="logoutPro.jsp" class="isLogin">로그아웃</a>

				<a href="login.jsp" class="isNotLogin">로그인</a>

				<a href="makeId.jsp" class="isNotLogin">회원가입</a>

				<a href="cartview.jsp">장바구니</a>
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
		<li><a href="main.jsp?category=r">RAM</a></li>

		<li><a href="main.jsp?category=h">HDD</a></li>

		<li><a href="main.jsp?category=s">SSD</a></li>

		<li><a href="main.jsp?category=v">그래픽카드</a></li>

		<li><a href="main.jsp?category=c">CPU</a></li>

		<li><a href="main.jsp?category=m">메인보드</a></li>

		<li><a href="./board.jsp">고객게시판</a></li>
	</ul>


	</nav>
	<div class="container">
		<section> <%@ include file="dbconn.jsp"%>
		<%
			PreparedStatement pstmt=null;
		          	ResultSet rs = null;
		          	
		          	String selSql1 = "SELECT count(*) from product";
		          	String selSql2 = "";
		          	switch(category){
		           	case "r":
		           		selSql2 = " where product_id like 'r%'";
		           		break;
		           	case "h":
		           		selSql2 = " where product_id like 'h%'";
		           		break;
		           	case "s":
		           		selSql2 = " where product_id like 's%'";
		           		break;
		           	case "v":
		           		selSql2 = " where product_id like 'v%'";
		           		break;
		           	case "c":
		           		selSql2 = " where product_id like 'c%'";
		           		break;
		           	case "m":
		           		selSql2 = " where product_id like 'm%'";
		           		break;
		           	default:
		           		selSql2 = "";
		           	}
		          	pstmt = conn.prepareStatement(selSql1+selSql2);
		          	rs = pstmt.executeQuery();
		          	if(rs.next()){
		          		count = rs.getInt(1);
		          	}
		          	
		          	
		          	String sql1 = "select rnum, product_id, product_name, product_price, product_url, product_desc, product_durl from "+
		          			"(select rownum as rnum, rn, product_id, product_name, product_price, product_url, product_desc, product_durl from "+ 
		          					"(select rownum as rn, product_id, product_name, product_price, product_url, product_desc, product_durl from product";
		           	String sql2 = "";
		           	String sql3 = " order by product_id desc)) where rnum between ? and ?";
		          	
		           	switch(category){
		           	case "r":
		           		sql2 = " where product_id like 'r%'";
		           		break;
		           	case "h":
		           		sql2 = " where product_id like 'h%'";
		           		break;
		           	case "s":
		           		sql2 = " where product_id like 's%'";
		           		break;
		           	case "v":
		           		sql2 = " where product_id like 'v%'";
		           		break;
		           	case "c":
		           		sql2 = " where product_id like 'c%'";
		           		break;
		           	case "m":
		           		sql2 = " where product_id like 'm%'";
		           		break;
		           	default:
		           		sql2 = "";
		           	}
		          	
		          	pstmt=conn.prepareStatement(sql1+sql2+sql3);            
		           	pstmt.setInt(1, startRow);
		         	pstmt.setInt(2, endRow);		           	
		           	rs=pstmt.executeQuery();
		           	
		for(int i = startRow; i <= endRow; i++) {
			if (rs.next()) {
				%> <article class="at1"> <a
					href="ViewDetails.jsp?id=<%=rs.getString("product_id")%>"> <img
					src="${pageContext.request.contextPath}<%=rs.getString("product_url") %>"></a>
				<h3><%=rs.getString("product_name") %></h3>

				<h3><%=rs.getInt("product_price") %>원
				</h3>
				
				</article>
				
				 <%}
			}
			if(startRow > 1){
				%>
				
				<a class="moveBtn" href="main.jsp?pageNum=<%=currentPage-1 %>&&category=<%=category%>">이전</a>
				<%
			}
		
			if(endRow<count){
				%>
				<a class="moveBtn" style="margin-left:600px;" href="main.jsp?pageNum=<%=currentPage+1 %>&&category=<%=category%>">다음</a>
				
				<%
			}
			 %> <% 
        	if(rs != null)rs.close();
            if(pstmt !=null)pstmt.close();
            if(conn !=null)conn.close();
        	%> 
        	
        	</section>
		<sidebar class="sidebar">
             <img src="./images/img1.png" id=mainImage style="width:200px; height: 600px;">
            <script>
                var myImage=document.getElementById("mainImage");
                var imageArray=["images/img1.png", "images/img2.png", "images/img3.png"];
                var imageIndex=0;

                function changeImage() {
                    myImage.setAttribute("src", imageArray[imageIndex]);
                    imageIndex++;
                    if(imageIndex>=imageArray.length) {
                        imageIndex=0;
                    }
                }
                setInterval(changeImage,2000);
            </script>
        </sidebar>
	</div>
	
	<footer>
	<address>
		<div style="text-align: center;">
			<h3>
				<p>회사소개/ 이용약관 / 개인방침/ 전화번호 010-1111-2222</p>
			</h3>
			<h3>
				<p>FAX:02-111-2222</p>
			</h3>
		</div>
	</address>

	</footer>
	</div>
</body>
</html>