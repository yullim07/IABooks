<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%
	String ctxPath = request.getContextPath();
	
%>


<jsp:include page="/WEB-INF/header.jsp"/>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/jeong_css/semi_style.css" />

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


<style type="text/css">

#my_tbody > tr > td:nth-child(2), td:nth-child(4) {
	text-align: center;
}

 #mySearchContent {
		font-size:14px;
}

</style>



<script type="text/javascript">
	
	$(document).ready(function(){
		
		/*
		
		if( "${sessionScope.loginuser.userid}" == "admin" ) {
			$("button#btn_write").show();
		}
		else {
			$("button#btn_write").hide();
		}
		 
		*** select 태그에 대한 이벤트는 click 이 아니라 change 이다(중요 암기) ***
		*/
		
		
		$("button#btn_mySearch").click(function(){
			// console.log(이 form 이 submit 될 때 함수 실행하겠다.);	
			
			if($("select.mySearchType").val() == "" ) {
				alert("검색대상을 올바르게 선택하세요!! ");
				return false; // submit을 하지 않고 종료
			}
			
			if($("input#mySearchWord").val().trim() == "") {
				alert("검색어는 공백만으로 되지 않습니다. 검색어를 올바르게 입력하세요!! qwe2");
				return false;
			}
			
			$("input#mySearchWord").bind("keyup", function(){
				
				if(event.keyCode == 13) {
					// 검색어에서 엔터를 치면 검색하러 간다.
					goMyBoardSearch();
				}
				
			});
			
		}); // end of $("button#btn_search").click(function(){})----------------
		
		// 검색조건을 넣은 후, action단에서 페이지바를 보여주고 다른 페이징 처리를 할 때 검색조건을 넣어준다
		// alert("~~ 확인용 : ${requestScope.searchType} ");
		// "~~ 확인용 : "
		// 회원명 조건하고 했더니 "~~ 확인용 : name" 뜸
		if( "${requestScope.mySearchType}" != "" ) { // 반드시 if에 넣을때 쌍따옴표 꼭 붙여라!!(자바스크립트임)
			$("select#mySearchType").val("${requestScope.mySearchType}");
			$("input#mySearchWord").val("${requestScope.mySearchWord}");
		}
		
		
	});

	// Function Declaration
	function goMyBoardSearch(){
	
		if($("select.mySearchType").val() == "" ) {
			alert("검색대상을 올바르게 선택하세요!!");
			return; // goMyBoardSearch() 함수 종료.
		}
		
		if($("input#mySearchWord").val().trim() == "") {
			alert("검색어는 공백만으로 되지 않습니다. 검색어를 올바르게 입력하세요!!");
			return;
		}
		
		const frm = document.myBoardFrm;
		frm.action = "myBoard.book";
		frm.method = "get";
		frm.submit();
		
	 }
	
</script>



</head>
<body>


	    <div class="container">
	    <form name="myBoardFrm" method="get">
			    <div class="title" >
				  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_heading.gif" /></div>
				  	<h2>내가 쓴 글</h2>
				  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/bar_eee.gif" /></div>
				  	<span >내가 작성했던 글들을 볼 수 있습니다.</span>
			    
			   </div>
			  <p class="mb-3"></p>
			
			  <table class="table" id="faq_table_all">
			  <thead class="thead-light" id="faq_thead">
			    <tr style="text-align: center;">
			      	<th width="10%">번호</th>
			        <th width="10%">카테고리</th>
			        <th width="60%">제목</th>
			        <th width="20%">작성일</th>
			    </tr>
			  </thead>
			  <tbody id="my_tbody">
			  	<c:if test="${not empty requestScope.myBoardList}">
			    <c:forEach var="board" items="${requestScope.myBoardList}" >
			    	<c:if test="${board.revBoard.pk_rnum ne 0 }">
				    <tr>
				      	<td>${board.revBoard.pk_rnum}</td>
				      	<td><a href="<%= ctxPath%>/board/reviewBoard.book">타인의 책장</a></td>
				      	<td><a href="<%= ctxPath%>/board/reviewDetail.book?pk_rnum=${board.revBoard.pk_rnum}">${board.revBoard.re_title}</a></td>
				      	<td>${board.revBoard.re_date}</td>
				    </tr>
				    </c:if>
			    
			    	<c:if test="${board.qnaBoard.pk_qna_num ne 0 }">
				    <tr>
				      	<td>${board.qnaBoard.pk_qna_num}</td>
				      	<td><a href="<%= ctxPath%>/board/qnaBoard.book">상품 Q&A</a></td>
				      	<td><a href="<%= ctxPath%>/board/qnaDetail.book?pk_qna_num=${board.qnaBoard.pk_qna_num}">${board.qnaBoard.qna_title}</a></td>
				      	<td>${board.qnaBoard.qna_date}</td>
				    </tr>
				    </c:if>
			    </c:forEach> 
			    </c:if> 
			     <c:if test="${empty requestScope.myBoardList}">
			     <tr id="notExist">
			      	<td colspan="6">
			      		<div>
			      		<span style="color: #555555; font-weight:bold;">게시물이 없습니다.</span>
			      		</div>
			      	</td>
			     </tr>
			     </c:if>
			  </tbody>
			</table>
			
			<nav class="my-5">
				<div style="display: flex; width: 100%;">
					<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
				</div>	
			</nav>
			
			<div class="search_outer" id="tab_center">
		 		<div class="search_inner">
			    <select id="mySearchContent" name="mySearchType">
			    	<option value="">분류</option>
			    	<option value="all">전체</option>
			    	<option value="my_title">제목</option>
			        <option value="my_contents">내용</option>
			    </select>
			    <input type="text" name="mySearchWord" id="mySearchWord"></input>
			    <button class="btn btn_myboard_search" name="btn_mySearch" id="btn_mySearch" onlick="goMyBoardSearch();">찾기</button>
			    <button class="btn btn_myboard_reset" name="btn_myReset" id="btn_myReset" onlick="location.href='<%= ctxPath%>/member/myBoard.book'">목록</button>
			    </div>
		    
		  	</div>
		</form>	
		</div> <!-- container 끝 -->
		
		
<jsp:include page="/WEB-INF/footer.jsp"/>
