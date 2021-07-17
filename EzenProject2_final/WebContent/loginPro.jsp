//로그인 처리 페이지
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
	
	String id = request.getParameter("id");
	String pw = request.getParameter("password");
	
	MemberDAO dao = new MemberDAO();
	int check = dao.loginCheck(id, pw);
	
	String msg ="";
	
	if(check==1){//로그인 성공
		session.setAttribute("sessionID", id);
		msg="main.jsp";
	}else if(check==0){
		msg="login.jsp?msg=0";
	}else{
		msg="login.jsp?msg=-1";
	}
	
	response.sendRedirect(msg);
	%>
</body>
</html>