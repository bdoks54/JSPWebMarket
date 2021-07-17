<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.project2.ezen.MemberDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");

		MemberDAO dao = new MemberDAO();
		String email = request.getParameter("email");

		String id = dao.selectByEmail(email);
		if (id == null) {
	%>
	<p>
		가입하신 ID가 없습니다.
		<%
		} else {
	%>
	
	<p>
		ID는
		<%=id%>
		입니다.
		<%
			}
		%>
	
</body>
</html>