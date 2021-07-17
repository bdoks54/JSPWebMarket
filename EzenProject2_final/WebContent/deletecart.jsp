<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="com.project2.ezen.ProductDTO" %>
<%@ page import="com.project2.ezen.ProductDAO" %>
<html>
<head>
<title>장바구니비우기 </title>
</head>
<body>
  <%
    String id=request.getParameter("cartId");
    if(id==null || id.trim().equals("")){
    	response.sendRedirect("cartview.jsp");
    	return;
    }
     session.removeAttribute("cartlist");//현재 세션에 저장된 모든 세션 속성을 제거합니다.
     response.sendRedirect("cartview.jsp");
  %>
</body>
</html>