<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>


<meta charset="UTF-8">
<title>in사과북스::장바구니</title>

<!-- css -->
<link rel="stylesheet" href="<%=ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

<style type="text/css">

.notosanskr * { 
  font-family: 'Noto Sans KR', sans-serif;
}

/* 전체 컨테이너 */
div.container {
	width: 100%;
/* 	padding: 1em; */
}

/* Style tab links */
.tablink {
	background-color: #F2F2F2;
	color: #888;
	float: left;
	border: none;
	cursor: pointer;
	padding: 14px 16px;
	font-size: 14px;
	width: 25%;
}

.tabcart {
	background-color: #F2F2F2;
	color: #888;
	float: left;
	border-left: red;
	border: none;
	cursor: default;
	padding: 14px 16px;
	font-size: 14px;
	width: 50%;
	text-align: right;
}

.tablink:hover {
	background-color: #e8e8e8;
	color: #888;
}

/* Style the tab content (and add height:100% for full page content) */
.tabcontent {
	color: #000;
	display: none;
	padding: 100px 20px;
}

#delivery_in, #delivery_out {
	background-color: #fff;
}

.thumbnail {
	width: 80px;
	height: 80px;
}
</style>

<!-- 헤더 삽입 -->
<jsp:include page="/header.jsp" />

<!-- 전체 컨테이너 시작 -->
<div class="container">

	<!-- 페이지 제목 -->
	<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;" />&nbsp;장바구니</strong>
	<hr style="border: solid 1px #e8e8e8;">
	
	<!-- 주문단계 이미지 -->
	<img src="<%= ctxPath%>/images/product/img_order_step1.gif" style="width: 100%;">
	<hr style="border: solid 1px #e8e8e8;">

	<!-- 국내배송 해외배송 구분탭 -->
	<div class="deltype">
		<button class="tablink" onclick="openPage('delivery_in', this, '#fff')" id="defaultOpen">
			국내배송상품(숫자)
		</button>
		<button class="tablink" onclick="openPage('delivery_out', this, '#fff')">
			해외배송상품(숫자)
		</button>
		<p class="tabcart">장바구니에 담긴 상품은 30일 동안 보관됩니다.</p>

		<div id="delivery_in" class="tabcontent">
			<!-- 장바구니 목록 시작 -->
			<jsp:include page="cart_list.jsp" />			
			<!-- 장바구니 목록 끝 -->
		</div>
	
		<div id="delivery_out" class="tabcontent">
			<!-- 장바구니 목록 시작 -->
			<jsp:include page="cart_list.jsp" />
			<!-- 장바구니 목록 끝 -->
		</div>		
	</div>
	<!-- 국내배송 해외배송 구분탭 끝 -->
	
	<hr style="border: solid 1px #e8e8e8;">
	
	<!-- 장바구니 이용안내 시작 -->
	<div style="width: 100%; margin: 0 auto;">
		<jsp:include page="cart_board.jsp"/>
	</div>
	<!-- 장바구니 이용안내 끝 -->
	
</div>
<!-- 전체 컨테이너 끝 -->

<jsp:include page="/footer.jsp" />





<script>
	/* 탭메뉴 클릭 시 펼쳐주기 */
	function openPage(pageName, elmnt, color) {
		var i, tabcontent, tablinks;
		tabcontent = document.getElementsByClassName("tabcontent");
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none";
		}
		tablinks = document.getElementsByClassName("tablink");
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].style.backgroundColor = "";
		}
		document.getElementById(pageName).style.display = "block";
		elmnt.style.backgroundColor = color;
	}

	// Get the element with id="defaultOpen" and click on it
	document.getElementById("defaultOpen").click();
</script>