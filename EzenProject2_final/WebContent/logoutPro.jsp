<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그아웃 처리</title>
</head>
<body>
	<%session.invalidate();	//모든세션정보삭제
		response.sendRedirect("main.jsp");
	%>
</body>
</html>