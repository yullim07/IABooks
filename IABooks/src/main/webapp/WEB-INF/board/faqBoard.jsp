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
	#faq_table_all > tbody > tr > td:nth-child(2), td:nth-child(4) {
		text-align: center;
	}
	
	select#searchContent, select#searchCate {
		font-size:14px;
	}
	
</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		if( "${sessionScope.loginuser.userid}" == "admin" ) {
			$("button#btn_write").show();
		}
		else {
			$("button#btn_write").hide();
		}
		
		// **** select 태그에 대한 이벤트는 click 이 아니라 change 이다(중요 암기) ****//
		$("select#searchCate").bind("change", function(){
			
			const frm = document.faqBoardFrm;
			frm.action = "faqBoard.book";
			frm.method = "get";
			frm.submit();
			
		});
		
		if( "${requestScope.searchCate}" != "" ) {
			$("select#searchCate").val("${requestScope.searchCate}");
		}
		
		$("button#btn_search").click(function(){
			// console.log(이 form 이 submit 될 때 함수 실행하겠다.);	
			
			if($("select.searchType").val() == "" ) {
				alert("검색대상을 올바르게 선택하세요!!");
				return false; // submit을 하지 않고 종료
			}
			
			if($("input#searchWord").val().trim() == "") {
				alert("검색어는 공백만으로 되지 않습니다. 검색어를 올바르게 입력하세요!!");
				return false;
			}
			
			$("input#searchWord").bind("keyup", function(){
				
				if(event.keyCode == 13) {
					// 검색어에서 엔터를 치면 검색하러 간다.
					goSearch();
				}
				
			});
			
		}); // end of $("button#btn_search").click(function(){})----------------
		
		// 검색조건을 넣은 후, action단에서 페이지바를 보여주고 다른 페이징 처리를 할 때 검색조건을 넣어준다
		// alert("~~ 확인용 : ${requestScope.searchType} ");
		// "~~ 확인용 : "
		// 회원명 조건하고 했더니 "~~ 확인용 : name" 뜸
		if( "${requestScope.searchType}" != "" ) { // 반드시 if에 넣을때 쌍따옴표 꼭 붙여라!!(자바스크립트임)
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		}
		
	}); // end of $(document).ready(function(){})---------------------
	
	
	// Function Declaration
	function goSearch(){
		
		if($("select.searchType").val() == "" ) {
			alert("검색대상을 올바르게 선택하세요!!");
			return; // goSearch() 함수 종료.
		}
		
		if($("input#searchWord").val().trim() == "") {
			alert("검색어는 공백만으로 되지 않습니다. 검색어를 올바르게 입력하세요!!");
			return;
		}
		
		const frm = document.faqBoardFrm;
		frm.action = "faqBoard.book";
		frm.method = "get";
		frm.submit();
		
	}
	
	
</script>

	    <div class="container">
	    <form name="faqBoardFrm" method="get">
			    <div class="title" >
				  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_heading.gif" /></div>
				  	<h2>FAQ</h2>
				  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/bar_eee.gif" /></div>
				  	<span >이용안내 FAQ입니다.</span>
			    
			   </div>
			  <!-- <p class="mb-3"></p> -->
			
			  	
			    <select id="searchCate" class="cateDropdown" name="searchCate">
			       <option value="">분류</option>
	               <option value="all">전체</option>
	               <option value="member">회원</option>
	               <option value="product">상품</option>
	               <option value="return">반품/교환</option>
	               <option value="order">주문/배송</option>
	               <option value="promotion">제휴</option>
			    </select>
		    
			
			<hr>
			  <table class="table" id="faq_table_all">
			  <thead class="thead-light" id="faq_thead">
			    <tr style="text-align: center;">
			      <th style="width:10%;">번호</th>
			      <th style="width:15%;">카테고리</th>
			      <th style="width:60%;">제목</th>
			      <th style="width:15%;">작성자</th>
			    </tr>
			  </thead>
			  <tbody>
			    <c:forEach var="board" items="${requestScope.faqBoardList}" >
				    <tr> 
				    	<td>${board.pk_faq_board_num}</td>
				    	<td>${board.faqCate.faq_c_name}</td>
				    	<td><a href="<%= ctxPath%>/board/faqDetail.book?pk_faq_board_num=${board.pk_faq_board_num}">
				    		${board.faq_title}</a>
				    	</td>
				    	<td>${board.faq_writer}</td>
				    </tr>
			    </c:forEach>  
			  </tbody>
			
			</table>
			
			<nav class="my-5">
				<div style="display: flex; width: 100%;">
					<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
				</div>	
			</nav>
			
			<div class="search_outer" >
		 		<div class="search_inner">
		 		<a><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_triangle3.gif" /></a>
			  	<p class="pSearch" style=" display: inline-block; font-size: 12px;">검색어</p>
			  	
			    <select id="searchContent" class="searchType" name="searchType">
			    	<option value="">대상</option>
			    	<option value="faq_title">제목</option>
			        <option value="faq_writer">글쓴이</option>
			
			    </select>
			    <input type="text" name="searchWord" id="searchWord"></input>
			    <button class="btn btn_faq_search" id="btn_search" name="btn_search" onclick="goSearch();" >찾기</button>
			    <button class="btn btn_faq_write" type="button" id="btn_write" style="float:right;" name="btn_write" onclick="location.href='<%= ctxPath%>/board/faqWrite.book'">글쓰기</button>
			    </div>
		    
		  	</div>
		</form>
		</div> <!-- container 끝 -->
		
		
<jsp:include page="/WEB-INF/footer.jsp"/>
