<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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
		var form = document.test;
		form.action = "reviewProduct.book";
		form.submit();
	}

	
</script>


	<div class="contents">
		<p class="mb-3"></p>
		<div class="table_all tbl_small_board">
			<div class="table">
				<table class="table" id="faq_table_all">
					<thead class="thead-light" id="faq_thead">
						<tr class="tblHeader">
							<th width="5.6%">번호</th>
							<th width="66.4%">제목</th>
							<th width="8%">작성자</th>
							<th width="8%">작성일</th>
							<th width="6.4%">조회</th>
							<th width="5.6%">평점</th>
						</tr>
					</thead>
					<tbody id="faq_tbody">
						<tr id="review_content">
							<td class="tbl_number mycenter">1</td>

							</td>
							<td class="tbl_subject" id="td_left"><a href=""> 번호 : <%=request.getParameter("pk_pro_num") %></a> <img id="file_attach" name="file_attach" src="<%= ctxPath%>/images/board/leejh_images/ico_attach2.gif" <%-- onmouseover="showImg()" onmouseout="hideImg()"--%> /> <span id="mouseover_img" style="position: absolute;"></span> <span class="new_tag">NEW</span>
							<td class="tbl_writer mycenter">네**** </td>
							<td class="tbl_date mycenter">2022-03-17</td>
							<td class="tbl_readcount mycenter"><span>1</span></td>
							<td class="tbl_grade mycenter"><img name="star_point" src="<%= ctxPath%>/images/board/leejh_images/ico_point5.gif" /></td>
						</tr>

						<tr id="review_content">
							<td class="tbl_number mycenter">2</td>

							</td>
							<td class="tbl_subject" id="td_left"><a href=""> 우리팀 화이팅! ${requestScope.pvo.pk_pro_num} </a> <img id="file_attach" name="file_attach" src="<%= ctxPath%>/images/board/leejh_images/ico_attach2.gif" <%-- onmouseover="showImg()" onmouseout="hideImg()"--%> /> <span id="mouseover_img" style="position: absolute;"></span> <span class="new_tag">NEW</span>
							<td class="tbl_writer mycenter">쌍****</td>
							<td class="tbl_date mycenter">2022-03-24</td>
							<td class="tbl_readcount mycenter"><span>1</span></td>
							<td class="tbl_grade mycenter"><img name="star_point" src="<%= ctxPath%>/images/board/leejh_images/ico_point5.gif" /></td>
						</tr>

						<tr id="notExist">
							<td colspan="6">
								<div>
									<span style="color: #555555; font-weight: bold;">표시할 내용이 없습니다.</span>
								</div>
							</td>
						</tr>



					</tbody>
				</table>
				<form name="test" id="test" method="post">
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


		





		<div class="pagination2 justify-content-center">
			<ul>
				<li><a href="#"><img src="<%= ctxPath%>/images/board/leejh_images/btn_page_first.gif" /></a></li>
				<li class="active"><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li>
				<li><a href="#">6</a></li>
				<li><a href="#">7</a></li>
				<li><a href="#">8</a></li>
				<li><a href="#">9</a></li>
				<li><a href="#">10</a></li>
				<li><a href="#"><img src="<%= ctxPath%>/images/board/leejh_images/btn_page_last.gif" /></a></li>
			</ul>
		</div>
		
	</div>

