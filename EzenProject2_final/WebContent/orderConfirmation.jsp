<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="com.project2.ezen.OrderDAO"  %>
<%@ page import="com.project2.ezen.OrderDTO"  %>
<%@ page import="com.project2.ezen.ProductDTO"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.project2.ezen.MemberBean" %>
<%@ page import="com.project2.ezen.MemberDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" href="./css/order.css" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>주문 정보</title>
</head>
<body>
<%

request.setCharacterEncoding("utf-8");
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

 

%> 
  <div class="jumbotron">
    <div class="container">
      
    </div>
   </div>
   <div class="container" col-8 alert alert-info">
     <div class="text-center">
       <h1 align="center"> 영수증</h1>
     </div>
     <%
   int order_id= Integer.parseInt(request.getParameter("order_id"));


    dto = dao.read(order_id);
   
     if(dto == null){
    	 out.print("글없음");
     }else{
     %>
     
     <div class="row">
       <div class="col-4" align="center">
         <strong> 배송주소 </strong> <br> 
              <p>    이름 : <%=dto.getOrder_name() %> </p>
                <p>  우편번호 : <%=dto.getOrder_postcode() %></p> 
               <p>   주소 : <%=dto.getOrder_address() %> <%=dto.getOrder_extraaddress() %> <%=dto.getOrder_detailaddress() %> </p> 
                 
                      
       </div>
       <div class="col-4" align="center">
         <p> <em>주문일 : <%=dto.getOrder_date()%></em>
       </div>
     </div>
     <%} %>
     <div>
       <table class="table1">
         <tr>
            <th class="text-center"> 상품이미지 </th>
            <th class="text-center"> 상품명 </th>
            <th class="text-center"> 가격 </th>
            <th class="text-center"> 수량 </th>
            <th class="text-center"> 합계</th>
         </tr>
         <%
          int sum=0;
          ArrayList<ProductDTO> cartList = (ArrayList<ProductDTO>) session.getAttribute("cartlist");
          if(cartList==null)
        	  cartList = new ArrayList<ProductDTO>();
          for(int i=0;i<cartList.size();i++){//상품 리스트 하나씩 출력하기
        	  ProductDTO product = cartList.get(i);
              int total = product.getProduct_price() * product.getQuantity();
              sum = sum + total;
         
        %>
          <tr>
             <td><img src="./<%=product.getProduct_url()%>" style="width: 80px"height="80px"> </td>
             <td style="font-size: 10pt;"> <%=product.getProduct_name()%> </td>
             <td ><fmt:formatNumber value="<%=product.getProduct_price()%>" type="number"
                       groupingUsed="true" />원</td>
             <td ><%=product.getQuantity() %></td>
             <td ><fmt:formatNumber value="<%=total%>" type="number"
                       groupingUsed="true" />원</td>
             
                               
                 </tr>
                 <%} %>
                      
         <tr>
           <td></td>
           <td></td>
           <td class="text-right"><strong>총액:</strong>
           <td class="text-center text-dnager"><strong><fmt:formatNumber value="<%=sum%>" type="number"
                       groupingUsed="true" />원</strong></td>
            <td></td>            
         </tr>
   
      </table>
      <%
     if(dto == null){
    	 out.print("글없음");
     }else{
     %>
        <ul>
     <li>  <a  href="./sinof.jsp?cartId=<%=dto.getOrder_id() %>"
          class="btn6" role="button">이전</a></li>
         
     <li>  <a href="./thankCustomer.jsp?order_id=<%=dto.getOrder_id() %>" class="btn6" role="button">주문완료</a> </li>
        <%} %>
     <li>  <a href="./checkOutCancelled.jsp" class="btn6" role="button">취소</a> </li>
       </ul> 
     </div>
   </div>
</body>
</html>