<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="board.model.BoardDAO" %>
<%@ page import="board.model.QnABoardVO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Date"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

</style>

	  
<meta charset="UTF-8">
<title>in사과 : 상품 Q&A</title>

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_category_search.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/lee_css/semi_style.css" />
<jsp:include page="/WEB-INF/header.jsp"/>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		 $(".goPro").click(()=>{
			 
			location.href="<%= ctxPath%>/product/showBookDetail.book?pronum=;
		 });
		
		$("button#btn_search").click(function(){
			// console.log(이 form 이 submit 될 때 함수 실행하겠다.);	
			
			if($("select.searchContent").val() == "" ) {
				alert("검색대상을 올바르게 선택하세요!!");
				return false; // submit을 하지 않고 종료
			}
			
			if($("input#qnaSearchWord").val().trim() == "") {
				alert("검색어는 공백만으로 되지 않습니다. 검색어를 올바르게 입력하세요!!");
				return false;
			}
			
		 	$("input#qnaSearchWord").bind("keyup",function(event){
				if(event.keyCode ==13){
					//검색어에서 엔터를 치면 검색하러 가도록 한다.
					goQnaSearch();
				}
			});
		 	
			$("input#qnaSearchWord").bind("keydown",function(event){
				if(event.keyCode ==13){
					//검색어에서 엔터를 치면 검색하러 가도록 한다.
					goQnaSearch();
				}
			}); 
			
		}); // end of $("button#btn_search").click(function(){})----------------
		
		
		// 검색조건을 넣은 후, action단에서 페이지바를 보여주고 다른 페이징 처리를 할 때 검색조건을 넣어준다
		// alert("~~ 확인용 : ${requestScope.searchType} ");
		// 회원명 조건하고 했더니 "~~ 확인용 : name" 뜸
		if( "${requestScope.searchContent}" != "" ) { // 반드시 if에 넣을때 쌍따옴표 꼭 붙여라!!(자바스크립트임)
			$("select#searchContent").val("${requestScope.searchContent}");
			$("input#qnaSearchWord").val("${requestScope.qnaSearchWord}");
		}
	
	}); // end of $(document).ready(function(){})-----------
	

	//Fucntion Declaration
	function goQnaSearch(){
		
		if($("select.searchContent").val() == "" ) {
			alert("검색대상을 올바르게 선택하세요!!");
			return; // goSearch() 함수 종료.
		}
	
		if( $("input#qnaSearchWord").val().trim() == "" ){ //input 값 또한 텅 비었다면, 공백
			alert("검색어는 공백만으로는 되지 않습니다. \n검색어를 올바르게 입력하세요!!");
			return; // return; 는 goSearch() 함수 종료이다.
		}
		
		const frm = document.qnaSearchFrm; 
		frm.action = "qnaBoard.book";
		frm.method ="get"; //안쓰면 생략 가능
		frm.submit(); 
		
	}
	
</script>



<div class="container">
	<div class="contents">
	  
		<div class="title" >
			<div class="title_icon" ><%-- <img src="<%= ctxPath%>/images/board/leejh_images/ico_heading.gif" /> --%></div>
		  	<h2 >상품 Q&A</h2>
		  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/bar_eee.gif" /></div>
		  	<span >상품 Q&A입니다. 상품에 관해서 궁금하신 점을 질문해주세요.</span>
	  	</div>
	  
	  	<p class="mb-3"></p>
	  
	  	<p class="board_top"><img  src="<%= ctxPath%>/images/board/leejh_images/board_top.gif" /></p>
	  
	  	<div class="table_all">
	 		<div class="table">
	 		
		  		<table class="table qna_table line_table">
		  		
				    <thead>
				      <tr class="tblHeader">
				        <th width="9.5%">번호</th>
				        <th width="18.5%">도서명</th>
				        <th width="40%">제목</th>
				        <th width="11%">작성자</th>
				        <th width="10.5%">작성일</th>
				        <th width="10.5%">조회</th>
				      </tr>
				    </thead>
		    
		    
				    <tbody>
					    <c:set var="num" value="${requestScope.qvo.totalCnt - ( (requestScope.qvo.currentShowPageNo-1) *10 ) }" />
					    <c:if test="${not empty requestScope.qnaboardList}">
				    	<c:forEach var="board" items="${requestScope.qnaboardList}">
				        	<tr class="qnaboardInfo">
				        			
					        	<td class="tbl_number mycenter">${num}</td>
							    	
						    	<td class="tbl_bookname">
						    		<c:if test="${board.product.pro_name != '-9999'}">
							    		<a href="<%= ctxPath%>/product/showBookDetail.book?pronum=${board.fk_pnum}">
					            			<img  class="goPro"  src="<%= ctxPath%>/images/product/${board.category.cate_name}/${board.product.pro_imgfile_name}" id="thumbimg"/>
											<span class="goPro">${board.product.pro_name}</span>
										</a>  
										
										<input type="hidden" class="fk_pnum" name="fk_pnum" id="fk_pnum" value="${board.fk_pnum}"/>
									</c:if>
							    </td>
							    	
						    	<td class="tbl_subject">
						    		<%-- 비밀글일때 아이콘 표시 --%>
							    		<a href="<%= ctxPath%>/board/qnaDetail.book?pk_qna_num=${board.pk_qna_num}">
							    				${board.qna_title}
							    		</a>
										<c:if test="${board.qna_issecret eq '1'}">
							    			<img class="lock" src="<%= ctxPath%>/images/board/leejh_images/ico_lock.gif"/>
							    		</c:if>
							    	 
										<c:set var="yesterday" value="<%= new Date(new Date().getTime() - 60*60*24*1000) %>"/>
										<fmt:formatDate value="${yesterday}" pattern="yyyy-MM-dd HH:mm:ss" var="yesterday" />
									
								    	<c:if test="${ board.qna_date > yesterday}">
								    		<span class="new_tag">NEW</span>
								    	</c:if>
		
						    		<c:if test="${board.qna_readcount > '10'}">
						    		<span class="hit_tag">HIT</span>
						    		</c:if>
		
						    		 <input type="hidden" class="qna_issecret" name="qna_issecret" id="qna_issecret" value="${board.qna_issecret}"/>
						    		  <input type="hidden" class="fk_userid" name="fk_userid" id="fk_userid" value="${board.fk_userid}"/> 
						    		<input type="hidden" class="qna_passwd" name="qna_passwd" id="qna_passwd" value="${board.qna_passwd}"/>
			        		   
			        		    <input type="hidden" class="qna_issecret" name="qna_issecret" id="qna_issecret" value="${requestScope.qna_issecret}"/>
			        		    <input type="hidden" class="fk_pnum" name="fk_pnum" id="fk_pnum" value="${board.fk_pnum}"/>
			        		    <input type="hidden" class="cate_name" name="cate_name" id="cate_name" value="${requestScope.product.cate_name}"/>
			        		    <input type="hidden" class="pro_imgfile_name" name="pro_imgfile_name" id="pro_imgfile_name" value="${requestScope.product.pro_imgfile_name}"/>
			        			
						    	
						    	</td>
							    	
							  
							    	<td class="tbl_writer mycenter"> ${board.member.name}</td>
							    	<td class="tbl_date mycenter"> ${board.qna_date}</td>
							    	<td class="tbl_viewcount mycenter">${board.qna_readcount}</td>
				        			
				        			
				        		</tr>
				        		 <c:set var="num" value="${num-1 }"></c:set>
				        	</c:forEach>
				        </c:if>
				        
				        <c:if test="${empty requestScope.qnaboardList}">
			        		<tr>
			        			<td colspan="6" style="text-align: center; ">검색된 데이터가 존재하지 않습니다.</td>
			        		</tr>
			        	</c:if>
				
					</tbody>
		 
		  </table>
		 
		  <div class="write_btn_zone">
	      	<button type="button" class="btn btn-dark" onclick="location.href='<%= ctxPath %>/board/qnaWrite.book'">글쓰기</button>
	  	  </div>
		  
		</div>
	  	
	  	</div>
	  	
	  	<%--페이지 네비게이션 --%>
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center ">
			<%--ShowBookListAction 작성 --%>
				${requestScope.pageBar}
		  	</ul>
		</nav>
		
	
		<form name="qnaSearchFrm" action="qnaBoard.book" method="get" >
		 	<div class="search_outer" >
		 		<div class="search_inner">
		 		<a><img src="<%= ctxPath%>/images/board/leejh_images/ico_triangle3.gif" /></a>
			  	<p class="pSearch" style=" display: inline-block; font-size: 12px;">검색어</p>
		
			    <select id="searchContent" name="searchContent" style="font-size: 14px;">
			    	<option value="qna_title" selected="selected">제목</option>
			        <option value="qna_contents">글내용</option>
			     
			        <option value="fk_userid">아이디</option>
			       
			
			    </select>
			    
			    <input type="text" id="qnaSearchWord" name="qnaSearchWord"></input>
			    
			    
			    <button type="submit" onclick="goQnaSearch()" class="btn" name="search" >찾기</button>
			   <%--  <input type="submit" value="검색" style="margin-right: 30px;" /> --%>
			    </div>
		    
		  	</div>
	  	</form>
	</div>
</div>


	
<jsp:include page="/WEB-INF/footer.jsp"/>
 