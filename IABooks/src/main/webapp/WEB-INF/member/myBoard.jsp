<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<title>in사과::myBoard </title>

<jsp:include page="/WEB-INF/header.jsp"/>

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_category_search.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/jeong_css/semi_style.css" />

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


<style type="text/css">

	#my_tbody > tr > td:nth-child(2), td:nth-child(4) {
		text-align: center;
	}
	
	#mySearchContent, #mysearchCate {
			font-size:14px;
	}
	
	a {
	  	color: #333333;
	  	text-decoration: none;
	}
	a:hover {
  		color: #333333;
 	}
 	
 	a.page-num{
 		padding: 10px 12px 6px 12px;
 	}

</style>



<script type="text/javascript">
	
	$(document).ready(function(){
		
		// **** select 태그에 대한 이벤트는 click 이 아니라 change 이다(중요 암기) ****//
		$("select#mysearchCate").bind("change", function(){
			
			const frm = document.myBoardFrm;
			frm.action = "myBoard.book";
			frm.method = "get";
			frm.submit();
			
		});
		
		if( "${requestScope.mysearchCate}" != "" ) {
			$("select#mysearchCate").val("${requestScope.mysearchCate}");
		}
		
		
		$("button#btn_mySearch").click(function(){
			// console.log(이 form 이 submit 될 때 함수 실행하겠다.);	
			
			if($("select.mySearchType").val() == "" ) {
				alert("검색대상을 올바르게 선택하세요!! ");
				return false; // submit을 하지 않고 종료
			}
			
			if($("input#mySearchWord").val().trim() == "") {
				alert("검색어는 공백만으로 되지 않습니다. 검색어를 올바르게 입력하세요!!");
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
		
		
	}); // end of $(document).ready(function(){})----------------

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
<%-- 			    <div class="title" >
				  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_heading.gif" /></div>
				  	<h2>내가 쓴 글</h2>
				  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/bar_eee.gif" /></div>
				  	<span >내가 작성했던 글들을 볼 수 있습니다.</span>
			    
			   </div> --%>
		<div class="title">
		<br>
		<h2 >내가 쓴 글&nbsp;</h2><span >&nbsp;내가 작성했던 글들을 볼 수 있습니다.</span>
		</div>
			  <p class="mb-3"></p>
			
				<select class="cateDropdown" id="mysearchCate" name="mysearchCate" onchange="">
				    <option value="">분류</option>
				    <option value="all">전체</option>
				    <option value="review">후기</option>
				    <option value="qna">문의</option>
	            </select>
			
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
			  	<c:set var="rnum" value="${requestScope.rvo.totalCnt - ( (requestScope.rvo.currentShowPageNo-1) *10 ) }" />
			  	<c:set var="qnum" value="${requestScope.qvo.totalCnt - ( (requestScope.qvo.currentShowPageNo-1) *10 ) }" />
			    <c:if test="${not empty requestScope.myBoardList}">
			    <c:forEach var="board" items="${requestScope.myBoardList}" >
			    	<c:if test="${not empty board.revBoard.pk_rnum }">
			    	<c:if test="${board.revBoard.pk_rnum ne 0}">
				    <tr>
				      	<td>
							R-${rnum}
							<input type="hidden" value="${board.revBoard.pk_rnum}" name="pk_rnum" id="pk_rnum" />
						</td>
				      	<td id="cate_"><a href="<%= ctxPath%>/board/reviewBoard.book">타인의 책장</a></td>
				      	<td><a href="<%= ctxPath%>/board/reviewDetail.book?pk_rnum=${board.revBoard.pk_rnum}">${board.revBoard.re_title}</a></td>
				      	<td>${board.revBoard.re_date}</td>
				    </tr>
				    <c:set var="rnum" value="${rnum-1 }"></c:set>
				    </c:if>
			    	</c:if>
			    	<c:if test="${not empty board.qnaBoard.pk_qna_num}">
			    	<c:if test="${board.qnaBoard.pk_qna_num ne 0}">
				    <tr>
				      	<td>
				      		Q-${qnum}
				      		<input type="hidden" value="${board.qnaBoard.pk_qna_num}" name="pk_qna_num" id="pk_qna_num" />
				      	</td>
				      	<td id="cate_qna"><a href="<%= ctxPath%>/board/qnaBoard.book">상품문의</a></td>
				      	<td><a href="<%= ctxPath%>/board/qnaDetail.book?pk_qna_num=${board.qnaBoard.pk_qna_num}">${board.qnaBoard.qna_title}</a></td>
				      	<td>${board.qnaBoard.qna_date}</td>
				    </tr>
				    <c:set var="qnum" value="${qnum-1 }"></c:set>
				    </c:if>
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
			
		  	<%--페이지 네비게이션 --%>
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center ">
					${requestScope.pageBar}
			  	</ul>
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
			    <button class="btn btn_myboard_search" name="btn_mySearch" id="btn_mySearch" onclick="goMyBoardSearch();">찾기</button>
			    </div>
		    
		  	</div>
		  	
		  	
		</form>	
		</div> <!-- container 끝 -->
		
		
<jsp:include page="/WEB-INF/footer.jsp"/>
