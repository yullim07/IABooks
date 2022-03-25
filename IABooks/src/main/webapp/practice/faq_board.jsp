<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

</style>



	<script type="text/javascript">
		
		$(document).ready(function(){
			
		});
	
	</script>


<jsp:include page="../header.jsp"/>



<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jaehee_pages/semicss/semi_style.css" />
    
<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    
</head>
<body>


	    <div class="container">
			    <div class="title" >
				  	<div class="title_icon" ><img src="<%= ctxPath%>/jaehee_pages/semi_images/ico_heading.gif" /></div>
				  	<h2>FAQ</h2>
				  	<div class="bar_icon" ><img src="<%= ctxPath%>/jaehee_pages/semi_images/bar_eee.gif" /></div>
				  	<span >이용안내 FAQ입니다.</span>
			    
			   </div>
			  <!-- <p class="mb-3"></p> -->
			
			  	
			    <select id="" class="cateDropdown" name="search">
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
			    <tr>
			      <td>9</td>
			      <td id="product">상품</td>
			      <td><a href="">독립출판물이란 무엇인가요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>8</td>
			      <td id="return">반품/교환</td>
			      <td><a href="">반품은 어떻게 하나요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>7</td>
			      <td id="order">주문/배송</td>
			      <td><a href="">주문한 상품은 언제 받을 수 있나요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>6</td>
			      <td id="order">주문/배송</td>
			      <td><a href="">현금영수증 발행신청은 어디서 하나요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>5</td>
			      <td id="order">주문/배송</td>
			      <td><a href="">배송비는 얼마인가요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>4</td>
			      <td id="order">주문/배송</td>
			      <td><a href="">비회원 주문조회는 어떻게 하나요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>3</td>
			      <td id="order">주문/배송</td>
			      <td><a href="">해외 배송이 가능한가요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>2</td>
			      <td id="return">반품/교환</td>
			      <td><a href="">교환은 어떻게 하나요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>1</td>
			      <td id="product">상품</td>
			      <td><a href="">품절된 도서입니다. 재입고는 언제 되나요?</a></td>
			      <td>인디펍</td>
			    </tr>
			  </tbody>
			</table>
			
			<div class="search_outer" >
		 		<div class="search_inner">
		 		<a><img src="<%= ctxPath%>/jaehee_pages/semi_images/ico_triangle3.gif" /></a>
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
			    </div>
		    
		  	</div>
			
		</div> <!-- container 끝 -->
		
		
<jsp:include page="../footer.jsp"/>
