<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="board.model.BoardDAO" %>
<%@ page import="board.model.FaqBoardVO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>


<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/jeong_css/semi_style.css" />

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style type="text/css">

	#faq_table_all > tbody > tr > td:nth-child(2), td:nth-child(4) {
		text-align: center;
	}
	
</style>


<jsp:include page="/WEB-INF/header.jsp"/>

<script type="text/javascript">
	
	$(document).ready(function(){
		
	});

</script>

	    <div class="container">
			    <div class="title" >
				  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_heading.gif" /></div>
				  	<h2>FAQ</h2>
				  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/bar_eee.gif" /></div>
				  	<span >이용안내 FAQ입니다.</span>
			    
			   </div>
			  <!-- <p class="mb-3"></p> -->
			
			  	
			    <select id="" class="cateDropdown" name="search">
			       <option value="1">전체</option>
	               <option value="2">회원</option>
	               <option value="3">상품</option>
	               <option value="4">반품/교환</option>
	               <option value="5">주문/배송</option>
	               <option value="6">제휴</option>
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
			    <%
			    	BoardDAO bdao = new BoardDAO();
			    	List<FaqBoardVO> faqList = bdao.faqBoardList();
			    	
			    	for(int i=0; i<faqList.size(); i++) {
			    %>
			    <tr> 
			    	<td><%= faqList.get(i).getPk_faq_board_num() %></td>
			    	<td><%= faqList.get(i).getFk_faq_c_name() %></td>
			    	<td><a href="<%= ctxPath%>/board/faqDetail.book?pk_faq_board_num=<%= faqList.get(i).getPk_faq_board_num()%>">
			    		<%= faqList.get(i).getFaq_title() %></a>
			    	</td>
			    	<td><%= faqList.get(i).getFaq_writer() %></td>
			    </tr>
			    <%
			    	}
			    %>
			  </tbody>
			</table>
			
			<div class="search_outer" >
		 		<div class="search_inner">
		 		<a><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_triangle3.gif" /></a>
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
			    <input type="text" name="search" id="input_faq_search"></input>
			    <button class="btn btn_faq_search" name="search" >찾기</button>
			    
			    <button class="btn btn_faq_write" style="float:right;" name="write" onclick="location.href='<%= ctxPath%>/board/faqWrite.book' ">글쓰기</button>
			    
			    </div>
		    
		  	</div>
			
		</div> <!-- container 끝 -->
		
		
<jsp:include page="/WEB-INF/footer.jsp"/>
