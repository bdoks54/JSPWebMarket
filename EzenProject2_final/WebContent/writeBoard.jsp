<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <link href="css/sample3.css" rel="stylesheet" type="text/css">
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
        <div style="text-align : left">
            <a href="./main.jsp"> <img src="images/head.png">
		</a>
            <form>
                <ul>
                    <a href="logoutPro.jsp" class="isLogin">로그아웃</a>

                    <a href="login.jsp" class="isNotLogin">로그인</a>

                    <a href="makeId.jsp" class="isNotLogin">회원가입</a>

                    <a href="장바구니">장바구니</a>
                </ul>
            </form>
            <%
            if(session.getAttribute("sessionID")!=null){
    			out.println("<p class=\"isLogin\">"+session.getAttribute("sessionID")+"님 안녕하세요.</p>");
    		}
            %>
        </div>

    </header>
    <nav class="navi" style="margin-bottom:30px;">
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
        <section>
           <form action="writePro.jsp" method="post">
		<table border="1" width="1130px">
			<tr>
				<td>제목 <input type="text" name="title"></td>

			</tr>
			<tr>
				<td><textarea rows="5" cols="100" name="content"></textarea></td>
			</tr>
			<tr align="right">
				<td>
				<input type="submit" value="작성">
				<input type="button" value="취소" onclick="location.href='board.jsp'">
				</td>
			</tr>
		</table>
	</form>
        </section>
    </div>
    <footer>
        <address>
            <div style="text-align : center;">
                <h3>
                    <p> 회사소개/ 이용약관 / 개인방침/ 전화번호 xxx-xxx-xxxx</p>
                </h3>
                <h3>
                    <p> FAX:XXX-XXX_XXXX</p>
                </h3>
            </div>
        </address>

    </footer>
    </div>
</body>
</html>