<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
	
	
	function goQnaWrite(){
		var form = document.test;
		form.action = "qnaProduct.book";
		form.submit();
	} 
	
	
</script>











<div class="container">
	<div class="contents">
		
		<!-- 상품문의 테이블 구간 시작 -->

		<div class="table_all tbl_small_board">
			<div class="table">
				<table class="table" id="faq_table_all">
					<thead class="thead-light" id="faq_thead">
						<tr class="tblHeader">
							<th width="5.6%">번호</th>
							<th width="66.4%">제목</th>
							<th width="8%">작성자</th>
							<th width="11%">작성일</th>
							<th width="9%">조회</th>
						</tr>
					</thead>
					<tbody id="faq_tbody">
					
						<c:if test="${not empty requestScope.productQnaList}">
				    	<c:forEach var="board" items="${requestScope.productQnaList}" >
						<tr id="question_content">
							<td class="tbl_number mycenter">${board.pk_qna_num}</td>
							<td class="tbl_subject" style=" padding: 6px 3px 4px 40px ;">
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
					    		
					    	</td>
							<td class="tbl_writer mycenter">${board.member.name}</td>
					    	<td class="tbl_date mycenter">${board.qna_date}</td>
					    	<td class="tbl_viewcount mycenter">${board.qna_readcount}</td>

						</tr>
						</c:forEach> 
			    		</c:if> 
			    		
			    		<%-- 답글
						<tr id="question_content">
							<td class="tbl_number mycenter">2</td>
							
							<td class="tbl_subject" id="td_left">&nbsp;&nbsp;&nbsp; 
							<img src="<%= ctxPath%>/images/board/leejh_images/ico_re.gif" /> <a
								href=""> 배송관련 문의드립니다. </a>
							<td class="tbl_writer mycenter">인디펍</td>
							<td class="tbl_date mycenter">2022-03-20</td>
							<td class="tbl_readcount mycenter"><span>1</span></td>

						</tr> --%>

						<c:if test="${empty board.productList}">
		        		<tr id="notExist">
					      	<td colspan="6">
					      		<div>
					      		<span style="color: #555555; font-weight:bold;">표시할 내용이 없습니다.</span>
					      		</div>
					      	</td>
					    </tr>
		        		</c:if>



					</tbody>
				</table>
				<form name="test" id="test" method="post">
				<c:set var="pvo" value="${requestScope.pvo}" />
				<input type="hidden" class="pk_pro_num" name="pk_pro_num" id="pk_pro_num" value="${pvo.pk_pro_num}">
				<div class="view_btn_zone">
					<button type="button" class="btn btn-dark" id="write_btn" onclick="location.href='<%= ctxPath%>/product/qnaProduct.book'">상품문의하기</button>
					<button type="button" class="btn btn-dark" id="view_btn" onclick="goQnaWrite()">모두보기</button>
				</div>
				</form>

			</div>

		</div>






		<nav class="my-5">
				<div style="display: flex; width: 100%;">
					<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
				</div>	
		</nav>
	</div>
</div>

