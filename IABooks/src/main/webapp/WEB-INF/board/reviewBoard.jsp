<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
	
%>

<style type="text/css">

</style>

	  
<meta charset="UTF-8">
<title>타인의 책장</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/lee_css/semi_style.css" />
<jsp:include page="/WEB-INF/header.jsp"/>


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

	
	});
	
	
</script>




	
	





<div class="container">
<div class="contents">
  <div class="title" >
  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/ico_heading.gif" /></div>
  	<h2 >타인의 책장</h2>
  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/bar_eee.gif" /></div>
  	<span >후기를 작성하는 공간입니다.</span>
    
  </div>
  <p class="mb-3"></p>
  <form name="revBoardFrm">
  
	  <div class="table_all">
	  <div class="table">
		  <table class="table line_table">
		    <thead>
		      <tr class="tblHeader">
		        <th width="9.5%">번호</th>
		        <th width="18.5%">도서명</th>
		        <th width="40%">제목</th>
		        <th width="11%">작성자</th>
		        <th width="10.5%">작성일</th>
		        <th width="10.5%">평점</th>
		      </tr>
		    </thead>
		    
		    <tbody>
		    	<c:forEach var="board" items="${requestScope.revBoardList}" >
				   	 <tr>
				    	<td class="tbl_number mycenter">${board.pk_rnum}</td>
				    	<td class="tbl_bookname">
				    		<a  href="#">
		            			${board.product.pro_name}
								<span ></span>
							</a>
				    	</td>
				    	<td class="tbl_subject">
				  			<a href="">${board.re_title}</a>
		        			<span class="new_tag">NEW</span>
	        			</td>
				    	<%-- <td class="tbl_writer mycenter">${board.member.name}</td> --%>
				    	<td class="tbl_writer mycenter">${board.re_writer}</td>
				    	<td class="tbl_date mycenter">${board.re_date}</td>
				    	<td class="tbl_grade mycenter">${board.re_grade}</td>
				    </tr>
				 </c:forEach>   
			</tbody>
		   
		  </table>
		  <div class="write_btn_zone">
	      	 <a href="<%= ctxPath%>/board/reviewWrite.book"  class="btn btn-dark" id="write_btn">글쓰기</a> 
	  	  </div>
		  
		</div>
	  	
	  	</div>
	  	
 	</form>

	<nav class="my-5">
		<div style="display: flex; width: 100%;">
			<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
		</div>	
	</nav>

	
 	
 	<div class="search_outer" >
 		<div class="search_inner">
 		<a><img src="<%= ctxPath%>/images/board/leejh_images/ico_triangle3.gif" /></a>
	  	<p class="pSearch" style=" display: inline-block; font-size: 12px;">검색어</p>
	  	
	    <select id="searchDate" name="search">
	    	<option value="week">일주일</option>
	        <option value="month">한달</option>
	        <option value="3months">세달</option>
	        <option value="all">전체</option>
	    </select>
	    <select id="searchContent" name="search">
	    	<option value="subject">제목</option>
	        <option value="content">내용</option>
	        <option value="writername">글쓴이</option>
	        <option value="userid">아이디</option>
	        <option value="nickname">별명</option>
	        <option value="product">상품정보</option>
	
	    </select>
	    <input type="text" name="search"></input>
	    <button class="btn" name="search" >찾기</button>
	    </div>
    
  	</div>
</div>
</div>


	
<jsp:include page="/WEB-INF/footer.jsp"/>
 