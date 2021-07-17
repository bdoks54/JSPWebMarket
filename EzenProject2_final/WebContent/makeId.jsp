<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<style>
.inBorder {
 width: 200px;
 height: 30px; 
 border: 1px solid #666;
}
.id{
margin-bottom: 20px; 
text-align: left;
font-size: 17px;

}
.name{
margin-bottom: 20px; 
text-align: left;
font-size: 17px;
}
.password{
margin-bottom: 20px; 
text-align: left;
font-size: 17px;
}
.passwordRepeat{
margin-bottom: 20px; 
text-align: left;
font-size: 17px;
}
.email{
margin-bottom: 20px; 
text-align: left;
font-size: 17px;
}

.box{
text-align: center;
font-size: 30px;
width:150px;

}

</style>
<link rel="stylesheet" href="css/makeId.css">
</head>
<script type="text/javascript">
	
	function checkForm(){	

		var regExpName = /^[가-힣]*$/;
	
	    var regExpId = /^[0-9a-z]+$/;
	
		var regExpPw = /^[a-zA-Z0-9]{4,16}$/;
	
		var regExpPhone = /(\d{3}).*(\d{3}).*(\d{4})/;
	
		var regExpEmail = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;

		var strName = document.userInfo.name.value;
	    var strId = document.userInfo.id.value;
		var strPw = document.userInfo.password.value;
		var strPwR = document.userInfo.passwordRepeat.value;
		var strPhone = document.userInfo.pNum.value +"-"+document.userInfo.pNum2.value+"-"+document.userInfo.pNum3.value;
		var strEmail = document.userInfo.email1.value + "@"+ document.userInfo.email2.value;
	    
		if(document.userInfo.pNum2.value=="" && document.userInfo.pNum3.value==""){
			strPhone = "010-0000-0000";
		}
		if(document.userInfo.email1.value==""){
			strEmail = "none@none.no";
		}
		if(!regExpName.test(strName)){
			alert("이름은 한글만 입력해야합니다.");
			return;
		}
		if (!regExpId.test(strId)) {
			alert("아이디는 영문, 숫자만 입력 가능합니다.");
			return;
		}
		if(!regExpPw.test(strPw)){
			alert("비밀번호는 4~16자로 최소 1개의 숫자, 영어를 포함해야 합니다.");
			return;
		}
		if (!(strPw==strPwR)) {
			alert("비밀번호확인란을 확인해주세요.");
			return;
		}
		if(!regExpPhone.test(strPhone)){
			alert("전화번호를 확인해주세요.");
			return;
		}
		if(!regExpEmail.test(strEmail)){
			alert("이메일을 확인해주세요.");
			return;
		}
		
		document.userInfo.submit();
	}
	
	function confirmId(){
		if(document.userInfo.id.value==""){
			alert("ID를 입력하세요.");
			return;
		}
		url = "confirmId.jsp?id=" + document.userInfo.id.value;
		open(url, "confirm",
				"toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=300, height=200");
	}
	
	function emailOnChange(e){
		const value = e.value;
		
		document.getElementById("email2").value = value;
	}
	
	function disableBtn(){
		document.getElementById("submitBtn").disabled=true;
	}
	
</script>
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


	<section>
	<fieldset>
    <form method="post" action="showId.jsp" name="userInfo">
	<legend>회원가입</legend>
	<li style="list-style: none" class="name">이름*<br>
	<input type="text" name="name" class="inBorder" required>
	</li>
	<li style="list-style: none" class="id">아이디*<br>
	<input type="text" name="id" class="inBorder" required>
	<input type="button" value="중복확인" onclick="confirmId()">
	</li>
	<li style="list-style: none" class="password">비밀번호*<br>
	<input type="password" name="password" class="inBorder" required>
	</li>
	<li style="list-style: none" class="passwordRepeat">비밀번호확인*<br>
	<input type="password" name="passwordRepeat" required class="inBorder">
	</li>
	<li style="list-style: none" class="email">E-Mail<br>
	<input type="text" name="email1" class="inBorder" />@<input type="text" id="email2" name="email2" class="inBorder" /> 
	<select class="inBorder" onchange="emailOnChange(this)">
	<option value="">==직접입력==
	<option value="daum.net">daum.net
	<option value="naver.com">naver.com
	<option value="nate.com">nate.com
	</select>
	<li style="list-style: none" class="list">연락처<br>
	<select name="pNum" class="inBorder">
	<option value="010">010</option>
	<option value="02">02</option>
	<option value="031">031</option>
	<option value="032">032</option>
	<option value="033">033</option>
	<option value="041">041</option>
	<option value="042">042</option>
	<option value="043">043</option>
    <option value="044">044</option>
	<option value="051">051</option>
	<option value="053">053</option>
	<option value="054">054</option>
	<option value="055">055</option>
	<option value="061">061</option>
	<option value="063">063</option>
	<option value="064">064</option>
	</select>-<input type="text" maxlength="4" size="4" name="pNum2"class="inBorder" /> - <input type="text" maxlength="4" size="4" name="pNum3" class="inBorder" /></li>
	<br>	
	<input type="button" id="submitBtn" disabled value="가입" class="box" onclick="checkForm()"> 
	<br>
	<br>
	<br>
	<input type="reset" value="다시입력" class="box" onclick="disableBtn()"> 
	<br>
	<br>
	<br>
	<input type="button" value="취소" onclick="location.href='main.jsp'" class="box">
	</form>
	</fieldset>
	</section>
	
	<footer>
            <address>
                <div style="text-align : center;">
             <h3> <p> &copy이젠컴 / 회사소개 / 이용약관 / 전화번호 xxx-xxx-xxxx</p></h3>
              <h3><p> FAX:XXX-XXX-XXXX</p></h3>
           </div>
            </address>
	</footer>
</body>
</html>