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

</style>

<!-- 헤더 삽입 -->
<jsp:include page="/header.jsp" />

<!-- 전체 컨테이너 시작 -->
<div class="container">

	<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;" />&nbsp;장바구니</strong>
	<hr style="border: solid 1px #e8e8e8;">


	<!-- 국내배송 해외배송 구분 -->
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
	<!-- 국내배송 해외배송 끝 -->
	
	<!-- 총주문액 시작 -->
	<hr style="border: solid 1px #e8e8e8;">
		
	<table class="cart_totalPrice">
		<tr>
			<th style="width: 30%"><strong>총 상품금액</strong></th>
			<th style="width: 20%"><strong>총 배송비</strong></th>
			<th style="width: 50%"><strong>결제예정 금액</strong></th>
		</tr>
		<tr>
			<td><span>14,000원</span></td>
			<td>+ <span>0원</span></td>
			<td style="color: #c11e31;">= <span>14,000원</span></td>
		</tr>
	</table>
	<!-- 총주문액 끝 -->
	
	<!-- 장바구니 이용안내 시작 -->
	<jsp:include page="cart_board.jsp" />
	<!-- 장바구니 이용안내 끝 -->
	
</div>

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