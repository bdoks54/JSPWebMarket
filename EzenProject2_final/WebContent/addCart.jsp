<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.project2.ezen.ProductDTO" %>
<%@ page import="com.project2.ezen.ProductDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
String id=request.getParameter("id");
if(id==null || id.trim().equals(" ")){
	response.sendRedirect("main.jsp");
	return;
}
ProductDAO dao = ProductDAO.getInstance();//전체 상품목록의 객체 주소를 얻어온다

ProductDTO product = dao.getProductById(id); //p1234 제품번호가들어있는객체(상품)의주소를얻어옴
if (product == null) {
	response.sendRedirect("exceptionNoProductId.jsp");
}

ArrayList<ProductDTO> goodsList = dao.getallproducts();
ProductDTO goods = new ProductDTO(); //빈 객체 생성, 구매하려는 상품 담으려고
for (int i = 0; i < goodsList.size(); i++) {
	goods = goodsList.get(i);
	if (goods.getProduct_id().equals(id)) { 			
		break;
	}
}

ArrayList<ProductDTO> list = (ArrayList<ProductDTO>) session.getAttribute("cartlist");//cartlist로 설정된 세션명으로 세션값을 가지고옴
//아래의 if문이 참인경우는 세션이 없는 경우
if (list == null) { 
	list = new ArrayList<ProductDTO>();
	session.setAttribute("cartlist", list);//세션을 생성한다
}

int cnt = 0; //장바구니에 담긴 상품의 갯수
ProductDTO goodsQnt = new ProductDTO();
for (int i = 0; i < list.size(); i++) {
	goodsQnt = list.get(i);
	if (goodsQnt.getProduct_id().equals(id)) {
		cnt++;
		int orderQuantity = goodsQnt.getQuantity() + 1;//장바구니에 담은 갯수 +1,각 상품에 대한 구매갯수
		goodsQnt.setQuantity(orderQuantity);//장바구니에 담은 갯수
	}
}

if (cnt == 0) { 
	goods.setQuantity(1);
	list.add(goods);
}

response.sendRedirect("ViewDetails.jsp?id=" + id); //장바구니에 담아놓은 상품의상세정보르이동시킴
%>



</body>
</html>