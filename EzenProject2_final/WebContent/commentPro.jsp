<%@page import="java.sql.Date"%>
<%@page import="com.project2.ezen.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String pageNum = request.getParameter("pageNum");
		CommentDAO cdao = new CommentDAO();
		
		String num = Integer.toString(cdao.getMaxNum()+1);
		String boardNum = request.getParameter("boardNum");
		String id = request.getParameter("id");
		String content = request.getParameter("comment_content");
		Date date = new Date(System.currentTimeMillis());
		String parent = request.getParameter("parent");
		
		if(parent==null){
			//부모댓글이 없으면 일반댓글에 추가
			cdao.insertC(num, boardNum, id, date, content);
		}else{
			//부모댓글이 있으면 대댓글에 추가
			cdao.insertCc(num, boardNum, id, date, parent, content);
		}
		
		response.sendRedirect("readBoard.jsp?num="+boardNum+"&pageNum="+pageNum);
	%>
</body>
</html>