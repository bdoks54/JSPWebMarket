<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>제품상세보기</title>
<script type="text/javascript">
function addToCart(){
	var id = '<%=(String)session.getAttribute("sessionID")%>';
	if(id == "null"){
		 alert('로그인 해주세요.')		
	}else if(confirm("상품을 장바구니에 추가하시겠습니까?")){
		  document.addForm.submit();
	 
	  }else{
		 
		  document.addForm.reset();
	  }
	
}

</script>
<link href="css/viewdetails.css" rel="stylesheet" type="text/css">
<style>
 
     </style>
</head>
<body>

<%			
			String sessionId = (String) session.getAttribute("sessionID");
            if(session.getAttribute("sessionID")!=null){
    			out.println("<style>.isLogin{display:inline;}.isNotLogin{display:none;}</style>");
    		}else{
    			sessionId="";
    			out.println("<style>.isLogin{display:none;}</style>");
    		}
            %>
 <header>
                <div style="text-align : left" >
                    <a href="main.jsp"> 
                <img src="image/head.png" >
                </a>
                
                <form class="loginForm"> 
                    <ul>
                 <a href="logoutPro.jsp" class="isLogin">로그아웃</a>

				<a href="login.jsp" class="isNotLogin">로그인</a>

				<a href="makeId.jsp" class="isNotLogin">회원가입</a>

				<a href="cartview.jsp" class="isLogin">장바구니</a>
               </ul>     
               </form>
                <%
            if(session.getAttribute("sessionID")!=null){
    			out.println("<p class=\"isLogin\">"+session.getAttribute("sessionID")+"님 안녕하세요.</p>");
    		}
            %>
           </div>
                             
                  </header>
           <div class="container">
       
         <%@ include file="dbconn.jsp" %>
        
		 <%
		 String id=request.getParameter("id");
		 PreparedStatement pstmt=null;
          ResultSet rs=null;
          String sql="select  *from product where product_id=? ";
           pstmt=conn.prepareStatement(sql); 
           pstmt.setString(1, id);
           rs=pstmt.executeQuery();
                                  
           while(rs.next()){
        	   String productid =rs.getString("product_id");
        
        	           				                                      
         %> 
             <artice class="J1">
                 <img src="./<%=rs.getString("product_url") %> " width="360px" height="400px">
             </artice>
             <artice class="J2">
<h2 >
<%=rs.getString("product_name") %>
</h2>
<P>
<small><%=rs.getString("product_desc") %></small>
</P>
<hr>
<p >
 가격: <fmt:formatNumber value="<%=rs.getInt(\"product_price\") %>" type="number"
                       groupingUsed="true" />원</p> 

</p>
<p>
 상품번호: <%=rs.getString("product_id") %>          
</p>
<p>
           
</p>
<p>
배송정보: 입금확인 후 평균 1~2일 소요    
</p>
<p>
배송비: <fmt:formatNumber value="2500" type="number" groupingUsed="true" />원</p> 
</p>

    <form name="addForm" action="./addCart.jsp?id=<%=rs.getString("product_id")%>"
			 method="post">
			
	<a href="#" class="btn " onclick="addToCart()"> 물건 담기  </a>
               		     
    
    <a  class="btn " <% if(session.getAttribute("sessionID")!=null){
    			out.println("onclick=\"location.href='cartview.jsp'\"");
    		}else{
    			out.println("onclick=\"alert('로그인 해주세요.')\"");
    		}%>>장바구니</a> 
    	
     <a href="sinof.jsp" class="btn ">구매하기</a>
     	</form>
             </artice>
          <artice class="J3">
             <div class="view__quick" data-type="">
                <div class="quick__wrapper">
                    <div class="quick__content">
                        <div class="quick__static">상세설명</div>
                        <nav class="b">
                        <ul class="quick__list">
                            <li><a class="active" href="#detail">상세설명</a></li>
                           <li><a href="#info">배송정보</a></li>
                           <li><a href="#as">A/S,교환,반품 안내</a></li>
                        </ul>
                        </nav>
                    </div>
                </div>
            </div>
        
   
                           
			<img id="detail" src="./<%=rs.getString("product_durl") %>" />
	
			<!-- 평점 -->
			<div id="score">
				<%
					String scoreAvg = "";
					ResultSet rs2 = null;
					ResultSet rs3 = null;
                	String sql2 = "select ROUND(AVG(score_score),2) as avg from score where score_prodid=?";
                    pstmt = conn.prepareStatement(sql2);
                    pstmt.setString(1, id);
                    rs2 = pstmt.executeQuery();
                    while (rs2.next()) {
                        scoreAvg = rs2.getString("avg");
                    }
                    if(scoreAvg == null){
                        scoreAvg = "없음";
                    }

                    String sql3 = "select * from score where score_prodid=?";
                    pstmt = conn.prepareStatement(sql3);
                    pstmt.setString(1, id);
                    rs3 = pstmt.executeQuery();
            %>
            <div>
            	<caption style="visibility: hidden;"></caption>
            	<p class="avgScore">평점 : <%=scoreAvg %>
            	<table class="scoreTable">
            		<tr>
            			<th id="writer">글쓴이</th>
            			<th id="score">점수</th>
            			<th id="review">리뷰</th>
            		</tr>
            		<%while(rs3.next()){
            			%>
            			<tr>
                        	<td><%=rs3.getString("score_custid")%></td>
                        	<td><%=rs3.getString("score_score")%></td>
                        	<td><%=rs3.getString("score_review")%></td>
                   		</tr>
            		<% }%>
            		<tr>
            			<td colspan="3" style="text-align:right;">
            				<c:set var="sessionId"><%=sessionId %></c:set>
            				<c:if test="${sessionId ne ''}">
            				<input type="button" value="리뷰하기" onclick="location.href='review.jsp?prodid=<%=rs.getString("product_id") %>'"
            				style="margin-right:10px;">
            				</c:if>
            			</td>
            		</tr>
            	</table>
            </div>
			</div>


                                                                                        
            <div class="content__item item--delivery">
                        <p  id="info" class="content__title"><strong>배송안내</strong></p>
                        <div class="delivery__content scroll__wrapper iscroll-hor-visible">
                            <div class="scroll__content">
                                <table class="assaTableField align--left">
                                    <colgroup>
                                        <col style="width: 20%;">
                                        <col style="width: 80%;">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th>입금완료 시간안내</th>
                                            <td>
                                                <p class="el--mb_10">- <span class="font_c--red">완제품 본체를 제외한</span> 부품 및 주변기기는 <span class="font_w--bold">당일 오후 15시 이전까지 결제완료</span>시 당일발송 해드립니다.</p>
                                                <p>- 입금 확인후 평균 3일 이내로 배송됩니다.</p>
                                                <p>- 도서/산간지역은 2~3일 정도 추가 됩니다.</p>
                                                <p>- 연휴(공휴)기간의 경우, 배송기간은 1일정도 연기되어질 수 있습니다.</p>
                                                <p>- 특정 사유로 지연될 경우, 별도의 연락을 드리도록 하겠습니다.</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>배송지역</th>
                                            <td>
                                                <p>- 전국(일부지역제외)</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>배송비</th>
                                            <td>
                                                <p>- 배송비 1박스당 지정비용(도서산간지역 추가비용이 발생되어질 수 있습니다.)</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>배송 택배사</th>
                                            <td>
                                                <p>
                                                    - <span class="font_w--bold">한진택배</span>사로 이루어집니다.
                                                    [한진택배: 1588-0011]
                                                    <a href="http://hanex.hanjin.co.kr/" class="assaBtn c--default s--xsm" target="_blank">바로가기</a>
                                                </p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
   <div class="content__item item--asinfo">
                        <p id="as" class="content__title"><strong>A/S,교환,반품 안내</strong></p>
                        <div class="asinfo__content scroll__wrapper iscroll-hor-visible">
                            <div class="scroll__content">
                                <table class="assaTableField align--left">
                                    <colgroup>
                                        <col style="width: 20%;">
                                        <col style="width: 80%;">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th>A/S정책</th>
                                            <td>
                                                <p class="el--mb_10">* 초기불량을 포함한 AS처리는 택배로만 가능합니다.</p>
                                                <p class="font_c--black font_w--medium">[A/S 시 운송료는 아래와 같습니다.]</p>
                                                <p>- 제품구입 후 7일 이내 제품불량 발생시 교환이나 환불에 필요한 운송료 자사에서 부담</p>
                                                <p>- 제품구입 후 10일 이상 30일 이내에 제품불량 발생시 교환에 필요한 운송료는 반액(편도) 자사에서 부담</p>
                                                <p>- 제품구입 후 30일 이후 발생하는 제품불량의 경우 운송료 전액을 고객이 부담해야 합니다.</p>
                                                <p class="el--mb_10">- 소비자 변심에 의해 반품하는 경우 운송비는 전액 고객이 부담해야 합니다.</p>
                                                <p>※ 위에 언급된 운송료는 한진택배를 이용하는 경우에만 해당합니다. (다른 운송방법을 이용하는 경우 운송료는 소비자가 부담해야 합니다.)</p>
                                                <p></p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th rowspan="3">교환,반품 안내</th>
                                            <td>
                                                <p class="font_c--black font_w--medium">* 해당 정책은 주변기기 및 부품 별도구매시 해당하며, 완제품본체를 제외한, 교환,반품 안내입니다.</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <p class="font_c--active font_w--medium el--mb_10">교환 및 반품이 가능한 경우</p>
                                                <p class="el--mb_10">7일이내에 교환 및 반품이 가능합니다. 다만 이경우 배송비는 고객님께서 부담하시게 됩니다.</p>
                                                <p>* 단 아래의 경우는 제외 합니다</p>
                                                <p>1) 소비자의 책임 있는 사유로 상품 등이 멸실/훼손된 경우 (상품 확인을 위한 포장 훼손 제외)</p>
                                                <p>2) 소비자의 사용/소비에 의해 상품 등의 가치가 현저히 감소한 경우</p>
                                                <p>3) 시간의 경과에 의해 재판매가 곤란할 정도로 상품 등의 가치가 현저히 감소한 경우</p>
                                                <p>4) 복제가 가능한 상품 등의 포장을 훼손한 경우</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <p class="font_c--active font_w--medium el--mb_10">교환 및 반품이 불가능한 경우</p>
                                                <p>1. 소프트웨어 상품일 경우, 제품의 개봉후엔 교환/환불이 절대 불가합니다.</p>
                                                <p>2. 포장의 개봉/포장 훼손 및 상품가치가 상실된 경우에는 교환/반품이 불가능합니다.</p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
   </artice>

    
            <%} %>

    <%
        	if(rs != null)rs.close();
            if(pstmt !=null)pstmt.close();
            if(conn !=null)conn.close();
        	%> 
             
                 
   
       
        
        <footer>
            <address>
                <div style="text-align : center;">
                   <h3> <p> &copy이젠컴 / 회사소개 / 이용약관 / 주소 경기도 양주시 XXX XXX</p></h3>
              <h3><p> 전화번호 / 팩스주소</p></h3>
           </div>
            </address>

        </footer>
    </div>
    
</body>
</html>