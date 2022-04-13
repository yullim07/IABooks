<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<title>in사과::결제완료</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
<!-- 내가만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_order.css" /> 
<!-- Optional JavaScript-->
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>	
<script type="text/javascript">

</script>

<style type="text/css">
.shipping_info tr {
	height: 80px;
}

#paymentExpected tr td {
    width: 20%;
    text-align: center;
}
</style>

<jsp:include page="/WEB-INF/header.jsp"/>

<div class="container">
	<div class="titleArea">
		<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;주문완료</strong>
		<hr style="border: solid 2px #e8e8e8; margin-bottom: 3%;">
    </div>
	
	<div class="orderImg">
		<img src="<%= ctxPath %>/images/product/orderEnd.jpg" />
	</div>
		
		<div style="margin: 100px 20%; text-align: center;">
			<div style="font-size: 35px; font-weight: bold; line-height: 100px;">고객님 의 주문이 완료 되었습니다.</div>
			<div style="font-size: 20px;">주문내역 및 배송에 관한 안내는 주문조회를 통해서 확인 가능합니다.</div>
			<div style="font-size: 20px;">주문자번호 : ${requestScope.odrcode}</div>
			<div style="font-size: 20px;">주문일자 : ${requestScope.ordDate}</div>
		</div>
		<%-- 
		<strong style="font-size: 12pt; padding-left: 20px;">주문상품정보</strong>
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
						체크박스
						<td> 
							<input type="checkbox" name="proCheck" id="proCheck" value="${cvo.pk_cartno}" />
							<input type="hidden" id="pk_cartno" name="pk_cartno" value="${cvo.pk_cartno}"/>
						</td>
						
						이미지
						<td> 
							<a href="<%=ctxPath%>/product/ShowBookDetail.up?pk_pro_num=${cvo.fk_pro_num}">
							<img src="<%=ctxPath%>/images/product/${cvo.category.cate_name}/${cvo.product.pro_imgfile_name}" style="width: 100%"/>
							<input type="hidden" name="fk_pro_num" id="fk_pro_num" value="${cvo.fk_pro_num}" />
							</a>
						</td>
						
						상품정보
						<td> 
							<a href="<%=ctxPath%>/product/ShowBookDetail.up?pk_pro_num=${cvo.fk_pro_num}">
								<span class="cartPname">${cvo.product.pro_name}</span>
							</a>
						</td>
						
						판매가
						<td> 
							<span class="orderPrice"><fmt:formatNumber value="${cvo.product.pro_saleprice}" pattern="###,###" />원</span>
						</td>
						
						주문수량 + 장바구니 번호(숨김) 
						<td>
							<span class="pqty">${cvo.ck_odr_qty}</span>
							<input type="hidden" id="pqty" name="pqty" value="${cvo.ck_odr_qty}"/>
						
						적립금
						<td> 
							<span id="totalPoint">${cvo.totalPoint}p</span>
							<input type="hidden" id="point" name="point" value="${cvo.totalPoint}"/>
						</td>
						 					 
						배송비(주문총액이 5만원 이상이면 무료, 아니면 3000원)
						<c:if test="${status.first}">
							<td rowspan= "${fn:length(cartList)}" >
								<span class="shippingFee">
									<c:if test="${requestScope.totalPrice >= 50000}">무료</c:if>
									<c:if test="${requestScope.totalPrice < 50000}">3,000원</c:if>
								</span>
							</td>
						</c:if>
						주문총액
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
			</tfoot>	
		</table>
		 --%>
		<table class="paymentExpected" id="paymentExpected">
				<tbody>
					<tr>
						<td>
							<strong>총 주문 금액</strong>
						</td>
						<td>
							<strong>배송비</strong>
						</td>
						<td>
							<strong>할인</strong>
						</td>
						<td>
							<strong>총 결제 금액</strong>
						</td>
					</tr>
					
					<tr>
						<td>
							<span class="finalPrice"><fmt:formatNumber value="${requestScope.totalPrice}" pattern="###,###" />원</span>
						</td>
						<td>
							<c:if test="${requestScope.totalPrice >= 50000}">무료</c:if>
							<c:if test="${requestScope.totalPrice < 50000}">3,000원</c:if>
						</td>
						<td>
							<span class="finalPrice"><fmt:formatNumber value="${requestScope.totalSale}" pattern="###,###" />원</span>
						</td>
						<td>
							<span class="finalPrice" id="lastPrice" ><fmt:formatNumber value="${requestScope.finalPrice}" pattern="###,###" />원</span>	
						</td>
					</tr>
				</tbody>
			</table>
		
		
		<strong style="font-size: 12pt; padding-left: 20px;">배송정보</strong>
			<table class="shipping_info">
				<tr>
					<th>받으시는분&nbsp;<span id="star">*</span></th>
				    <td>${requestScope.name}</td>
				</tr>
				<tr>
					<th>우편번호</th>
			      	<td>${requestScope.postcode}</td>
				</tr>
				<tr>
					<th id="register">주소 &nbsp;<span id="star">*</span></th>
					<td>${requestScope.address}</td>
				</tr>
				<tr>
					<th>휴대전화 &nbsp;<span id="star">*</span></th>
			        <td>${requestScope.phone}</td>
				</tr>
				<tr>
					<th>이메일 &nbsp;<span id="star">*</span></th>
					<td>${requestScope.email}</td>
				</tr>
				            
				<tr>
			        <th>배송메세지</th>
			        <td>${requestScope.deliveryMsg}</td>
			    </tr>
			</table>
	
			<div style="text-align: center; margin-bottom: 30px;">
				<a href="<%= ctxPath%>/index.book">
					<img src="<%= ctxPath %>/images/product/btn_order_ing.gif" />
				</a>
			</div>
			
			<br>
	
</div><%--<div class="container"> end  --%>

<jsp:include page="/WEB-INF/footer.jsp"/>



<div>총액 : ${requestScope.finalPrice}</div>

