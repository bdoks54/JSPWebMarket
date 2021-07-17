<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.project2.ezen.MemberBean"%>
<%@page import="com.project2.ezen.QnADAO"%>
<%@page import="com.project2.ezen.MemberDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	QnADAO Qdao = new QnADAO();
	MemberDAO Mdao = new MemberDAO();
	MemberBean dto = new MemberBean();
	
	String num = Integer.toString(Qdao.getMaxNum()+1);
	String id="";
	if(session.getAttribute("sessionID")!=null){
		id = session.getAttribute("sessionID").toString();
		dto = Mdao.selectById(id);
	}else{
		//아이디없으면 작성불가
	}
	String name = dto.getName();
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	Date date = new Date(System.currentTimeMillis());
	int viewCount = 0;

	Qdao.insert(num, id, name, title, content, date, viewCount);

	response.sendRedirect("board.jsp");
	%>
	
</body>
</html>