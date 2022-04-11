<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<meta charset="UTF-8">
<title>in사과::장바구니</title>

<!-- 부트스트랩 css -->
<link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

<!-- 직접 만든 CSS -->
<%-- <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/cart_list.css" /> --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_cart.css" /> 

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>	
<script type="text/javascript">
	
	$(document).ready(function() {
		

		 //수량변경(변경시 partPrice, totlaPrice 값변경)
		$("img.pqty_btn").click(function() {
			const pqty_update = $(this).parent().parent().find("input.pqty").val();
			const fk_pro_num = $(this).parent().parent().find("input#fk_pro_num").val();
			const pk_cartno = $(this).parent().parent().find("input#pk_cartno").val();
			
			if(pqty_update ==0){
				alert("1개이상 구매가 가능합니다.");
				location.reload();
				return;
			}
			
			let partPrice = pqtyUpdate(pqty_update, fk_pro_num, pk_cartno);
			partPrice = partPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$(this).parent().parent().parent().find("span#partsaleprice").text(partPrice+"원");
			
			let totalPrice = $("span#totalPrice").text().replace(/\,/g,'');
			totalPrice = totalPrice.replace("원",'');
			if(Number(totalPrice) >= 50000){
			 	$("span.shippingFee").text("무료");	
			}else{
				$("span.shippingFee").text("3,000원");	
			}

		});//end of $("img.pqty_btn").click(function()
		
		$("input.pqty").bind("click", function () {
			const pqty_update = $(this).parent().parent().find("input.pqty").val();
			const fk_pro_num = $(this).parent().parent().find("input#fk_pro_num").val();
			const pk_cartno = $(this).parent().parent().find("input#pk_cartno").val();
			
			if(pqty_update ==0){
				alert("1개이상 구매가 가능합니다.");
				location.reload();
				return;
			}
			
			let partPrice = pqtyUpdate(pqty_update, fk_pro_num, pk_cartno);
			partPrice = partPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$(this).parent().parent().parent().find("span#partsaleprice").text(partPrice+"원");
			
			let totalPrice = $("span#totalPrice").text().replace(/\,/g,'');
			totalPrice = totalPrice.replace("원",'');
			if(Number(totalPrice) >= 50000){
			 	$("span.shippingFee").text("무료");	
			}else{
				$("span.shippingFee").text("3,000원");	
			}
			
		});//end of $("input.pqty").bind("click", function ()
			
		//삭제버튼 
		$("div#btn_delete").click(function () {
			const pk_cartno = $(this).parent().parent().find("input#pk_cartno").val();
			proDeleteOne(pk_cartno);
		});//end of $("li#btn_delete").click(function ()
				
		//선택상품 삭제		
		$("span#deleteSelect").click(function () {
			var cnt = $("input[name='proCheck']:checked").length;
	      	var cartNoArr = new Array();
	        $("input[name='proCheck']:checked").each(function() {
	        	cartNoArr.push($(this).val());
	        });
	        if(cnt == 0){
	            alert("선택된 제품이 없습니다.");
	            return;
	        }
	        const cartNoStr = cartNoArr.join();
	        
	        proDeleteSelect(cnt, cartNoStr);
		});//end of $("li#btn_delete").click(function ()
				
		//전체체크박스설정		
		$("input#selectAll").bind("click",function () {
            if ($("input#selectAll").prop("checked")) {
                $("input#proCheck").prop("checked", true);
            } else {
                $("input#proCheck").prop("checked", false);
            }
		});//end of $("input#selectAll").click(function ()
			
        $("input#proCheck").bind("click",function() {
            if ($("input[name='proCheck']:checked").length == $("input[name='proCheck']").length) {
                $("input#selectAll").prop("checked", true);
            } else {
                $("input#selectAll").prop("checked", false);
            }
        });	//end of $(".test").click(function()
					
        $("div#btn_order").click(function() {
        	const pk_cartno = $(this).parent().find("input#pk_cartno").val();
        	$("input#cartnoOne").val(pk_cartno);
        	orderOne();
        });//end of  $("div#btn_order").click(function() 
        		
	});// end of $(document).ready()
 
	//수량변경함수
	function pqtyUpdate(pqty_update, fk_pro_num, pk_cartno) {
		var partPrice=0;
		
		$.ajax({
			url:"<%= ctxPath%>/product/pqtyUpdate.book",
			type:"POST",
			async: false,
			data:{"pk_cartno":pk_cartno,
				  "fk_pro_num":fk_pro_num,
				  "pqty_update":pqty_update}, 
			dataType:"JSON",
			success:function(json) {
				partPrice = json.partPrice;
				let totalPrice = json.totalPrice;
				let finalPrice = json.finalPrice;
				totalPrice = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				finalPrice = finalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$("span.totalPrice").text(totalPrice+"원");
				$("span.finalPrice").text(finalPrice+"원");
				
				if(json.pqty_update == 0) {
					alert("수량변경실패");
				}
			},
			error: function(request, status, error){
			//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			
				if(request.responseText.match("로그인")){
					if(!alert(request.responseText)) document.location = "<%= ctxPath%>/login/join.book";
				}else{
					alert(request.responseText);
					location.reload();
				}
			}
		});//end of $.ajax
		return partPrice;
	}//end of function pqtyUpdate(pqty_update, fk_pro_num, pk_cartno)
	
	//삭제버튼함수
	function proDeleteOne(pk_cartno) {
		$.ajax({
			url:"<%= ctxPath%>/product/proDeleteOne.book",
			type:"POST",
			data:{"pk_cartno":pk_cartno}, 
			dataType:"JSON",
			success:function(json) {
				if(json.proDeleteOne == 1) {
					alert("삭제되었습니다.");
					location.reload();
				}else{
					alert("오류발생"); 
				}

			},
			error: function(request, status, error){
				//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				
				if(request.responseText.match("로그인")){
					if(!alert(request.responseText)) document.location = "<%= ctxPath%>/login/join.book";
				}else{
					alert(request.responseText);
					location.reload();
				}
				
			}
		});//end of $.ajax
	}//end of function DeleteOne()
	
	//선택삭제버튼 함수
	function  proDeleteSelect(cnt, cartNoStr) {
		$.ajax({
			url:"<%= ctxPath%>/product/proDeleteSelect.book",
			type:"POST",
			data:{"cnt":cnt,
				  "cartNoStr":cartNoStr}, 
			dataType:"JSON",
			success:function(json) {
				if(json.proDeleteSelect == 1) {
					alert("선택한 제품이 삭제되었습니다.");
					location.reload();
				}else{
					alert("오류발생"); 
				}

			},
			error: function(request, status, error){
				//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			
				if(request.responseText.match("로그인")){
					if(!alert(request.responseText)) document.location = "<%= ctxPath%>/login/join.book";
				}else{
					alert(request.responseText);
					location.reload();
				}
				
			}
		});//end of $.ajax
	}//end of function  proDeleteSelect(cnt, cartNoStr) 
	
	//장바구니 모두 비우기
	function  cartDeleteAll() {
		const pk_cartno =  $("input.pk_cartno").length;
		if(pk_cartno == 0){
            alert("제품이 없습니다.");
            return;
		}
		
		$.ajax({
			url:"<%= ctxPath%>/product/cartDeleteAll.book",
			type:"POST",
			data:{}, 
			dataType:"JSON",
			success:function(json) {
				if(json.cartDeleteAll == 1) {
					alert("장바구니 모두 비웠습니다.");
					location.reload();
				}else{
					alert("오류발생"); 
				}

			},
			error: function(request, status, error){
				//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			
				if(request.responseText.match("로그인")){
					if(!alert(request.responseText)) document.location = "<%= ctxPath%>/login/join.book";
				}else{
					alert(request.responseText);
					location.reload();
				}
				
			}
		});//end of $.ajax
	}//end of function proDeleteAll() 
	
	function orderSelect() {
		var cnt = $("input[name='proCheck']:checked").length;
        if(cnt == 0){
            alert("선택된 제품이 없습니다.");
            return;
        }
		const frm = document.cartFrm;
		frm.action = "<%= ctxPath%>/product/orderSelect.book";
		frm.method = "post";
		frm.submit();

	}//end of function orderSelect() 
	
	function orderAll() {
		const pk_cartno =  $("input.pk_cartno").length;
		if(pk_cartno == 0){
            alert("제품이 없습니다.");
            return;
		}
		const frm = document.cartFrm;
		frm.action = "<%= ctxPath%>/product/orderAll.book";
		frm.method = "post";
		frm.submit();

	}//end of function orderAll()
	
	function orderOne() {
		const frm = document.cartFrm;
		frm.action = "<%= ctxPath%>/product/orderOne.book";
		frm.method = "post";
		frm.submit();

	}//end of function orderOne()
	
</script>

<style type="text/css">

</style>

<jsp:include page="../header.jsp" />
<div class="container">
			
<br>&nbsp;<strong style="font-size: 16pt;">
<img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;장바구니</strong>
<hr style="border: solid 2px #e8e8e8;">

	<div class="orderImg">
		<img src="<%= ctxPath %>/images/product/cart.jpg" />
	</div>

<div class="cartInfo">
	<form name="cartFrm">
		<table class="cartListTbl">
			<thead>
				<tr>
					<td style="width: 4%"><input type="checkbox" id="selectAll" name="selectAll" /></td>
					<td style="width: 10%">이미지</td>
					<td style="width: 30%">상품정보</td>
					<td style="width: 10%">판매가</td>
					<td style="width: 6%">수량</td>
					<td style="width: 10%">배송비</td>
					<td style="width: 10%">합계</td>
					<td style="width: 10%">선택</td>
				</tr>
			</thead>
				
			<tbody>
				<%-- 장바구니에 담긴 상품이 없는 경우 --%>
				<c:if test="${empty requestScope.cartList}">
					<tr>
						<td colspan="9">장바구니에 담긴 상품이 없습니다.</td>
					</tr>
				</c:if>
			
				<%-- 장바구니에 담긴 상품이 있는 경우 --%>
				<c:if test="${not empty requestScope.cartList}">
					<c:forEach var="cvo" items="${requestScope.cartList}" varStatus="status">
						<tr>							
							<%-- 체크박스 --%>
							<td> 
								<input type="checkbox" name="proCheck" id="proCheck" value="${cvo.pk_cartno}" />
							</td>
							
							<%-- 이미지 --%>
							<td> 
								<a href="<%=ctxPath%>/product/ShowBookDetail.up?pk_pro_num=${cvo.fk_pro_num}">
								<img src="<%=ctxPath%>/images/product/${cvo.category.cate_name}/${cvo.product.pro_imgfile_name}" style="width: 100%"/>
								</a>
							</td>
							
							<%-- 상품정보 --%>
							<td> 
								<a href="<%=ctxPath%>/product/ShowBookDetail.up?pk_pro_num=${cvo.fk_pro_num}">
									<span class="cartPname">${cvo.product.pro_name}</span>
								</a>
							</td>
							
							<%-- 판매가 --%>
							<td> 
								<span class="orderPrice"><fmt:formatNumber value="${cvo.product.pro_saleprice}" pattern="###,###" />원</span>
							</td>
							
							<%-- 주문수량 + 장바구니 번호(숨김) --%> 
 							<td>
								<div>
									<input type="number" class="pqty" id="pqty" name="pqty" value="${cvo.ck_odr_qty}" min='1' max='100' />
								</div>
								
								<div>
									<img src="<%= ctxPath %>/images/product/btn_quantity_modify.gif" class="pqty_btn" />
									<input class="pk_cartno" type="hidden" id="pk_cartno" name="pk_cartno" value="${cvo.pk_cartno}" />
									<input class="fk_pro_num" type="hidden" id="fk_pro_num" name="fk_pro_num" value="${cvo.fk_pro_num}" />
									<input class="pro_saleprice" type="hidden" id="pro_saleprice" name="pro_saleprice" value="${cvo.product.pro_saleprice}" />
								</div>
							</td>
							 					 
							<%-- 배송비(주문총액이 5만원 이상이면 무료, 아니면 3000원) --%>
							<c:if test="${status.first}">
								<td rowspan= "${fn:length(cartList)}" >
									<span class="shippingFee">
										<c:choose>
											<c:when test="${requestScope.totalPrice == 0}">0원</c:when>
											<c:when test="${requestScope.totalPrice >= 50000}"> 무료 </c:when>
											<c:when test="${requestScope.totalPrice < 50000}">3,000원</c:when>
										</c:choose>
									</span>
								</td>
							</c:if>
							<%-- 주문총액 --%>
							<td>
								<span id="partsaleprice"><fmt:formatNumber value="${cvo.partPrice}" pattern="###,###" />원</span>
							</td>
							
							<%-- 선택 --%>
							<td style="vertical-align: middle">
								<div id="btn_order"><img src="<%= ctxPath %>/images/product/btn_order.gif"/></div>
								<input class="pk_cartno" type="hidden" id="pk_cartno" name="pk_cartno" value="${cvo.pk_cartno}" />
								<div id="btn_wish"><img src="<%= ctxPath %>/images/product/btn_wish.gif" /></div>
								<div id="btn_delete"><img src="<%= ctxPath %>/images/product/btn_delete.gif" /></div>
							</td>
						</tr>
					</c:forEach>
					<input class="pk_cartno" type="hidden" id="cartnoOne" name="cartnoOne" value="" />
				</c:if>
				
			</tbody>
			
			<tfoot>
				<tr>
					<td colspan="2" class="text-left">
						<span>[기본배송]</span>
					</td>

					<td colspan="6" class="text-right">
						<span>상품구매금액&nbsp;</span>
						<span class="totalPrice" id="totalPrice"><fmt:formatNumber value="${requestScope.totalPrice}" pattern="###,###" />원</span>
						<span>&nbsp;+&nbsp;배송비</span>
						<span class="shippingFee">	
							<c:choose>
								<c:when test="${requestScope.totalPrice == 0}">0원</c:when>
								<c:when test="${requestScope.totalPrice >= 50000}"> 무료 </c:when>
								<c:when test="${requestScope.totalPrice < 50000}">3,000원</c:when>
							</c:choose>
						</span>
						<span>&nbsp;=&nbsp;합계&nbsp;:&nbsp;</span>
						<span class="finalPrice"><fmt:formatNumber value="${requestScope.finalPrice}" pattern="###,###" />원</span>
					</td>
				</tr>
				<tr style="border-bottom: none;">
					<td colspan="3" class="text-left">
						<span id="deleteSelect">
							선택상품&nbsp;&nbsp;<img src="<%= ctxPath %>/images/product/btn_delete2.gif" />
						</span>
					</td>
					<td colspan="5" class="text-right">
						<span>
							<img src="<%= ctxPath %>/images/product/btn_clear.gif" onclick="cartDeleteAll()"/>
						</span>	
					</td>
				</tr>	
			</tfoot>	
		</table>
		
		<table class="cartTotalTbl">
			<tbody>
				<tr>
					<td style="width: 30%">
					총 상품금액
					</td>
					<td style="width: 30%">
					총 배송비
					</td>
					<td style="width: 30%">
					결제예정금액
					</td>
				</tr>
				<tr>
					<td>
						<span class="totalPrice"><fmt:formatNumber value="${requestScope.totalPrice}" pattern="###,###" />원</span>
					</td>
					<td>
						<span class="shippingFee">
							<c:choose>
								<c:when test="${requestScope.totalPrice == 0}">0원</c:when>
								<c:when test="${requestScope.totalPrice >= 50000}"> 무료 </c:when>
								<c:when test="${requestScope.totalPrice < 50000}">3,000원</c:when>
							</c:choose>
						</span>
					</td>
					<td>
						<span class="finalPrice"><fmt:formatNumber value="${requestScope.finalPrice}" pattern="###,###" />원</span>
					</td>
				</tr>
			</tbody>
			
		</table>	
	</form>
</div>

<div class="order">
	<span>
		<img src="<%= ctxPath %>/images/product/btn_order_all.gif" onclick="orderAll()" />&nbsp;&nbsp;
		<img src="<%= ctxPath %>/images/product/btn_order_select.gif" onclick="orderSelect()" />
	</span>
</div>

<div  class="shoppingContinue">
	<a href="<%= ctxPath%>/index.book">
		<img src="<%= ctxPath %>/images/product/btn_order_ing.gif" />
	</a>
</div>
	
	
	<br>
	<jsp:include page="cart_board.jsp" />
</div>
<jsp:include page="/WEB-INF/footer.jsp" />