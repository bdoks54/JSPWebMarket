<%@page import="java.util.Arrays"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"%>
<%@ page import="com.project2.ezen.ProductDTO" %>
<%@ page import="com.project2.ezen.ProductDAO" %>
<%@page import="com.project2.ezen.MemberBean"%>
<%@page import="com.project2.ezen.MemberDAO"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
    String cartId=session.getId();//세션에 할당된 고유 아이디를 String으로 반환
 %>
 <%
            if(session.getAttribute("sessionID")!=null){
    			out.println("<style>.isLogin{display:inline;}.isNotLogin{display:none;}</style>");
    		}else{
    			out.println("<style>.isLogin{display:none;}</style>");
    		}
            %>
            
<head>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>장바구니</title>
<link href="css/cart.css" rel="stylesheet" type="text/css">


</head>


<body>

<header>
                
                           
                <%
            if(session.getAttribute("sessionID")!=null){
    			out.println("<p class=\"isLogin\">"+session.getAttribute("sessionID")+"님 안녕하세요.</p>");
    		}
            %>
           
                             
                  </header>

  <h1 style="text-align: center;">장바구니</h1>
  <hr> 
  

        <div style="padding-top:5px">
      
         <table class="table1">
   
              <tr>
                 <th>이미지</th>
                 <th>상품명</th>
                 <th>가격</th>
                 <th>수량</th>
                 <th>합계</th>
                 <th>삭제</th>
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
              <td ><a href="./removecart.jsp?id=<%=product.getProduct_id()%>"
                    class="btn3 ">삭제</a></td>
               
                               
                 </tr>
                 <%} %>
                      
                  
        	 <tr>
              <th></th>
              <th></th>
              <th>총액</th>
              <th><fmt:formatNumber value="<%=sum%>" type="number"
                       groupingUsed="true" />원</th>
              <th></th>
              <th></th>
              
          </tr>
        	
        
        </table>
       
     
         
                  
   <table width="100%">
      <tr>
        <td style="position: relative; left: 300px; padding-top:10px; " ><a href="./deletecart.jsp?cartId=<%=cartId%>" 
               class="btn2 ">장바구니 비우기</td>
        <td style="position: relative; left: 340px; padding-top:10px; "><a class="btn2" href="./main.jsp" class="btn">쇼핑계속하기</a> </td>
        <td style="position: relative; left: 90px; padding-top:10px;"><a class="btn2" href="./sinof.jsp" >주문하기</a></td>
        </tr>
       </table>
   
   
   
   
   
   
   
   </table>
          
     
     
     
     
     






</body>
</html>