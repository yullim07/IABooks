<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>


<meta charset="UTF-8">
<title>이거아님</title>

<!-- css -->
<link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/cart_list.css" />


	<script type="text/javascript">
	$(document).ready(function() {
		$(".cart_odrlist thead input:checkbox[id=check]").click(function() {
			var bool = $(this).prop("checked");
			#(".cart_odrlist tbody input:checkbox[name=checkbox]").prop("checked", bool);
		});
		
		$(".cart_odrlist tbody input:checkbox[id=check]").click(function() {
			var flag = false;
			$(".cart_odrlist tbody input:checkbox[name=checkbox]").each(function() {
				var bool = $(this).prop("checked");
				
				if(!bool) {
					$(".cart_odrlist thead input:checkbox[id=check]").prop("checked", false);
					flag = true;
					return false;
				}
			});
			
			if(!flag) {
				$(".cart_odrlist thead input:checkbox[id=check]").prop("checked", true);
			}
		});
	}); // end of $(document).ready() --------------------	
	</script>

	

	<!-- 컨테이너 시작 -->
	<div class="container">
		
		<%-- <c:if test="${not empty sessionScope.loginuser and sessionScope.loginuser.userid eq 'admin'}"> --%>
		<%-- 장바구니에  --%>
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
			<table class="cart_odrlist" style="width: 100%;">
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
							<input type="checkbox" name="checkbox" id="check" />
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
				<tbody id="cart1_tbody" style="height: 100px;">
					<tr class="cart1_tbody_tr1">
						<td><input type="checkbox" id="cb_tr1" name="checkbox"></td>
						<td><img src="<%=ctxPath %>/images/product/book.jpg" class="thumbnail" /></td>
						<td><span id="pro_name"><strong>책제목</strong></span></td>
						<td><span id="pro_price"><strong>0</strong>원</span></td>
						<td>
							<input type="number" name="odr_qty" id="cart_qty_box" min="1" max="1000" value="1" step="1"
								style="width:50px; height: 24px; line-height: 24px; border: solid 1px #e8e8e8; "> <br>
							<img src="<%=ctxPath %>/images/product/btn_quantity_modify.gif" alt="장바구니 수량 변경하기" />
						</td>
						<td>-</td>
						<td>배송구분</td>
						<td>
							3000원<br>조건 <%-- 나중에 바꾸기! 합이 5만원 이상인 경우 배송비 무료! --%>
						</td>
						<td><span id="total_price"><strong>&nbsp;</strong>원</span></td> <%-- 나중에 바꾸기! 합이 47000원 미만인 경우 합계에 3000원 더하기! --%>
						<td class="button">
							<a href="#" onclick="goOrder()">
								<img src="<%=ctxPath %>/images/product/btn_order.gif" id="btn_order" alt="주문하기">
							</a>
							
							<a href="#" onclick="moveWish()">
								<img src="<%=ctxPath %>/images/product/btn_wish.gif" id="btn_wish" alt="관심상품등록">
							</a>
							
							<a href="#" onclick="cartDelete()">
								<img src="<%=ctxPath %>/images/product/btn_delete.gif" id="btn_delete" alt="삭제">
							</a>
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
							<span> 상품구매금액 <strong> 0 </strong> + 배송비 0(무료) = 합계 : <strong>0</strong>원</span>
						</td>
					</tr>
				</tfoot>
			</table>
			
			<table class="cart_totalprice">
				<tr>
					<th>총 상품금액</th>
					<th>총 배송비</th>
					<th>결제예정금액</th>
				</tr>
				
				<tr>
					<th><span class="totalprice">0</span>원</th>
					<th>+<span class="totalprice">0</span>원</th>
					<th>-<span class="totalprice">0</span>원</th>
				</tr>
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
			<img src="<%= ctxPath%>/images/product/btn_order_all.gif" id="order_all" alt="전체상품주문" />
			<img src="<%= ctxPath%>/images/product/btn_order_select.gif" id="order_select" alt="선택상품주문" />
		</div>
		<div style="margin-bottom: 120px;">
			<img src="<%= ctxPath%>/images/product/btn_order_ing.gif" id="order_ing" alt="쇼핑계속하기" style="float: right;"/>
		</div>
	

	</div>
<script>
	
	$(document).ready(function(){
		$()
	}); // end of $(document).ready(function(){}) --------------------
	
	
	
	
	
	//******************** 탭메뉴 클릭 시 펼쳐주기 시작 **************************************** //
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
	//******************** 탭메뉴 클릭 시 펼쳐주기 끝 **************************************** //
	
	
	
	
	
	
	//******************** 주문하기 버튼을 클릭했을 때 시작 **************************************** //
	$("img#btn_order").click(()=>{
		goOrder();
	});
	//******************** 주문하기 버튼을 클릭했을 때 끝 **************************************** //
	
	
	
	//******************** 주문하기 버튼을 클릭했을 때 시작 **************************************** //
	//******************** 주문하기 버튼을 클릭했을 때 끝 **************************************** //
	
	
	
	// ******************** 주문수량이 바뀌면 주문금액과 수량에 값을 넣어주기 시작 **************************************** //
	const input_number_list = document.querySelectorAll("table#cart_odrlist input[type='number']");

	// *** 1. 주문수량 이벤트 처리하기 *** //
	input_number_list.forEach(function(elt) {
	
		elt.addEventListener('change', () => {
				
		// 주문수량에 대한 금액 알아오기
		
	//	console.log(document.querySelector("table#cart_odrlist span#"+elt.id).innerText); // "구매테이블에서 받아온 가격 정보" 예: 13000
		
		let odrqty = Number(elt.value);
		let price = Number(document.querySelector("table#cart_odrlist > tbody > tr > td#pro_price").innerText.split(",").join(""));
		let odr_price = odrqty*price;
		
	//	console.log("1. 수량(Number(elt.value) " + odrqty);
	//	console.log("2. 가격(price) " + price);
	//	console.log("3. 수량×가격(odr_price) " + odr_price);
	//	console.log("4. odr_price.toLocaleString('en') => " + odr_price.toLocaleString('en'));
		
		document.querySelector("#cart_odrlist > tbody > tr > td:nth-child(6)").innerHTML = "<b>" + odr_price.toLocaleString('en') + "</b> 원";
	//	document.querySelector("#cart_odrlist > tfoot > tr > td:nth-child(2)").innerHTML = "<b>" + odr_price.toLocaleString('en') + "</b> 원";
	//	document.querySelector("#cart_odrlist > tfoot > tr > td:last-child").innerHTML = "("+ odrqty + "개)";
		
		});
		
	});		
	// ******************** 주문수량이 바뀌면 주문금액과 수량에 값을 넣어주기 끝 **************************************** //
	
	
	
	
				
	// ******************** 주문수량 keyup 이벤트 처리하기 시작 **************************************** //
	input_number_list.forEach(function(elt, i, array){
		elt.addEventListener('keyup', ()=>{
			alert("주문수량은 마우스로만 입력하세요.");
			elt.value = 1;
		});
	});
	// ******************** 주문수량 keyup 이벤트 처리하기 끝 **************************************** //
	
	
</script>
