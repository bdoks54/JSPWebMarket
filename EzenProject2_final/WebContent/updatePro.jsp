<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.project2.ezen.QnABean"%>
<%@page import="com.project2.ezen.QnADAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		QnADAO dao = new QnADAO();
		QnABean dto = new QnABean();
		dto.setNum(request.getParameter("num"));
		dto.setTitle(request.getParameter("title"));
		dto.setContent(request.getParameter("content"));
		dao.update(dto);
		
		response.sendRedirect("board.jsp");
	%>
</body>
</html>