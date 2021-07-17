<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="com.project2.ezen.ProductDAO"%>
<%@page import="java.util.ArrayList" %>
<%@page import="com.project2.ezen.ProductDTO" %>

<html>
<head>
<title>장바구니 상품 개별삭제</title>
</head>
<body>
  <%
     String id=request.getParameter("id");
     if(id==null || id.trim().equals("")){
    	 response.sendRedirect("ViewDetails.jsp");
    	 return;
     }
     ProductDAO  dao = ProductDAO.getInstance();
     
     ProductDTO product = dao.getProductById(id);
     if(product==null){
    	response.sendRedirect("exceptionNoProductId.jsp");
     }
     ArrayList<ProductDTO> cartList = (ArrayList<ProductDTO>) session.getAttribute("cartlist");
     ProductDTO goodsQnt = new ProductDTO();
     for(int i=0;i<cartList.size();i++){
    	 goodsQnt = cartList.get(i);
    	 if(goodsQnt.getProduct_id().equals(id)){
    		 cartList.remove(goodsQnt);
    	 }
     }
     response.sendRedirect("cartview.jsp");
    		 
  %>
</body>
</html>