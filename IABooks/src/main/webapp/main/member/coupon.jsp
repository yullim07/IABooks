<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>
 <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 내가만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_header_footer.css" />

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="<%= ctxPath %>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">


<script type="text/javascript">

</script>

<style type="text/css">
</style>

<title>쿠폰조회</title>

<jsp:include page="/header.jsp"/>

<div class="container">
	<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;마이쿠폰</strong>
	<hr style="border: solid 2px #e8e8e8;">
	
	<strong>마이 쿠폰 목록</strong><p style="float: right;">사용가능 쿠폰 <span></span>장</p>
	
	<table class="coupon">
		<thead>
			<tr>
				<td>번호</td>
				<td>쿠폰명</td>
				<td>쿠폰적용 상품</td>
				<td>구매금액</td>
				<td>결제수단</td>
				<td>쿠폰혜택</td>
				<td>사용가능기간</td>
			</tr>
		</thead>
		<tbody>		
			<tr>
				<td colspan="7" align="center">
					보유하고 계신 쿠폰내역이 없습니다.
				</td>
			</tr>
		</tbody>	
	</table>
	
	<div class="pagination pagination-sm justify-content-center">
	  <a href="#"><img src="<%= ctxPath %>/images/member/btn_page_first.gif" /></a>
	  <a href="#"><img src="<%= ctxPath %>/images/member/btn_page_prev.gif" /></a>
	  <a class="active" href="#">1</a>
	  <a href="#"><img src="<%= ctxPath %>/images/member/btn_page_next.gif" /></a>
	  <a href="#"><img src="<%= ctxPath %>/images/member/btn_page_last.gif" /></a>
	</div>
	
	<br><br>
	<strong>쿠폰인증번호 등록하기</strong>
	<table class="couponKey" >
		<tr>
			<td>
				<input type="text" style="height: 40px; width: 350px;"/>
				<img src="<%= ctxPath %>/images/member/btn_coupon_serial.gif" />
			</td>
		</tr>
		<tr>
			<td>반드시 쇼핑몰에서 발행한 쿠폰번호만 입력해주세요. (10~35자 일련번호 "-" 제외)</td>
		</tr>
	</table>
	
	<table class="couponInfo">
		<tr>
			<td>쿠폰이용안내</td>
		</tr>
		<tr>
			<td>
				<ol>
					<li><strong>쿠폰인증번호 등록하기</strong>에서 쇼핑몰에서 발행한 종이쿠폰/시리얼쿠폰/모바일쿠폰 등의 인증번호를 등록하시면 온라인쿠폰으로 발급되어 사용이 가능합니다.</li>
					<li>쿠폰은 주문 시 1회에 한해 적용되며, 1회 사용 시 재 사용이 불가능합니다.</li>
					<li>쿠폰은 적용 가능한 상품이 따로 적용되어 있는 경우 해당 상품 구매 시에만 사용이 가능합니다.</li>
					<li>특정한 종이쿠폰/시리얼쿠폰/모바일쿠폰의 경우 단 1회만 사용이 가능할 수 있습니다.</li>
				</ol>
			</td>
		</tr>
	
	</table>



</div>
	
	
	
	
<jsp:include page="/footer.jsp"/>
 