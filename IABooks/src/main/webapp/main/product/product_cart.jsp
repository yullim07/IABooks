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
	
	<div class="orderlist_area">
		<table class="cart_totalPrice" style="border: solid 1px gold; width: 100%;">
			<colgroup>
				<col style="width:27px">
				<col style="width:92px">
				<col style="width:auto">
				<col style="width:98px">
				<col style="width:75px">
				<col style="width:98px">
				<col style="width:98px">
				<col style="width:85px">
				<col style="width:98px">
				<col style="width:110px">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">
						<input type="checkbox" 
						onclick="Basket.setCheckBasketList('basket_product_normal_type_normal', this);">
					</th>
					<th scope="col">이미지</th>
					<th scope="col">상품정보</th>
					<th scope="col">판매가</th>
					<th scope="col">수량</th>
					<th scope="col" class="mileage">적립금</th>
					<th scope="col">배송구분</th>
					<th scope="col">배송비</th>
					<th scope="col">합계</th>
					<th scope="col">선택</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="checkbox" id="basket_chk_id_0" name="basket_product"></td>
					<td><img src="<%=ctxPath %>/images/product/book.jpg" class="thumbnail" /></td>
					<td><strong>책제목</strong></td>
					<td><strong>10,000원</strong></td>
					<td>
						수량박스<br>
						<img src="<%=ctxPath %>/images/product/btn_quantity_modify.gif" />
					</td>
					
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="10">
						<span class="gLeft">[기본배송]</span>
						<span> 상품구매금액 <strong> 85000 </strong> + 배송비 0(무료) = 합계 : <strong>85000원</strong></span>
					</td>
				</tr>
			</tfoot>
			
			<!-- tr style="border: solid 1px red; heigth: 80px;">
				<th style="width: 30%"><strong>총 상품금액</strong></th>
				<th style="width: 20%"><strong>총 배송비</strong></th>
				<th style="width: 50%"><strong>결제예정 금액</strong></th>
			</tr>
			<tr>
				<td><span>14,000원</span></td>
				<td>+ <span>0원</span></td>
				<td style="color: #c11e31;">= <span>14,000원</span></td>
			</tr> -->
		</table>
	</div>
	
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