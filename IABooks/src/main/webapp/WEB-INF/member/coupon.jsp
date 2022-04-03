<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/WEB-INF/header.jsp"/>
<!-- 내가만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />


<script type="text/javascript">


function generateCoupon(userid) {
	
//	alert(userid);
	
	// 쿠폰생성
	const url = "<%= request.getContextPath()%>/member/generateCoupon.book?userid="+userid;
	
	// 너비 800, 높이 600 인 팝업창을 화면 가운데 위치시키기
	const pop_width = 800;
	const pop_height = 600;
	const pop_left = Math.ceil( ((window.screen.width)-pop_width)/2 ) ; <%-- 정수로 만든다 --%>
	const pop_top = Math.ceil( ((window.screen.height)-pop_height)/2 ) ;
	
	window.open(url, "memberEdit",
			   	"left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height );
	
}; // end of function generateCoupon()

	
</script>

<style type="text/css">

	a.admin_coupon {
		margin-top: 20px;
		width: 200px;
		height: 36px;
		background-color: #1a6dff;
		color: white;
		font-weight: bold;
		float: right;
		border: none;
		text-align: center;
		padding-top: 5px;
		
	}

</style>

<title>쿠폰조회</title>



<div class="container">
	<c:if test="${sessionScope.loginuser.userid eq 'admin'}">
		<a class="admin_coupon" href="javascript:generateCoupon('${(sessionScope.loginuser).userid}');" >coupon 발급하기</a>
	</c:if>
	<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;마이쿠폰</strong>
	<hr style="border: solid 2px #e8e8e8;">
	
	<strong>마이 쿠폰 목록</strong><p style="float: right;">사용가능 쿠폰 <span>${fn:length(session.loginuser.coupon)}</span> 장</p>
	
	<table class="coupon">
		<thead>
			<tr>
				<td>번호</td>
				<td>쿠폰명</td>
				<td>쿠폰적용상품</td>
				<td>구매금액</td>
				<td>결제수단</td>
				<td>쿠폰혜택</td>
				<td>사용가능기간</td>
			</tr>
		</thead>
		<tbody>		
			<c:if test="${fn:length(session.loginuser.coupon) > 0}">
			<tr>
				<td align="center">번호</td>
				<td align="center">쿠폰명</td>
				<td align="center">쿠폰적용상품</td>
				<td align="center">구매금액</td>
				<td align="center">결제수단</td>
				<td align="center">쿠폰혜택</td>
				<td align="center">사용가능기간</td>
			</tr>
			</c:if>
			<c:if test="${fn:length(session.loginuser.coupon) == 0}">
			<tr>
				<td colspan="7" align="center">
					보유하고 계신 쿠폰내역이 없습니다.
				</td>
			</tr>
			</c:if>
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
	
	
	
	
<jsp:include page="/WEB-INF/footer.jsp"/>
 