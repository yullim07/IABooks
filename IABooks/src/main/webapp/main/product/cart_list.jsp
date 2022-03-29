<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>


<meta charset="UTF-8">
<title>in사과북스::장바구니</title>

<!-- css -->
<link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/cart_list.css" />

	<!-- 컨테이너 시작 -->
	<!-- <div class="container"> -->
	
	
	<%-- <c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.userid eq 'admin'}"> --%>
	<%-- admin으로 로그인했으면 --%>
		<div class="cart_empty">
			<table class="cart_none">
				<tr>
					<td>장바구니가 비어있습니다.</td>
				</tr>
			</table>	
		</div>
	<%-- </c:if> --%>
	
	<!-- 총주문액 시작 -->
	
	<div class="orderlist_area">
		<table class="cart_totalPrice" style="width: 100%;">
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
			<thead style="font-size: 9pt; color: #333; height: 60px; border: solid 1px #e8e8e8; background-color: #F2F2F2;">
				<tr>
					<th scope="col">
						<input type="checkbox" 
						onclick="Basket.setCheckBasketList('basket_product_normal_type_normal', this);">
					</th>
					<th scope="col" style="height: 20px;">이미지</th>
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
			<tbody style="height: 100px;">
				<tr>
					<td><input type="checkbox" id="basket_chk_id_0" name="basket_product"></td>
					<td><img src="<%=ctxPath %>/images/product/book.jpg" class="thumbnail" /></td>
					<td><strong>책제목</strong></td>
					<td><strong>10,000원</strong></td>
					<td>
						<input id="cart_qty_box" type="number" min="1" max="1000" value="1" step="1"
							style="width:50px; height: 24px; line-height: 24px; border: solid 1px #e8e8e8; "> <br>
						<img src="<%=ctxPath %>/images/product/btn_quantity_modify.gif" />
					</td>
					<td>적립금</td>
					<td>배송구분</td>
					<td>3000원<br>조건</td>
					<td><strong>12,000원</strong></td>
					<td class="button">
						<a href="#" onclick="Basket.orderBasketItem(0);">
						<img src="<%=ctxPath %>/images/product/btn_order.gif" alt="주문하기"></a>
						
						<a href="#" onclick="BasketNew.moveWish(0);">
						<img src="<%=ctxPath %>/images/product/btn_wish.gif" alt="관심상품등록"></a>
						
						<a href="#" onclick="Basket.deleteBasketItem(0);">
						<img src="<%=ctxPath %>/images/product/btn_delete.gif" alt="삭제"></a>
					</td>
					
					
				</tr>
			</tbody>
			<tfoot style="font-size: 9pt; color: #333; height: 60px; border: solid 1px #e8e8e8; background-color: #F2F2F2;">
				<tr>
					<td colspan="2">
						<span>[기본배송]</span>
					</td>
					<td colspan="4">
						&nbsp;
					</td>
					<td colspan="4">
						<span> 상품구매금액 <strong> 85000 </strong> + 배송비 0(무료) = 합계 : <strong>85000원</strong></span>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	<!-- 총주문액 끝 -->
	
	<hr style="border: solid 1px #e8e8e8;">
	
	<!-- 삭제 또는 이동 -->
	<div>
		<strong class="text" style="font-size: 9pt;">선택상품을</strong>
		<a href="#"><img src="<%=ctxPath %>/images/product/btn_delete2.gif" alt="장바구니에서 삭제하기"></a>
		<a href="#"><img src="<%=ctxPath %>/images/product/btn_clear.gif" alt="장바구니 비우기"></a>
	</div>
	
	<!--  -->
	
	<hr style="border: solid 1px #e8e8e8;">
	
	
	<div class="text-center">
				<img src="<%= ctxPath%>/images/product/btn_order_all.gif" alt="전체상품주문" />
				<img src="<%= ctxPath%>/images/product/btn_order_select.gif" alt="선택상품주문" />
	</div>
	<div style="margin-bottom: 120px;">
		<img src="<%= ctxPath%>/images/product/btn_order_ing.gif" alt="쇼핑계속하기" style="float: right;"/>
	</div>
		

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
