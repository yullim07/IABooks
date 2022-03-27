<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">
	div.p_search{
		border:solid 3px gray;
		padding: auto;
		
		text-align: center;
	}
	div.p_search_in{
		width: 60%;
		display:inline-block;	
		text-align: left;
	}
	strong.s_title{
		width: 100px;
		display: inline-block;
		text-aling
	}
	
	span.s_title{
		font-weight: bold;
	}
	btn.btn_search{
		
	}
	
</style>

	  
<meta charset="UTF-8">
<title>인디펍 :: 독립출판 온라인 서점</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jaehee_pages/semicss/semi_style.css" />

<jsp:include page="../header.jsp"/>

<script type="text/javascript">
	
	$(document).ready(function(){
		
	
	});

</script>

	
<div class="container">

<div class="contents">
  	<div class="p_search ">
  		<div class="p_search_in">
	 	<div class="item_price">
	 		<strong class="s_title">판매가격대</strong> 
	 		<input class="price" type="text" />
	 		<span>~</span>
	 		<input class="price" type="text"/>
	 	</div>
	 	<div class="order_by" >
		 	<strong class="s_title">검색정렬기준</strong> 
		 	<select id="order_by" name="order_by">
		 		<option selected="selected">::: 기준선택 :::</option>
		 		<option value="recent">신상품 순</option>
		 		<option value="name">상품명 순</option>
		 		<option value="favor">인기상품 순</option>
		 	</select>
	 	</div>
	 	<div class="btn_search">
	 		<button>검색하기</button>
	 	</div>
	 	
	 	</div>
  	</div>

</div>
</div>
	
<jsp:include page="../footer.jsp"/>
 