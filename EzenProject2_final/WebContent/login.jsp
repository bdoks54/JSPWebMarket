<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
    <link rel="stylesheet" href="css/login.css?ver=5">
    <style>
    </style>
</head>

<body>
    <header>
         <div style="text-align : left" >  
         <a href="./main.jsp"> <img src="images/head.png">
		</a>
         
         <form> 
             <ul>
           <li><a href="login.jsp"><span>로그인</span></a></li>

           <li><a href="./makeId.jsp"><span>회원가입</span></a></li>
  
           <li n><a href="./장바구니.html"><span>장바구니</span></a></li>          
        </ul>     
        </form>
    </div>

	</header>
    <nav class="navi" style="margin-bottom:50px;">
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

    <section>
        <div class="login-form" style="background-color: white;">
          <form name="loginForm" action="loginPro.jsp" method="post" >
           <input type="text" name="id" class="text-field" placeholder="아이디" style="border: 1px solid rgb(17, 219, 226)">
           <input type="password" name="password" class="text-field" placeholder="비밀번호" style="border: 1px solid rgb(17, 219, 226)">
           <input type="submit" value="로그인" class="submit-btn">
           <div class="links">
            <a href="findId.jsp">아이디를 잊으셨을땐 여기를 눌러주세요.</a>
            <p>
            <a href="findId.jsp">비밀번호를 잊으셨을땐 여기를 눌러주세요.</a>
           </div>
           </div>
            
            <%
            	//아이디, 비밀번호가 틀린 경우
            	String msg = request.getParameter("msg");
                		
                if(msg!=null&&msg.equals("0")){
                	out.println("<br>");
                	out.println("<font color='red' size='5'>비밀번호를 확인해주세요.</font>");
                }else if(msg!=null&&msg.equals("-1")){
                	out.println("<br>");
                	out.println("<font color='red' size='5'>아이디를 확인해 주세요.</font>");
                }
            %>
            
        </form>
  </section>
    <sidebar class="sidebar"> 
		<img src="images/img1.png" id=mainImage style="width:200px; height: 600px;">
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
    <footer>
        <address>
            <div style="text-align : center;">
                <h3>
                    <p> 회사소개/ 이용약관 / 개인방침/ 전화번호 010-1111-2222</p>
                </h3>
                <h3>
                    <p> FAX:02-111-2222</p>
                </h3>
            </div>
        </address>

    </footer>
</body>
</html>