<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="com.project2.ezen.OrderDAO"  %>
<%@ page import="com.project2.ezen.OrderDTO"  %>
<%@ page import="com.project2.ezen.MemberBean" %>
<%@ page import="com.project2.ezen.MemberDAO" %>
<html>
<head>
<link rel="stylesheet" href="./css/order.css" />
<title>주문 완료</title>
</head>
<body>
  <%
  OrderDAO dao=new OrderDAO();
  OrderDTO dto=new OrderDTO();
  MemberDAO Mdao = new MemberDAO();
  MemberBean mdto = new MemberBean();
  String id="";
  if(session.getAttribute("sessionID")!=null){
		id = session.getAttribute("sessionID").toString();		
	}else{
		//아이디없으면 작성불가
	}
  
  
  int order_id= Integer.parseInt(request.getParameter("order_id"));


   dto = dao.read(order_id);
  
    if(dto == null){
   	 out.print("글없음");
    }else{
    %>
  
 
  <div class="jumbotron">
    <div class="container">
      <h1 class="display-3">주문 완료</h1>
    </div>
  </div>
  <div class="container">
    <h2 class="alert alert-danger">주문해 주셔서 감사합니다. </h2>
    <p> 주문은 <%=dto.getOrder_date()%>에 배송출발할 예정입니다.!</p>
    <p> 주문번호 : <%=dto.getOrder_id()%></p>
     <%} %>
     <%  session.removeAttribute("cartlist"); %>
  </div>

  <div class="container">
  <p> <a href="./main.jsp" class="btn6"> 상품목록 </a>
  </div>
  
</body>
</html>



