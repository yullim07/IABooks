<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Date"%>

<%
	String ctxPath = request.getContextPath();

	String pro_num = request.getParameter("pk_pro_num");
	
%>

<meta charset="UTF-8">
<title>상품상세페이지 상품후기 목록</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/lee_css/semi_style.css" />

<style type="text/css">

/* 	table,th,td, div.view_btn_zone{
		padding: 15px 20px 15px 0;
	    text-align: right;
	    background-color: #FBFAFA;
	    border: none;
	    margin-top: 0;
		border-collapse:collapse; 
		padding: auto;
	}
	
	#faq_tbody > tr {
		border-bottom: solid 1px #dfdfdf;
	}
	
	td#td_left {
		text-align: left;
		padding-left: 40px;
	}
	
	#faq_tbody > tr#notExist > td {
		padding: 50px 0 !important;
	} 
	
	*/
</style>


<script type="text/javascript">
	
	/* function showImg(){
		console.log("hoi");
	}
	function hideImg(){
		
	} */
	
	$(document).ready(function(){
		
		/* 
		 $("span.error").hide();
		 $("input#name").focus();
		 */
		 let html = "";
		 $("img#file_attach").mouseover( ()=>{
			  const $target = $(event.target);
			  console.log($target.text()+"에 마우스가 올라갔군요");
			  $("span#mouseover_img").html("<img style='height: 80px; vertical-align:middle; ' src='<%= ctxPath%>/images/board/leejh_images/review-attachment-0515b276-bd69-4c97-84ae-76781fcfc993.jpeg'/>");
		 });
		 
		 $("img#file_attach").mouseout(function(){
			 const $target = $(event.target);   
			 $("span#mouseover_img").html("");
		 });
		 
		<%-- let html = "";
		 $("img#file_attach").mouseover(function(){
			    $("div#mouseover_img").css("background-color", "yellow");
			    
			    const $target = $(event.target);
				console.log($target.text()+"에 마우스가 올라갔군요");
					
				$("div#mouseover_img").html("<img src='<%= ctxPath%>/images/board/leejh_images/review-attachment-0515b276-bd69-4c97-84ae-76781fcfc993.jpeg'/>");
			    
		  });
		  $("img#file_attach").mouseout(function(){
		    $("div#mouseover_img").html("<img src='<%= ctxPath%>/images/board/leejh_images/review-attachment-0515b276-bd69-4c97-84ae-76781fcfc993.jpeg'/>");
		  }); --%>
		
		  
		  <%-- $("tr#review_content").hide(); --%>
		  $("tr#notExist").hide();
		  <%-- $("tr#question_content").hide(); --%>
		  
		  
		  
		  
	});
	
	function goReviewWrite(){
		var form = document.test3;
		form.action = "reviewProduct.book";
		form.submit();
	}

	
</script>


	<div class="contents">
		<p class="mb-3"></p>
		
		<div class="table_all tbl_small_board">
		
			<div class="table">
			<c:if test="${not empty requestScope.productRevList}">
				<table class="table" id="faq_table_all">
					<thead class="thead-light" id="faq_thead">
						<tr class="tblHeader">
							<th width="5.6%">번호</th>
							<th width="66.4%">제목</th>
							<th width="8%">작성자</th>
							<th width="11%">작성일</th>
							<th width="9%">평점</th>
						</tr>
					</thead>
					<tbody id="faq_tbody">
						
				    	<c:forEach var="board" items="${requestScope.productRevList}" >
						<tr id="review_content">
							<td class="tbl_number mycenter">${board.pk_rnum}</td>

							
							<td class="tbl_subject" id="td_left"><a href="<%= ctxPath%>/board/reviewDetail.book?pk_rnum=${board.pk_rnum}">${board.re_title}</a>
									<c:set var="yesterday" value="<%= new Date(new Date().getTime() - 60*60*24*1000) %>"/>
									<fmt:formatDate value="${yesterday}" pattern="yyyy-MM-dd HH:mm:ss" var="yesterday" />
									
							    	<c:if test="${ board.re_date > yesterday}">
							    	<span class="new_tag">NEW</span>
							    	</c:if>
							</td>
							<td class="tbl_writer mycenter">${board.re_writer}</td>
							<td class="tbl_date mycenter">${board.re_date}</td>
							<c:if test="${board.re_grade eq 1 }">
						    <td align="center"><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point1.gif" /></td>
						    </c:if>
						    <c:if test="${board.re_grade eq 2 }">
						    <td align="center"><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point2.gif" /></td>
						    </c:if>
						    <c:if test="${board.re_grade eq 3 }">
						    <td align="center"><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point3.gif" /></td>
						    </c:if>
						    <c:if test="${board.re_grade eq 4 }">
						    <td align="center"><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point4.gif" /></td>
						    </c:if>
						    <c:if test="${board.re_grade eq 5 }">
						    <td align="center"><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point5.gif" /></td>
						    </c:if>	
						</tr>
						</c:forEach> 
			    		
						
						



					</tbody>
				</table>
				
				</c:if> 
				<c:if test="${empty requestScope.productRevList}">
		        		<div>
							<br>
							<div style="text-align: center;">
								게시글이 없습니다.
							</div>
							<hr>
					</div>
		        </c:if>
				
				<form name="test3" id="test3" method="post">
				<c:set var="pvo" value="${requestScope.pvo}" />
				<input type="hidden" class="pk_pro_num" name="pk_pro_num" id="pk_pro_num" value="${pvo.pk_pro_num}">
				<div class="view_btn_zone">
					<button type="button" class="btn btn-dark" id="write_review" onclick="goReviewWrite()">후기작성하기</button>
					<button type="button" class="btn btn-dark" id="view_review" onclick="location.href='<%= ctxPath%>/board/reviewBoard.book'">모두보기</button>
				</div>
				</form>
			</div>

		</div>



		<!-- 상품문의 테이블 구간 시작 -->



		<%-- <nav class="my-5">
				<div style="display: flex; width: 100%;">
					<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
				</div>	
		</nav> --%>
		
	</div>

