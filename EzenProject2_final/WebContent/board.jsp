<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@page import="com.project2.ezen.QnABean"%>
<%@page import="com.project2.ezen.QnADAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	int pageSize = 10; //한페이지에 출력할 레코드 수

	//클릭한 번호=현재 페이지
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}

	//현재 페이지 형변환
	int currentPage = Integer.parseInt(pageNum);

	//해당 페이지에서 시작할 레코드/마지막 레코드
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;

	int count = 0;
	QnADAO dao = new QnADAO();
	count = dao.getCount();

	List<QnABean> list = null;
	if (count > 0) {
		list = dao.getList(startRow, endRow);

	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>고객게시판</title>
<link href="css/sample1.css" rel="stylesheet" type="text/css">
<link href="css/board.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<%
		if (session.getAttribute("sessionID") != null) {
			out.println("<style>.isLogin{display:inline;}.isNotLogin{display:none;}</style>");
		} else {
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
			if (session.getAttribute("sessionID") != null) {
				out.println("<p class=\"isLogin\">" + session.getAttribute("sessionID") + "님 안녕하세요.</p>");
			}
		%>
	</div>

	</header>
	<div class="container">
		<nav class="navi" style="margin-bottom:50px;">
	<ul>
		<li><a href="main.jsp?category=r">RAM</a></li>

		<li><a href="main.jsp?category=h">HDD</a></li>

		<li><a href="main.jsp?category=s">SSD</a></li>

		<li><a href="main.jsp?category=v">그래픽카드</a></li>

		<li><a href="main.jsp?category=c">CPU</a></li>

		<li><a href="main.jsp?category=m">메인보드</a></li>

		<li><a href="./board.jsp">고객게시판</a></li>
	</ul>


	</nav>

		<section>
		<div class="board_list_wrap">
			<table class="board_list">
				<caption>게시판 목록</caption>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<%
						if (count > 0) {
							int number = count - (currentPage - 1) * pageSize;
							for (int i = 0; i < list.size(); i++) {
								QnABean dto = list.get(i);
					%>
					<tr>
						<td><%=number%>
							<%
								number--;
							%></td>
						<td><a
							href="readBoard.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>"><%=dto.getTitle()%></a></td>
						<td><%=dto.getName()%>(<%=dto.getId()%>)</td>
						<td><%=dto.getDate()%></td>
						<td><%=dto.getViewCount()%></td>
					</tr>
					<%
						}
						} else {
					%>
					<tr>
						<td colspan="5	" align="center">게시글이 없습니다.</td>
					</tr>
					<%
						}
					%>
					<tr>
			<td colspan="5" style="text-align:right;">
			<input class="bt" type="button" value="글작성"
			<% if(session.getAttribute("sessionID")!=null){
    			out.println("onclick=\"location.href='writeBoard.jsp'\"");
    		}else{
    			out.println("onclick=\"alert('로그인 해주세요.')\"");
    		}
			%>
			>
			</td>
		</tr>
			<tr>
			<td colspan="6" align="center">
				<%
					if(count>0){
						//총 페이지 수
						int pageCount = count/pageSize +(count%pageSize == 0? 0:1);
						//한 페이지에 보여줄 블록 수
						int pageBlock = 10;
						//한 페이지에 보여줄 시작 및 끝 번호
						int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
						int endPage = startPage + pageBlock -1;
						
						//마지막 페이지가 총 페이지 수보다 크면 endPage를 pageCount로 할당
						if(endPage > pageCount){
							endPage = pageCount;
						}
						
						if(startPage > pageBlock){
							%>
							<a class="bt" href="board.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
							<%
						}
						for(int i=startPage;i<=endPage;i++){
							if(i==currentPage){	//현재페이지는 링크 설정하지않음
								%>
								[<%=i %>]
								<%
							}else{
								%>
								<a href="board.jsp?pageNum=<%=i %>" class="num">[<%=i %>]</a>
								<%
							}
						}//end for
						
						if(endPage < pageCount){
							%>
							<a href="board.jsp?pageNum=<%=startPage+10 %>" class="bt">[다음]</a>
							
							<%
							
						}
					}
				%>
			</td>
		</tr>
				</tbody>
			</table>
			
		</div>
		</section>
		
		
		
		<sidebar class="sidebar">
             <img src="./images/img1.png" id=mainImage style="width:200px; height: 600px;">
            <script>
                var myImage=document.getElementById("mainImage");
                var imageArray=["images/img1.png", "images/img2.png", "images/img3.png"];
                var imageIndex=0;

                function changeImage() {
                    myImage.setAttribute("src", imageArray[imageIndex]);
                    imageIndex++;
                    if(imageIndex>=imageArray.length) {
                        imageIndex=0;
                    }
                }
                setInterval(changeImage,2000);
            </script>
        </sidebar>
	</div>
	<footer>
	<address>
		<div style="text-align: center;">
			<h3>
				<p>&copy이젠컴 / 회사소개/ 이용약관 / 전화번호 xxx-xxx-xxxx</p>
			</h3>
			<h3>
				<p>FAX:XXX-XXX_XXXX</p>
			</h3>
		</div>
	</address>

	</footer>
</body>
</html>