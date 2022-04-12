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
			
		//삭제버튼 
		$("div#btn_delete").click(function () {
			const pk_wnum = $(this).parent().parent().find("input#pk_wnum").val();
			wishDeleteOne(pk_wnum);
		});//end of $("li#btn_delete").click(function ()
				
		//선택상품 삭제		
		$("span#deleteSelect").click(function () {
			var cnt = $("input[name='proCheck']:checked").length;
	      	var wishNoArr = new Array();
	        $("input[name='proCheck']:checked").each(function() {
	        	wishNoArr.push($(this).val());
	        });
	        if(cnt == 0){
	            alert("선택된 제품이 없습니다.");
	            return;
	        }
	        const wishNoStr = wishNoArr.join();
	        
	        wishDeleteSelect(cnt, wishNoStr);
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
      
      //////////////정환모 작업공간 /////////////////////////////////////////
        		
      // 선택 탭에 있는 장바구니담기 버튼 
		$("div#btn_wish").click(function () {
			const pk_wnum = $(this).parent().parent().find("input#pk_wnum").val();
			wishToCartOne(pk_wnum);
		});//end of $("li#btn_delete").click(function ()
        		
		//선택상품 장바구니에 담기		
		$("span#addToCartSelect").click(function () {
			var cnt = $("input[name='proCheck']:checked").length;
	      	var wishNoArr = new Array();
	        $("input[name='proCheck']:checked").each(function() {
	        	wishNoArr.push($(this).val());
	        });
	        if(cnt == 0){
	            alert("선택된 제품이 없습니다.");
	            return;
	        }
	        const wishNoStr = wishNoArr.join();
	        
	        wishToCartSelect(cnt, wishNoStr);
		});//end of $("li#btn_delete").click(function ()
		
		// 선택탭 상품 주문하기 버튼 클릭시
		$("div#btn_odr").click(function() {
        	const pk_wnum = $(this).parent().find("input#pk_wnum").val();
        	console.log(pk_wnum);
        	$("input#wishnoOne").val(pk_wnum);
        	goBuyFromWishList();
        	
        });//end of  $("div#btn_order").click(function() 
				
	});// end of $(document).ready()------------------------------------
	
	//관심상품 삭제버튼함수
	function wishDeleteOne(pk_wnum) {
		$.ajax({
			url:"<%= ctxPath%>/product/wishDeleteOne.book",
			type:"POST",
			data:{"pk_wnum":pk_wnum}, 
			dataType:"JSON",
			success:function(json) {
				if(json.wishDeleteOne == 1) {
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
	}//end of function wishDeleteOne()
	
	// 관심상품 선택삭제버튼 함수
	function  wishDeleteSelect(cnt, wishNoStr) {
		$.ajax({
			url:"<%= ctxPath%>/product/wishDeleteSelect.book",
			type:"POST",
			data:{"cnt":cnt,
				  "wishNoStr":wishNoStr}, 
			dataType:"JSON",
			success:function(json) {
				if(json.wishDeleteSelect == 1) {
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
	
	//관심상품 모두 비우기
	function  wishDeleteAll() {
		const pk_wnum =  $("input.pk_wnum").length;
		if(pk_wnum == 0){
            alert("관심상품에 담긴 상품이 없습니다.");
            return;
		}
		
		$.ajax({
			url:"<%= ctxPath%>/product/wishDeleteAll.book",
			type:"POST",
			data:{}, 
			dataType:"JSON",
			success:function(json) {
				if(json.wishDeleteAll == 1) {
					alert("관심상품에 있는 상품들을 모두 비웠습니다.");
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
	}//end of function wishDeleteAll() 
	
	function orderSelect() {
		var cnt = $("input[name='proCheck']:checked").length;
        if(cnt == 0){
            alert("선택된 제품이 없습니다.");
            return;
        }
		const frm = document.cartFrm;
		frm.action = "<%= ctxPath%>/product/wishOrderSelect.book";
		frm.method = "post";
		frm.submit();

	}//end of function orderSelect() 없어도 되는기능
	
	function orderAll() {
		const pk_wnum =  $("input.pk_wnum").length;
		if(pk_wnum == 0){
            alert("제품이 없습니다.");
            return;
		}
		const frm = document.cartFrm;
		frm.action = "<%= ctxPath%>/product/orderAllFromWishList.book";
		frm.method = "post";
		frm.submit();

	}//end of function orderAll()
	
	function orderOne() {
		const frm = document.cartFrm;
		frm.action = "<%= ctxPath%>/product/orderOne.book";
		frm.method = "post";
		frm.submit();

	}//end of function orderOne()
	
	///////////////////////////////////정환모 작업공간(시험용)////////////
	
	//관심상품 선택 탭에 있는 장바구니에 담기 버튼을 눌렀을 때
	function wishToCartOne(pk_wnum) {
		$.ajax({
			url:"<%= ctxPath%>/product/wishToCartOne.book",
			type:"POST",
			data:{"pk_wnum":pk_wnum}, 
			dataType:"JSON",
			success:function(json) {
				if(json.wishToCartOne == 1) {
					alert("장바구니에 제품이 한 개 추가되었습니다.");
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
	}//end of function wishToCartOne(pk_wnum)------------------
	
	// 관심상품에서 선택한 제품을 장바구니로 넘기기
	function  wishToCartSelect(cnt, wishNoStr) {
		$.ajax({
			url:"<%= ctxPath%>/product/wishToCartSelect.book",
			type:"POST",
			data:{"cnt":cnt,
				  "wishNoStr":wishNoStr}, 
			dataType:"JSON",
			success:function(json) {
				if(json.wishToCartSelect == 1) {
					alert("선택한 제품이 장바구니에 담겼습니다.");
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
	}//end of function  wishToCartSelect(cnt, wishNoStr)--------
	
	// 관심상품에서 선택 탭의 주문하기를 클릭할 경우
	function goBuyFromWishList() {
		const frm = document.cartFrm;
		frm.action = "<%= ctxPath%>/product/buyFromWishList.book";
		frm.method = "post";
		frm.submit();
	}; // end of function goBuyFromWishList()------------
	
</script>

<style type="text/css">

	span.wishList_button {
		float: right;
	}

</style>

<jsp:include page="../header.jsp" />
<div class="container">
			
<br>&nbsp;<strong style="font-size: 16pt;">
<img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;관심상품</strong>
<hr style="border: solid 2px #e8e8e8;">

<div class="cartInfo">
	<form name="cartFrm">
		<table class="cartListTbl">
			<thead>
				<tr>
					<td style="width: 4%"><input type="checkbox" id="selectAll" name="selectAll" /></td>
					<td style="width: 10%">이미지</td>
					<td style="width: 30%">상품정보</td>
					<td style="width: 10%">판매가</td>
					<td style="width: 9%">적립금</td>
					<td style="width: 9%">배송구분</td>
					<td style="width: 9%">배송비</td>
					<td style="width: 9%">합계</td>
					<td style="width: 10%">선택</td>
				</tr>
			</thead>
				
			<tbody>
				<%-- 장바구니에 담긴 상품이 없는 경우 --%>
				<c:if test="${empty requestScope.wishList}">
					<tr>
						<td colspan="9">장바구니에 담긴 상품이 없습니다.</td>
					</tr>
				</c:if>
			
				<%-- 장바구니에 담긴 상품이 있는 경우 --%>
				<c:if test="${not empty requestScope.wishList}">
					<c:forEach var="wvo" items="${requestScope.wishList}" varStatus="status">
						<tr>							
							<%-- 체크박스 --%>
							<td> 
								<input type="checkbox" name="proCheck" id="proCheck" value="${wvo.pk_wnum}" />
							</td>
							
							<%-- 이미지 --%>
							<td> 
								<a href="<%=ctxPath%>/product/ShowBookDetail.up?pk_pro_num=${wvo.pk_wnum}">
								<img src="<%=ctxPath%>/images/product/${wvo.category.cate_name}/${wvo.product.pro_imgfile_name}" style="width: 100%"/>
								</a>
							</td>
							
							<%-- 상품정보 --%>
							<td> 
								<a href="<%=ctxPath%>/product/ShowBookDetail.up?pk_pro_num=${wvo.fk_pnum}">
									<span class="cartPname">${wvo.product.pro_name}</span>
								</a>
							</td>
							
							<%-- 판매가 --%>
							<td> 
								<span class="orderPrice"><fmt:formatNumber value="${wvo.product.pro_saleprice}" pattern="###,###" />원</span>
							</td>
							<%-- 적립금 --%>
							<td>
								<span class="orderPrice"><fmt:formatNumber value="${(wvo.product.pro_saleprice)/100}" pattern="###,###" />원</span>
							</td>
							<%-- 배송구분 --%>
							<td>
								기본배송
							</td>
							<%-- 주문수량 + 장바구니 번호(숨김) --%> 
 							<td>
 							3,000원
 							<br>
 							조건
								<%-- <div>
									<input type="number" class="pqty" id="pqty" name="pqty" value="${cvo.ck_odr_qty}" min='1' max='100' />
								</div>
								
								<div>
									<img src="<%= ctxPath %>/images/product/btn_quantity_modify.gif" class="pqty_btn" />
									<input class="pk_cartno" type="hidden" id="pk_cartno" name="pk_cartno" value="${cvo.pk_cartno}" />
									<input class="fk_pro_num" type="hidden" id="fk_pro_num" name="fk_pro_num" value="${cvo.fk_pro_num}" />
									<input class="pro_saleprice" type="hidden" id="pro_saleprice" name="pro_saleprice" value="${cvo.product.pro_saleprice}" />
								</div> --%>
							</td>
							 					 
							<%-- 배송비(주문총액이 5만원 이상이면 무료, 아니면 3000원) --%>
							<%-- <c:if test="${status.first}">
								<td rowspan= "${fn:length(cartList)}" >
									<span class="shippingFee">
										<c:choose>
											<c:when test="${requestScope.totalPrice == 0}">0원</c:when>
											<c:when test="${requestScope.totalPrice >= 50000}"> 무료 </c:when>
											<c:when test="${requestScope.totalPrice < 50000}">3,000원</c:when>
										</c:choose>
									</span>
								</td>
							</c:if>  --%>
							<td>
								<span class="totalPrice"><fmt:formatNumber value="${wvo.product.pro_saleprice + 3000}" pattern="###,###" />원</span>
								<div>
									<input class="pk_wnum" type="hidden" id="pk_wnum" name="pk_wnum" value="${wvo.pk_wnum}" />
									<input class="fk_pnum" type="hidden" id="fk_pnum" name="fk_pnum" value="${wvo.fk_pnum}" />
									<input class="pro_saleprice" type="hidden" id="pro_saleprice" name="pro_saleprice" value="${wvo.product.pro_saleprice}" />
								</div>
							</td>
							
							
							<%-- 선택 --%>
							<td style="vertical-align: middle">
								<div id="btn_odr" ><img src="<%= ctxPath %>/images/product/btn_order.gif" /></div>
								<input class="pk_wnum" type="hidden" id="pk_wnum" name="pk_wnum" value="${wvo.pk_wnum}" />
								<div id="btn_wish"><img src="<%= ctxPath %>/images/member/btn_basket.gif" style="cursor: pointer;"/></div>
								<div id="btn_delete"><img src="<%= ctxPath %>/images/product/btn_delete.gif" /></div>
							</td>
						</tr>
					</c:forEach>
					<input class="pk_wnum" type="hidden" id="wishnoOne" name="wishnoOne" value="" />
				</c:if>
				
			</tbody>
			
			<tfoot>
				<tr style="border-bottom: none;">
					<td colspan="3" class="text-left">
						<span id="deleteSelect">
							선택상품&nbsp;&nbsp;<img src="<%= ctxPath %>/images/product/btn_delete2.gif" />&nbsp;
						</span>
						<span id="addToCartSelect">
						<img src="<%= ctxPath %>/images/member/btn_basket.gif" style="cursor: pointer;"/>
						</span>
						
					</td>
					<td colspan="6" class="text-right">
						<span class="wishList_button"><img src="<%= ctxPath %>/images/member/btn_order_empty.gif" style="cursor: pointer;" onclick="wishDeleteAll()" />&nbsp;&nbsp;
						<img src="<%= ctxPath %>/images/member/btn_order_all.gif" style="cursor: pointer;" onclick="orderAll()"/>
						</span>
						<%-- <span>
							<img src="<%= ctxPath %>/images/product/btn_clear.gif" onclick="cartDeleteAll()"/>
						</span> --%>
					</td>
				</tr>	
			</tfoot>	
		</table>
	</form>
	
	<%-- <span class="interested_choice">
			<strong>선택상품을</strong><img src="<%= ctxPath %>/images/member/btn_delete2.gif" style="cursor: pointer;" /><img src="<%= ctxPath %>/images/member/btn_basket2.gif"  style="cursor: pointer;"/>
		</span>
	<span class="interested_order"><img src="<%= ctxPath %>/images/member/btn_order_empty.gif" style="cursor: pointer;" />&nbsp;&nbsp;<img src="<%= ctxPath %>/images/member/btn_order_all.gif" style="cursor: pointer;" />
		</span> --%>
		
</div>

<%-- <div class="order">
	<span>
		<img src="<%= ctxPath %>/images/product/btn_order_all.gif" onclick="orderAll()" />&nbsp;&nbsp;
		<img src="<%= ctxPath %>/images/product/btn_order_select.gif" onclick="orderSelect()" />
	</span>
</div>

<div  class="shoppingContinue">
	<a href="<%= ctxPath%>/index.book">
		<img src="<%= ctxPath %>/images/product/btn_order_ing.gif" />
	</a>
</div> --%>
	
</div>
<jsp:include page="/WEB-INF/footer.jsp" />