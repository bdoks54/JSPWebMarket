<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/findId.css">
<script type="text/javascript">
	function findID(){
		document.getElementById("findID").style.display="block";
		document.getElementById("findPW").style.display="none";
	}
	function findPW(){
		document.getElementById("findID").style.display="none";
		document.getElementById("findPW").style.display="block";
	}
	
	function showID(){
		if(document.idForm.email.value==""){
			alert("이메일을 입력하세요.");
			return;
		}
		url = "showFindId.jsp?email=" + document.idForm.email.value;
		open(url, "showFindId",
				"toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=300, height=200");
	}
	function showPW(){
		if(document.pwForm.id.value==""){
			alert("ID를 입력하세요.");
			return;
		}
		url = "showFindPw.jsp?id=" + document.pwForm.id.value;
		open(url, "showFindPw",
				"toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=300, height=200");
	}
</script>
</head>
<body>
    <header>
        <img src="images/head.png" alt="로고" onclick="location.href='main.jsp'">
    </header>
    <div class="selectMode">
        <button onclick="findID()">아이디찾기</button>
        <button onclick="findPW()">비밀번호찾기</button>
    </div>

    <!--아이디찾기-->
    <div class="findID" id="findID">
        <p>내 정보에 등록된 인증 이메일로 찾기</p>
        <form name="idForm">
            <input type="text" name="email" placeholder="이메일 주소 입력"><br>
            <input type="button" value="확인" onclick="showID()">
        </form>
    </div>

    <!--비밀번호찾기-->
    <div class="findPW" id="findPW">
        <p>가입한 아이디로 찾기</p>
        <form name="pwForm">
            <input type="text" name="id" placeholder="아이디 입력"><br>
            <input type="button" value="확인" onclick="showPW()">
        </form>
    </div>
</body>
</html>