<%@page import="com.project2.ezen.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.project2.ezen.MemberBean"  %>
<%@ page import="com.project2.ezen.MemberDAO"  %>
<html>
<head>
<link rel="stylesheet" href="./css/sinof.css" />

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<title>배송 정보</title>
</head>
<body>
<%


String cartId=session.getId();//세션에 할당된 고유 아이디를 String으로 반환


%>
<header>
<%
            if(session.getAttribute("sessionID")!=null){
    			out.println("<p class=\"isLogin\">"+session.getAttribute("sessionID")+"님 안녕하세요.</p>");
    		}
            %>
</header>
<h1 class="display-3">배송 정보</h1>

	<div class="delivery_info">
					  
<div class="or_i_tit">
</div>
<form action="./sinfo_process.jsp" class="form-horizontal" method="post">
					<div class="dv_box dv_box01">
						<div class="dv_title">수령인</div>
						<div class="dv_input">
							<input type="text" name="uname"  class="input_formtext tr_inp_same" >
						</div>
					</div>
					<div class="dv_box dv_box02">
						<div class="dv_title">연락처</div>
						<div class="dv_input">
							<input type="text" name="phonenumber"  class="input_formtext tr_inp_same"  value="" maxlength="11"  onkeyup="this.value=this.value.replace(/[^0-9]/,'' );">
						</div>
					</div>
					<div class="dv_box dv_box03">
						<div class="dv_title">배송지</div>
						<div class="dv_input">
							<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" >
              <input type="button"  onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
              <input type="text" name="address" id="sample6_address" placeholder="주소">
               <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" >
               <input type="text" name="extraAddress"  id="sample6_extraAddress" placeholder="참고항목" >	
						</div>
					</div>
				
					</div>
				</div>
		
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
				<%@ include file="dbconn.jsp" %>
				   <%
				   request.setCharacterEncoding("utf-8");
					
					MemberDAO mdao = new MemberDAO();
					MemberBean mdto = new MemberBean();
					
					String id="";
					if(session.getAttribute("sessionID")!=null){
						id = session.getAttribute("sessionID").toString();
			
					}else{
						//아이디없으면 작성불가
					}
				   
					 
					 PreparedStatement pstmt=null;
			          ResultSet rs=null;
			          String sql="select * FROM ordertb WHERE order_id = (SELECT max(order_id) FROM ordertb)";
			           pstmt=conn.prepareStatement(sql); 
			           rs=pstmt.executeQuery();
			                                  
			           if(rs.next()){
			        	   int order_id =rs.getInt("order_id");
			        	        		                                      
			         %> 
				
				  <ul>
					
			<li>	<a  class="btn4" href="./cartview.jsp?cartId=<%=request.getParameter("cartId")%>"  role="button"> 이전 </a> </li>
				<li>	<button class="btn5" type="sumbit">전송</button></li>
				<li>	 <a class="btn4" onclick="location.href='orderConfirmation.jsp?order_id=<%=rs.getInt("order_id")%>'">구매하기</a> </li>
				
			
					</ul>
					
			
										
            <%}else{
            	  out.print("에러");
                   }
            	  %>
           

    <%
        	if(rs != null)rs.close();
            if(pstmt !=null)pstmt.close();
            if(conn !=null)conn.close();
        	%> 
             
					
					
					
 
				</div>
			</div>
		</form>
	</div>
</body>
</html>
