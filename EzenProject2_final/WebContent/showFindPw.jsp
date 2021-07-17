<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.project2.ezen.MemberDAO"%>
    <%@ page import="com.project2.ezen.MemberBean"%>
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
		String id = request.getParameter("id");

		MemberBean dto = dao.selectById(id);
		String pw = dto.getPassword();
		if (pw == null) {
	%>
	<p>
		가입하신 ID가 없습니다.
		<%
		} else {
	%>
	
	<p>
		비밀번호는
		<%=pw%>
		입니다.
		<%
			}
		%>
</body>
</html>