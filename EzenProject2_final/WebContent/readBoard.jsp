<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.project2.ezen.CommentBean"%>
<%@page import="com.project2.ezen.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.project2.ezen.QnABean"%>
<%@page import="com.project2.ezen.QnADAO"%>
<%@page import="com.project2.ezen.MemberDAO" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	//글내용 불러오기용
	String sessionId = (String) session.getAttribute("sessionID");
	if (sessionId == null) {
		sessionId = "";
	}
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	QnADAO dao = new QnADAO();
	QnABean dto = new QnABean();

	dao.addViewCount(num);

	dto = dao.selectByNum(num);

	
	MemberDAO mdao = new MemberDAO();
	
	//댓글 불러오기용	
	CommentDAO cdao = new CommentDAO();
	List<CommentBean> clist = new ArrayList<CommentBean>();
	
	//대댓글 불러오기용
	int cCount = cdao.getCount(num);
	if (cCount > 0) {
		clist = cdao.getListByBNum(dto.getNum());
	}
	List<CommentBean> cclist = new ArrayList<CommentBean>();
	
%>
<c:set var="sessionId"><%=sessionId %></c:set>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=dto.getTitle()%></title>
<link href="css/content.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
	function showCCForm(id){
		var form = document.getElementById("ccommentForm"+id);
		if(form.style.display=="none"){
			form.style.display = "table-row";
		}else{
			form.style.display = "none";
		}
		
		
	}
</script>
<body>
	<%request.setCharacterEncoding("UTF-8"); 
		
	%>
	<%
            if(session.getAttribute("sessionID")!=null){
    			out.println("<style>.isLogin{display:inline;}.isNotLogin{display:none;}</style>");
    		}else{
    			out.println("<style>.isLogin{display:none;}</style>");
    		}
            %>


	<header>
	<div style="text-align: left">
		<a href="./main.jsp"> <img src="images/head.png">
		</a>
		<form class="loginForm">
			<ul>
				<a href="logoutPro.jsp" class="isLogin">로그아웃</a>

				<a href="login.jsp" class="isNotLogin">로그인</a>

				<a href="makeId.jsp" class="isNotLogin">회원가입</a>

				<a href="장바구니">장바구니</a>
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
		<section>
		<table border="1" width="700" class="boardTable">
		<tr>
			<th width="100" class="category">제목</th>
			<td class="content"><%=dto.getTitle()%></td>
		</tr>
		<tr>
			<th width="100" class="category">작성자</th>
			<td class="content"><%=dto.getName()%>(<%=dto.getId()%>)</td>
		</tr>
		<tr>
			<th width="100" class="category">작성일</th>
			<td class="content"><%=dto.getDate()%></td>
		</tr>
		<tr>
			<th width="100" class="category">조회 수</th>
			<td class="content"><%=dto.getViewCount()%></td>
		</tr>
		<tr>
			<td class="content" colspan="2" height="300"><%=dto.getContent()%></td>
		</tr>
		<tr align="right">
			<td colspan="2"><input type="button" value="글목록"
				onclick="location.href='board.jsp?pageNum=<%=pageNum%>'"> <input
				type="button" value="수정"
				<%if (sessionId.equals(dto.getId())) {
				out.print("onclick=\"location.href='updateForm.jsp?num=");%><%=num%><%out.print("'\"");
				
				
			} else {
				out.print("onclick=\"alert('작성자만 수정할 수 있습니다.')\"");
			}%>>
				<input type="button" value="삭제"
				<%if (sessionId.equals(dto.getId())) {
				out.print("onclick=\"location.href='deletePro.jsp?num=");%><%=num%><%out.print("'\"");
				
				
			} else {
				out.print("onclick=\"alert('작성자만 삭제할 수 있습니다.')\"");
			}%>>
			</td>
		</tr>
	</table>
	<br>
	<br>
	
	<form action="commentPro.jsp" method="post">
	<table class="commentTable">

		<%if(cCount>0){
				for(int i=0;i<clist.size();i++){
				CommentBean cdto = clist.get(i);
				%>
				<c:set var="commentId"><%=cdto.getId() %></c:set>
		<tr>
			<th colspan="3" width="150px"><%=mdao.getNameById(cdto.getId()) %>(<%=cdto.getId() %>)</th>
			<td colspan="1" width="950px"><%=cdto.getContent() %></td>
			<td width="100px"><%=cdto.getDate() %></td>
			<td style="border:none;" width="100px">
				<c:if test="${sessionId ne '' }">
				<input type="button" value="답변" onclick="showCCForm(<%=cdto.getNum()%>)">
				<c:if test="${sessionId eq commentId}">
				<input type="button" value="삭제" onclick="location.href='delCommentPro.jsp?num=<%=cdto.getNum()%>&boardNum=<%=num%>&pageNum=<%=pageNum%>'">
				</c:if>
				</c:if>
			</td>
		</tr>
		
		<tr id="ccommentForm<%=cdto.getNum() %>" class="ccommentForm" style="display:none;">
			<td colspan="1" style="border:none;"></td>		
			<th colspan="2" style="background-color:skyblue; text-align:center border:2px solid black;"><%=sessionId %></th>
			<td colspan="1"><textarea rows="1" cols="40" name="comment_content"></textarea></td>
			<td style="border:none;"><input type="submit" value="등록"></td>
			<td style="border:none;"></td>	
			
		</tr>
		<input type="hidden" name="id" value="<%=sessionId%>"/>
		<input type="hidden" name="parent" value="<%=cdto.getNum()%>"/>
		<input type="hidden" name="boardNum" value="<%=num%>"/>
		<input type="hidden" name="pageNum" value="<%=pageNum%>"/>
		
		<%
				int ccCount= cdao.getCcCount(num);
				if(ccCount>0){
					cclist = cdao.getListByParent(cdto.getNum());
					for(int j=0;j<cclist.size();j++){
						CommentBean ccdto = cclist.get(j);
		%>
			<tr>
			<td colspan="1" style="border:none; text-align:right;" style="border:none;">ㄴ</td>
			<th colspan="2"><%=mdao.getNameById(ccdto.getId()) %>(<%=ccdto.getId() %>)</th>
			<td  style="border:1px solid black;"><%=ccdto.getContent() %></td>
			<td ><%=ccdto.getDate() %></td>
			<c:set var="cCommentId"><%=ccdto.getId() %></c:set>
			<td style="border:none;">
			<c:if test="${cCommentId eq sessionId }">
			<input type="button" onclick="location.href='delCommentPro.jsp?num=<%=ccdto.getNum()%>&boardNum=<%=num%>&pageNum=<%=pageNum%>'" value="삭제">
			</c:if>
			</td>
			</tr>
			<%
					}
					
				}
				
				}
			%>

			<%} %>
		</table>
		</form>
		
		<c:choose>
		<c:when test="${sessionId eq ''}"></c:when>
		<c:otherwise>
		<table class="commentForm">
		<form action="commentPro.jsp" name="commentForm" method="post">
		<tr>
			<td><%=mdao.getNameById(sessionId) %>(<%=sessionId %>)</td>
			<td><textarea name="comment_content" rows="4" cols="70" ></textarea></td>
			<td><input type="submit" value="댓글등록"></td>
		</tr>
		<input type="hidden" name="id" value="<%=sessionId%>">
		<input type="hidden" name="boardNum" value="<%=num%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		</form>
	</table>
	</c:otherwise>
	</c:choose>
        	
    </section>
	
	</div>
	
	<footer>
	<address>
		<div style="text-align: center;">
			<h3>
				<p>회사소개/ 이용약관 / 개인방침/ 전화번호 xxx-xxx-xxxx</p>
			</h3>
			<h3>
				<p>FAX:XXX-XXX_XXXX</p>
			</h3>
		</div>
	</address>

	</footer>
	</div>
</body>
</html>