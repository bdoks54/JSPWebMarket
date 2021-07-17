<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.project2.ezen.QnABean"%>
<%@page import="com.project2.ezen.QnADAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	int num = Integer.parseInt(request.getParameter("num"));
	QnADAO dao = new QnADAO();
	QnABean dto = dao.selectByNum(request.getParameter("num"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정하기</title>
<style>
header {
    
   
 height: 110px;
 width:1330px;
 background-color:White; 
 border:10px solid rgb(17, 219, 226);
 padding: 10px; 
 margin: 0 auto;
 margin-bottom: 30px;
    

}

header form {
    
    float: right;
}

header form ul{
    
    list-style: none;
    margin:0;
    padding:0;
}

header form ul li{

    margin: 0 0 0 0;
    padding: 0 0 0 0;
    border : 0;
    float: left;
    margin-left: 10px;
    
}
header a {
    text-decoration: none;
    color: black;
}

.board_write { 
    border-top: 5px solid rgb(17, 219, 226);
}

footer {
   
    clear:both;
    width:1330px;
    height:100px;
    border:1px solid rgb(17, 219, 226);
    font-size:18px 돋움;
    margin: 0 auto;
}

footer a{
    color: black;
    text-decoration: none;
}

</style>
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
	
	<div class="board_write" style="width: 1330px; margin: 0 auto;">
	<form action="updatePro.jsp" method="post" >
	<input type="hidden" name="num" value="<%=dto.getNum() %>">
	
	 <div>
	  <h2>수정하기</h2>
	 </div>
	 
	 <hr style="border-top: 5px solid rgb(17, 219, 226);">
	 <h3>제목</h3>
	 <input type="text" name="title" value="<%=dto.getTitle()%>" style="font-size: 20px;">
	 
	 <br>
	 <br>
	 
	 <h3>글 수정하기</h3> 
	 <textarea rows="10" cols="30" name="content" style="height: 300px; width: 1330px; font-size: 20px;"><%=dto.getContent()%></textarea>

     <div style="text-align: right; margin-bottom: 30px; margin-top: 30px">
	 <input type="submit" value="확인" style="width: 150px; font-size: 20px; border-radius: 100px; border: 1px solid dodgerblue; " >
	 <input type="button" value="취소" onclick="history.go(-1)" style="width: 150px; font-size: 20px; border-radius: 100px; border: 1px solid red;">
     </div>
     
	 </form>
	 
	</div>

<footer>
            <address>
                <div style="text-align : center;">
             <h3> <p> &copy이젠컴 / <a href="notice.html">회사소개</a> / <a href="service.html">이용약관</a> / 전화번호 010-111-2222</p></h3>
              <h3><p> FAX:02-111-2222</p></h3>
           </div>
            </address>
</footer>
	
</body>
</html>