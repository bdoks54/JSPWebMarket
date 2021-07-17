<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.project2.ezen.MemberDAO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	function sendTrue(){
		opener.document.getElementById("submitBtn").disabled=false;
		self.close();
	}
	function sendFalse(){
		self.close();
	}
</script>
<body>
	<%
		String id = request.getParameter("id");
		MemberDAO dao = new MemberDAO();
		boolean result = dao.confirmId(id);
		
		if(result){%>
		<center>
		<br/><br/>
		<h4>이미 사용중인 ID입니다.</h4>
		<input type="button" value="닫기" onclick="sendFalse()">
		</center>
		<%}else{%>
		<center>
		<br/><br/>
		<h4>사용할 수 있는 ID입니다.</h4>
		<input type="button" value="닫기" onclick="sendTrue()">
		</center>
		<%}
	%>
		
</body>
</html>