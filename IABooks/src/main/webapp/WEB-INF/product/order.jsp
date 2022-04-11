<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<title>주문서작성</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
<!-- 내가만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_order.css" /> 
<!-- Optional JavaScript-->
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>	
<script type="text/javascript">
	$(document).ready(function(){
		
		//회원정보동일 버튼클릭시 발생
		$("input#user_address").click(function() {
			userAddress();
		});
		
		$("input#new_address").click(function() {
			newAddress();
		});
		
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
        		
		//선택상품 삭제		
		$("span#deleteSelect").click(function () {
			var cnt = $("input[name='proCheck']:checked").length;
	      	var cartNoArr = new Array();
	        $("input[name='proCheck']:checked").each(function() {
	        	cartNoArr.push($(this).val());
	        });
	        if(cnt == 0){
	            alert("선택된 제품이 없습니다.");
	        }
	        const cartNoStr = cartNoArr.join();
	        
	        proDeleteSelect(cnt, cartNoStr);
		});//end of $("li#btn_delete").click(function ()		
		
		$("select#coupon").on("change", function() {	
			const couponid =  $(this).val();
			let cprice = Number($("select#coupon > option:selected").attr("value2") );
			const cminprice = Number($("select#coupon > option:selected").attr("value3") );
			let totalprice = Number($("input#totalprice").val() );
			if(cminprice <= totalprice){
				totalprice = totalprice - cprice;
				$("input#paymentPrice").val(totalprice);
				$("input#useCouponId").val(couponid);
				totalprice = totalprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				cprice = cprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$("span#lastPrice").text(totalprice+"원");
				$("span#discount").text(cprice+"원");
				
			}else if(couponid == "") {
				$("input#paymentPrice").val(totalprice);
				totalprice = totalprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$("span#lastPrice").text(totalprice+"원");
				$("span#discount").text(0+"원");
			}else{
				alert("최소사용금액보다 주문금액이 낮습니다.");
				$("input#paymentPrice").val(totalprice);
				totalprice = totalprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$("span#lastPrice").text(totalprice+"원");
				$("span#discount").text(0+"원");
				
			}
			
		});//end of $("select#coupon").on("change", function()
				
	});//end of $(document).ready(function()

	function openDaumPOST() {

		new daum.Postcode({
			oncomplete: function (data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				let addr = ''; // 주소 변수
				let extraAddr = ''; // 참고항목 변수
	
				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}
	
				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("extraAddress").value = extraAddr;
					
				} else {
					document.getElementById("extraAddress").value = '';
				}
	
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postcode').value = data.zonecode;
				document.getElementById("address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("detailAddress").focus();
			}
		}).open();

	}// end of openDaumPOST()

	function detailOrder() {
		$("div.deiailOrderBox").show();
	}//end of function detailOrder()

	function userAddress() {//회원 정보와 동일
	//"${sessionScope.loginuser.userid}"
	
	$("input#name").val("${sessionScope.loginuser.name}");
	$("input#postcode").val("${sessionScope.loginuser.postcode}");
	$("input#address").val("${sessionScope.loginuser.address}");
	$("input#detailAddress").val("${sessionScope.loginuser.detailaddress}");
	$("input#extraAddress").val("${sessionScope.loginuser.extraaddress}");
	
	var phone = "${sessionScope.loginuser.phone}";
	phone = phone.split("-");
	$("input#hp1").val(phone[0]);
	$("input#hp2").val(phone[1]);
	$("input#hp3").val(phone[2]);
	
	$("input#email").val("${sessionScope.loginuser.email}");

	}//end of userInfo()
	
	function newAddress() {
		$("input#name").val("");
		$("input#postcode").val("");
		$("input#address").val("");
		$("input#detailAddress").val("");
		$("input#extraAddress").val("");
		$("input#hp2").val("");
		$("input#hp3").val("");
		$("input#email").val("");
		
	}//end of function newAddress()
	
	function payment() {//결제버튼 클릭
		if(	$("input#name").val().trim() == "" || $("input#postcode").val().trim() == "" || $("input#address").val().trim() == "" 
			|| $("input#detailAddress").val().trim() == "" || $("input#extraAddress").val().trim() == "" || $("input#hp2").val().trim() == "" 
			|| $("input#hp3").val().trim() == "" || $("input#email").val().trim() == "" ){
			
			alert("필수입력사항을 모두 입력해주세요")
			return;
			
		}
		 var frm = document.paymentFrm;
		 frm.action ="<%= ctxPath%>/product/payment.book";
		 frm.method="post";
		// frm.target="paymentFrm";
		 frm.submit(); 
	
	}//end of function payment() 
	
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
	
	
</script>

<style type="text/css">

	
/* 회원 */


 table.cartListTbl {
	width: 100%;
	margin-top: 30px;
	margin-bottom: 10px;
}

table.cartListTbl td {
	text-align: center;
	padding-left: 10px;
	height: 100px;
	
}
table.cartListTbl span {
color: #212529;
}

table.cartListTbl a:hover {
text-decoration-line: none;
}

table.cartListTbl img {
cursor: pointer;
}

table.cartListTbl > tfoot > tr:first-child td {
	height: 70px;
	background-color: #FBFAFA;
	padding-right: 10px;
}

table.cartListTbl > tfoot > tr:last-child td {
	height: 90px;
	vertical-align: top;
	padding-right: 10px;
	padding-top: 10px;
	font-size: 15px;
}

table.cartListTbl .pqty{
width: 50px;
height: 26px;
padding-left: 2px;

}

table.cartListTbl > thead > tr > td {
	height: 50px;
	background-color: #FBFAFA;
}

table.cartListTbl  tr {
	border-top: solid 2px #e8e8e8;
}

table.cartListTbl tr:last-child {
	border-bottom: solid 2px #e8e8e8;
}


table.cartTotalTbl {
width: 100%;
}

table.cartTotalTbl tr:first-child td {
	text-align: left;
	padding-left:50px;
	height: 50px;
	background-color: #FBFAFA;
}

table.cartTotalTbl tr:last-child td {
	text-align: left;
	padding-left:50px;
	height: 70px;
	font-weight: bold;
	font-size: 24px;
}

table.cartTotalTbl  tr {
	border-top: solid 2px #e8e8e8;
}

table.cartTotalTbl tr:last-child {
	border-bottom: solid 2px #e8e8e8;
}

	div.order {
	 text-align: center;
	 margin: 20px 0px 200px 0px ;
	}
	
	div.order span:last-child {
	position: relative;
	right: 10px;
	float: right;
	text-align: right;
	}
	
	div.order img {
	cursor: pointer;
	}

/* 상품없음 */
table.interested_none { 
	width: 100%;
	margin-top: 30px;
	margin-bottom: 10px;
}

table.interested_none td {
	text-align: center;
	height: 100px;
}

table.interested_none tr {
	border-top: solid 2px #e8e8e8;
	border-bottom: solid 2px #e8e8e8;
}




/*  페이징 CSS 중복   */

	div.pagination {
	  display: inline-block;
	  width: 100%;
	  text-align: center;
	  margin: 20px 0;
	}
	
	div.pagination a {
	  color: black;
	  text-decoration: none;
	  width: 32px;
	  height: 32px;
	  text-align: center;
	}
	
	div.pagination a.active {
		border-bottom: solid 2px black;
	  	
	}
	
	div.pagination a img {
		margin-top: -4px;
		vertical-align: middle;
	
	}
	
	div.pagination a:hover {
		font-weight: bolder;
		opacity: 0.3;
	}
	
	
</style>

<jsp:include page="/WEB-INF/header.jsp"/>

	<div class="container">
	<div class="titleArea">
		<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;마이 쇼핑</strong>
		<hr style="border: solid 2px #e8e8e8; margin-bottom: 3%;">
    </div>
	
	<div class="orderImg">
		<img src="<%= ctxPath %>/images/product/order.jpg" />
	</div>
		
	<form name="paymentFrm">
		<table class="benefit_info">
			<tr>
				<td>
					<span style="padding-left: 30px;">혜택정보</span>
					<img src="<%= ctxPath%>/images/bar_eee.gif" style="width: 2px; height: 20px;" />
					가용적립금 : <span><a>0</a></span>
					쿠폰 : <span><a>0</a></span>
				</td>
			</tr>
		</table>
		
		<!-- 영준님 테이블 가져오기 -->



		<table class="cartListTbl">
			<thead>
				<tr>
					<td style="width: 4%"><input type="checkbox" id="selectAll" name="selectAll" /></td>
					<td style="width: 10%">이미지</td>
					<td style="width: 30%">상품정보</td>
					<td style="width: 10%">판매가</td>
					<td style="width: 6%">수량</td>
					<td style="width: 10%">적립금</td>
					<td style="width: 10%">배송비</td>
					<td style="width: 10%">합계</td>
				</tr>
			</thead>
				
			<tbody>
				
				<c:forEach var="cvo" items="${requestScope.order}" varStatus="status">
					<tr>							
						<%-- 체크박스 --%>
						<td> 
							<input type="checkbox" name="proCheck" id="proCheck" value="${cvo.pk_cartno}" />
							<input type="hidden" id="pk_cartno" name="pk_cartno" value="${cvo.pk_cartno}"/>
						</td>
						
						<%-- 이미지 --%>
						<td> 
							<a href="<%=ctxPath%>/product/ShowBookDetail.up?pk_pro_num=${cvo.fk_pro_num}">
							<img src="<%=ctxPath%>/images/product/${cvo.category.cate_name}/${cvo.product.pro_imgfile_name}" style="width: 100%"/>
							<input type="hidden" name="fk_pro_num" id="fk_pro_num" value="${cvo.fk_pro_num}" />
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
							<span class="pqty">${cvo.ck_odr_qty}</span>
							<input type="hidden" id="pqty" name="pqty" value="${cvo.ck_odr_qty}"/>
						
						<%-- 적립금 --%>
						<td> 
							<span id="totalPoint">${cvo.totalPoint}p</span>
							<input type="hidden" id="point" name="point" value="${cvo.totalPoint}"/>
						</td>
						 					 
						<%-- 배송비(주문총액이 5만원 이상이면 무료, 아니면 3000원) --%>
						<c:if test="${status.first}">
							<td rowspan= "${fn:length(cartList)}" >
								<span class="shippingFee">
									<c:if test="${requestScope.totalPrice >= 50000}">무료</c:if>
									<c:if test="${requestScope.totalPrice < 50000}">3,000원</c:if>
								</span>
							</td>
						</c:if>
						<%-- 주문총액 --%>
						<td>
							<span id="partsaleprice"><fmt:formatNumber value="${cvo.partPrice}" pattern="###,###" />원</span>
							<input type="hidden" id="partPrice" name="partPrice" value="${cvo.partPrice}"/>
						</td>
					</tr>
				</c:forEach>
				
			
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
							<c:if test="${requestScope.totalPrice >= 50000}">무료</c:if>
							<c:if test="${requestScope.totalPrice < 50000}">3,000원</c:if>
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
							<img src="<%= ctxPath %>/images/product/btn_prev.gif" onclick=""/>
						</span>	
					</td>
				</tr>	
			</tfoot>	
		</table>
		
		<hr style="border: solid 1px black;">	
		
		<strong style="font-size: 12pt; padding-left: 20px;">배송정보</strong>
			<p class="floatR"><span id="star">*</span> 필수입력사항</p>
			<table class="shipping_info">
				<tr>
					<th>배송지선택&nbsp;</th>
					<td>
						<input type="radio" id="user_address" name="shippingInfo"required autocomplete="off" />&nbsp; <label class="title" for="user_address">회원정보와 동일</label>&nbsp;&nbsp;    
						<input type="radio" id="new_address" name="shippingInfo" required autocomplete="off" />&nbsp; <label class="title" for="new_address">새로운 배송지</label>
					</td>    
				</tr>
				<tr>
					<th>받으시는분&nbsp;<span id="star">*</span></th>
				    <td>
				        <input required type="text" value="" name="name" id="name" maxlength="20" />
				        <input required type="hidden" value="${sessionScope.loginuser.userid}" name="userid" id="userid" maxlength="20" />
				    </td>
				</tr>
				<tr>
					<th>우편번호</th>
			      	<td>
			        	<input required type="text" id="postcode" name="postcode" size="5" placeholder="우편번호" value="" style="width: 100px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
			         	&nbsp;&nbsp;
			         	<img src="<%= ctxPath %>/images/product/btn_zipcode.gif" style="cursor: pointer;" onclick="openDaumPOST();"/>
			      	</td>
				</tr>
				<tr>
					<th id="register">주소 &nbsp;<span id="star">*</span></th>
					<td>
						<input class="my-1" required type="text" id="address" name="address" size="50" placeholder="주소" /><br>
						<input class="my-1" type="text" id="detailAddress" name="detailAddress" size="50" placeholder="상세주소" /><br>
						<input class="my-1" type="text" id="extraAddress" name="extraAddress" size="50" placeholder="참고항목" />                
					</td>
				</tr>
				<tr>
					<th>휴대전화 &nbsp;<span id="star">*</span></th>
			        <td>
			        	<select id="hp1" name="hp1">
							<option value="010">010</option>
						</select>&nbsp;-&nbsp;
						<input class="requiredInfo" required id="hp2" name="hp2" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">&nbsp;-&nbsp; 
						<input class="requiredInfo" required id="hp3" name="hp3" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
					 </td>
				</tr>
				<tr>
					<th>이메일 &nbsp;<span id="star">*</span></th>
					<td>
						<input type="email" class="myinput" id="email" name="email" size="20" maxlength="20" required placeholder="email@gmail.com" />
						<br>이메일을 통해 주문처리과정을 보내드립니다. 
						<br>이메일 주소란에는 반드시 수신가능한 이메일주소를 입력해 주세요.
					</td>
				</tr>
				            
				<tr>
			        <th>배송메세지</th>
			        <td>
			        	<textarea maxlength="255"></textarea>
			        </td>
			    </tr>
			</table>
		
			<strong style="font-size: 12pt;">결제 예정 금액</strong>
			<table class="paymentExpected">
				<thead>
					<tr>
						<td>적립금사용</td>
						<td colspan="2"><input /><div></div></td>
					</tr>
					<tr>
					
						<td>쿠폰사용</td>
						<td colspan="2">
							<select id="coupon" name="coupon">
								<option value="">사용가능한 쿠폰</option>
								<c:forEach var="cpvo" items="${requestScope.userCoupon}" varStatus="status">
									<option value="${cpvo.couponid}" value2="${cpvo.cprice}" value3="${cpvo.cminprice}">
										${cpvo.cname} : <fmt:formatNumber value="${cpvo.cprice}" pattern="###,###" />원&nbsp;
										최소사용금액 : <fmt:formatNumber value="${cpvo.cminprice}" pattern="###,###" />원
									</option>
								</c:forEach>
							</select>		
						</td>
						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<strong>총 주문 금액</strong>
						</td>
						<td>
							<strong>총 할인 + 부가결제 금액</strong>
						</td>
						<td>
							<strong>총 결제예정 금액</strong>
						</td>
					</tr>
					
					<tr>
						<td>
							<span class="finalPrice"><fmt:formatNumber value="${requestScope.finalPrice}" pattern="###,###" />원</span>
							<input required type="hidden" value="${requestScope.finalPrice}" name="totalprice" id="totalprice" maxlength="20" />
						</td>
						<td>
							- <span id="discount">0원</span>
							<input type="hidden" name="useCouponId" id="useCouponId" value="" />
						</td>
						<td>
							= <span class="finalPrice" id="lastPrice" ><fmt:formatNumber value="${requestScope.finalPrice}" pattern="###,###" />원</span>
							<input type="hidden" name="paymentPrice" id="paymentPrice" value="${requestScope.finalPrice}" />
						</td>
					</tr>
				</tbody>
			</table>
	
			<div class="btn_order"><img src="<%= ctxPath%>/images/member/btn_place_order.gif" onclick="payment()"  ></div>
	</form>
	
</div><%--<div class="container"> end  --%>

<jsp:include page="/WEB-INF/footer.jsp"/>
 