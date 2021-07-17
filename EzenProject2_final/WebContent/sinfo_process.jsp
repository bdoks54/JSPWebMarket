<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="com.project2.ezen.OrderDAO" %>
<%@ page import="com.project2.ezen.MemberBean" %>
<%@ page import="com.project2.ezen.MemberDAO" %>
<%@ page import="com.project2.ezen.OrderDTO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<%




	request.setCharacterEncoding("utf-8");
	OrderDAO odao = new  OrderDAO();
	OrderDTO odto=new OrderDTO();
	MemberDAO mdao = new MemberDAO();
	MemberBean mdto = new MemberBean();
	
	String id="";
	if(session.getAttribute("sessionID")!=null){
		id = session.getAttribute("sessionID").toString();
		mdto = mdao.selectById(id);
	}else{
		//아이디없으면 작성불가
	}
	String uname = request.getParameter("uname");
	String phonenumber = request.getParameter("phonenumber");
	String postcode = request.getParameter("postcode");
	String address = request.getParameter("address");
	String detailAddress = request.getParameter("detailAddress");
	String extraAddress = request.getParameter("extraAddress");
	
    odto.setFk_cust_id(id);
    odto.setOrder_name(uname);
    odto.setOrder_postcode(postcode);
    odto.setOrder_phone(phonenumber);
    odto.setOrder_address(address);
    odto.setOrder_detailaddress(detailAddress);
    odto.setOrder_extraaddress(extraAddress);
  
    
     	
    int cnt=odao.insert(odto);
	
    response.sendRedirect("sinof.jsp");
	

	
	%>
</body>
</html>