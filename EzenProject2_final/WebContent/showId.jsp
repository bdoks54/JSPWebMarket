<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.project2.ezen.MemberBean"%>
<%@ page import="com.project2.ezen.MemberDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>가입 완료</title>
<link rel="stylesheet" href="css/showId.css">
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>

	<jsp:useBean id="memberBean" class="com.project2.ezen.MemberBean"></jsp:useBean>
	<jsp:setProperty property="*" name="memberBean" />

	<%
		MemberDAO dao = new MemberDAO();

		dao.insert(memberBean);
	%>
	<div>가입을 환영합니다</div>
	<br>

	<div>
		<table>
			<tr>
				<td id="title">아이디</td>
				<td><%=memberBean.getId()%></td>
			</tr>
			<tr>
				<td id="title">이름</td>
				<td><%=memberBean.getName()%></td>
			</tr>

			<tr>
				<td id="title">메일</td>
				<td><%=memberBean.getEmail1()%></td>
				<% if(memberBean.getEmail1()!=null){
					%>
				<td>@<%=memberBean.getEmail2()%></td>
				<% } %>

			</tr>
		</table>
	</div>
	<div>
		<button type="button" onclick="location.href='main.jsp'">홈으로</button>
	</div>

</body>
</html>